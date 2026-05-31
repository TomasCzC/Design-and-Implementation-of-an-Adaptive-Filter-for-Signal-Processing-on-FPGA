-- ============================================================================
-- Entity: fft_processor.vhd
-- Implements fft_mag functionality from fft_utils.py
-- Computes single-sided FFT magnitude spectrum
-- ============================================================================
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.MATH_REAL.ALL;
use work.dsp_constants_and_types.all;

entity fft_processor is
    generic (
        FFT_SIZE        : integer := FFT_POINTS;
        INPUT_WIDTH     : integer := DATA_WIDTH;
        TWIDDLE_WIDTH   : integer := 18;
        OUTPUT_WIDTH    : integer := DATA_WIDTH
    );
    port (
        clk             : in  std_logic;
        reset_n         : in  std_logic;
        
        -- Control Interface
        start           : in  std_logic;
        busy            : out std_logic;
        done            : out std_logic;
        valid_out       : out std_logic;
        
        -- Input Data Stream
        data_in_valid   : in  std_logic;
        data_in         : in  fix_point;
        data_in_last    : in  std_logic;
        
        -- Output: Frequency bins (magnitude)
        freq_out_addr   : out integer range 0 to FFT_SIZE/2;
        freq_out_data   : out fix_point;
        freq_out_valid  : out std_logic;
        
        -- Sampling frequency input (for frequency axis calculation)
        sampling_freq   : in  fix_point;
        
        -- Status
        error           : out std_logic
    );
end entity;

architecture rtl of fft_processor is
    
    -- Internal Types
    type state_type is (ST_IDLE, ST_LOAD_INPUT, ST_COMPUTE_FFT, 
                        ST_CALC_MAGNITUDE, ST_OUTPUT_RESULTS, ST_DONE);
    
    -- Signal Declarations
    signal current_state   : state_type := ST_IDLE;
    signal next_state      : state_type;
    
    -- Input Buffer (Dual-port RAM)
    type input_ram_type is array (0 to FFT_SIZE-1) of fix_point;
    signal input_buffer    : input_ram_type := (others => (others => '0'));
    signal write_addr      : integer range 0 to FFT_SIZE-1 := 0;
    signal read_addr       : integer range 0 to FFT_SIZE-1 := 0;
    signal sample_count    : integer range 0 to FFT_SIZE := 0;
    
    -- FFT Butterfly Stage Storage
    type butterfly_ram is array (0 to FFT_SIZE-1) of complex_fix;
    signal fft_data        : butterfly_ram := (others => ((others => '0'), (others => '0')));
    signal fft_stage       : integer range 0 to integer(log2(real(FFT_SIZE))) := 0;
    signal butterfly_count : integer range 0 to FFT_SIZE-1 := 0;
    
    -- Twiddle Factor ROM (precomputed)
    type twiddle_rom_type is array (0 to FFT_SIZE/2-1) of complex_fix;
    signal twiddle_rom     : twiddle_rom_type;
    
    -- Magnitude Output Buffer
    type mag_ram_type is array (0 to FFT_SIZE/2) of fix_point;
    signal magnitude_buf   : mag_ram_type := (others => (others => '0'));
    signal mag_output_addr : integer range 0 to FFT_SIZE/2 := 0;
    
    -- Normalization factor
    signal norm_factor     : fix_point;
    
begin
    
    -- Initialize Twiddle Factors ROM (W_N^kn = e^{-j*2*pi*k*n/N})
    process(clk)
        variable angle : real;
        variable idx   : integer;
    begin
        if rising_edge(clk) then
            for k in 0 to FFT_SIZE/2-1 loop
                angle := -2.0 * MATH_PI * real(k) / real(FFT_SIZE);
                twiddle_rom(k).re <= to_fixpoint(cos(angle));
                twiddle_rom(k).im <= to_fixpoint(sin(angle));
            end loop;
        end if;
    end process;
    
    -- Calculate normalization factor (1/N)
    norm_factor <= to_fixpoint(1.0 / real(FFT_SIZE));
    
    -- State Machine
    process(clk, reset_n)
        variable temp_re, temp_im : signed(DATA_WIDTH+1 downto 0);
        variable twiddle_idx      : integer;
        variable group_size       : integer;
        variable half_group       : integer;
        variable butterfly_base   : integer;
        variable top_idx, bot_idx : integer;
        variable top_val, bot_val : complex_fix;
        variable mult_re, mult_im : signed(2*DATA_WIDTH-1 downto 0);
        variable butterfly_result_top, butterfly_result_bot : complex_fix;
    begin
        if reset_n = '0' then
            current_state <= ST_IDLE;
            busy         <= '0';
            done         <= '0';
            valid_out    <= '0';
            error        <= '0';
            write_addr   <= 0;
            sample_count <= 0;
            fft_stage    <= 0;
            butterfly_count <= 0;
            mag_output_addr <= 0;
            
        elsif rising_edge(clk) then
            
            case current_state is
                
                when ST_IDLE =>
                    done      <= '0';
                    valid_out <= '0';
                    error     <= '0';
                    
                    if start = '1' then
                        current_state <= ST_LOAD_INPUT;
                        busy <= '1';
                        write_addr <= 0;
                        sample_count <= 0;
                    end if;
                
                when ST_LOAD_INPUT =>
                    -- Load samples into buffer
                    if data_in_valid = '1' and sample_count < FFT_SIZE then
                        input_buffer(write_addr) <= data_in;
                        write_addr <= write_addr + 1;
                        sample_count <= sample_count + 1;
                        
                        if data_in_last = '1' or sample_count = FFT_SIZE-1 then
                            current_state <= ST_COMPUTE_FFT;
                            -- Copy to FFT working memory as complex (imag = 0)
                            for i in 0 to FFT_SIZE-1 loop
                                fft_data(i).re <= input_buffer(i);
                                fft_data(i).im <= (others => '0');
                            end loop;
                            fft_stage <= 0;
                            butterfly_count <= 0;
                        end if;
                    end if;
                
                when ST_COMPUTE_FFT =>
                    -- Radix-2 Decimation-in-Time FFT
                    group_size := 2 ** (fft_stage + 1);
                    half_group := group_size / 2;
                    
                    butterfly_base := (butterfly_count / half_group) * group_size + 
                                      (butterfly_count mod half_group);
                    top_idx := butterfly_base;
                    bot_idx := butterfly_base + half_group;
                    
                    top_val := fft_data(top_idx);
                    bot_val := fft_data(bot_idx);
                    
                    twiddle_idx := (butterfly_count mod half_group) * (FFT_SIZE / group_size);
                    
                    -- Complex multiplication: bottom * twiddle
                    mult_re := (bot_val.re * twiddle_rom(twiddle_idx).re) - 
                               (bot_val.im * twiddle_rom(twiddle_idx).im);
                    mult_im := (bot_val.re * twiddle_rom(twiddle_idx).im) + 
                               (bot_val.im * twiddle_rom(twiddle_idx).re);
                    
                    -- Butterfly computation
                    butterfly_result_top.re := resize(top_val.re + 
                        mult_re(FRAC_BITS+DATA_WIDTH-1 downto FRAC_BITS), DATA_WIDTH);
                    butterfly_result_top.im := resize(top_val.im + 
                        mult_im(FRAC_BITS+DATA_WIDTH-1 downto FRAC_BITS), DATA_WIDTH);
                    
                    butterfly_result_bot.re := resize(top_val.re - 
                        mult_re(FRAC_BITS+DATA_WIDTH-1 downto FRAC_BITS), DATA_WIDTH);
                    butterfly_result_bot.im := resize(top_val.im - 
                        mult_im(FRAC_BITS+DATA_WIDTH-1 downto FRAC_BITS), DATA_WIDTH);
                    
                    fft_data(top_idx) <= butterfly_result_top;
                    fft_data(bot_idx) <= butterfly_result_bot;
                    
                    -- Advance counters
                    if butterfly_count = FFT_SIZE/2 - 1 then
                        butterfly_count <= 0;
                        if fft_stage = integer(log2(real(FFT_SIZE))) - 1 then
                            current_state <= ST_CALC_MAGNITUDE;
                        else
                            fft_stage <= fft_stage + 1;
                        end if;
                    else
                        butterfly_count <= butterfly_count + 1;
                    end if;
                
                when ST_CALC_MAGNITUDE =>
                    -- Compute magnitude for first half (single-sided spectrum)
                    -- |X[k]| = sqrt(re^2 + im^2), normalized by N
                    for k in 0 to FFT_SIZE/2 loop
                        -- Approximate magnitude using alpha-max-beta-min algorithm
                        -- |z| ≈ 0.960433*max(|re|,|im|) + 0.397828*min(|re|,|im|)
                        variable abs_re, abs_im : unsigned(DATA_WIDTH-1 downto 0);
                        variable mx, mn : unsigned(DATA_WIDTH-1 downto 0);
                        variable mag_approx : fix_point;
                        variable alpha, beta : fix_point;
                    begin
                        if fft_data(k).re(DATA_WIDTH-1) = '1' then
                            abs_re := unsigned(not fft_data(k).re) + 1;
                        else
                            abs_re := unsigned(fft_data(k).re);
                        end if;
                        
                        if fft_data(k).im(DATA_WIDTH-1) = '1' then
                            abs_im := unsigned(not fft_data(k).im) + 1;
                        else
                            abs_im := unsigned(fft_data(k).im);
                        end if;
                        
                        if abs_re > abs_im then
                            mx := abs_re;
                            mn := abs_im;
                        else
                            mx := abs_im;
                            mn := abs_re;
                        end if;
                        
                        alpha := to_fixpoint(0.960433);
                        beta  := to_fixpoint(0.397828);
                        
                        mag_approx := safe_multiply(resize(signed(mx), DATA_WIDTH), alpha) +
                                     safe_multiply(resize(signed(mn), DATA_WIDTH), beta);
                        
                        magnitude_buf(k) <= safe_multiply(mag_approx, norm_factor);
                    end loop;
                    
                    current_state <= ST_OUTPUT_RESULTS;
                    mag_output_addr <= 0;
                
                when ST_OUTPUT_RESULTS =>
                    freq_out_addr  <= mag_output_addr;
                    freq_out_data  <= magnitude_buf(mag_output_addr);
                    freq_out_valid <= '1';
                    
                    if mag_output_addr = FFT_SIZE/2 then
                        current_state <= ST_DONE;
                        freq_out_valid <= '0';
                    else
                        mag_output_addr <= mag_output_addr + 1;
                    end if;
                
                when ST_DONE =>
                    busy      <= '0';
                    done      <= '1';
                    valid_out <= '1';
                    current_state <= ST_IDLE;
                
            end case;
        end if;
    end process;
    
end architecture;