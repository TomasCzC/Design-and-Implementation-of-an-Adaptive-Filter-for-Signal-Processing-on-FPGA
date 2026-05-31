-- ============================================================================
-- Entity: moving_average_filter.vhd
-- Implements moving_avg from metrics.py
-- Hardware sliding window average with configurable window size
-- ============================================================================
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.dsp_constants_and_types.all;

entity moving_average_filter is
    generic (
        MAX_WINDOW  : integer := 256;
        DATA_W      : integer := DATA_WIDTH
    );
    port (
        clk         : in  std_logic;
        reset_n     : in  std_logic;
        
        -- Configuration
        window_size : in  integer range 1 to MAX_WINDOW;
        
        -- Data Stream Input
        data_in     : in  fix_point;
        valid_in    : in  std_logic;
        
        -- Data Stream Output
        data_out    : out fix_point;
        valid_out   : out std_logic;
        
        -- Control
        flush       : in  std_logic
    );
end entity;

architecture rtl of moving_average_filter is
    
    -- Circular buffer for sliding window
    type circ_buffer is array (0 to MAX_WINDOW-1) of fix_point;
    signal buffer_mem    : circ_buffer := (others => (others => '0'));
    signal write_ptr     : integer range 0 to MAX_WINDOW-1 := 0;
    
    -- Accumulator with extended precision
    signal accumulator   : signed(DATA_W + 16 downto 0) := (others => '0');
    signal oldest_sample : fix_point := (others => '0');
    
    -- Inverse window size (precomputed scaling)
    signal inv_window    : fix_point;
    signal eff_window    : integer range 1 to MAX_WINDOW;
    
    -- Output register
    signal output_reg    : fix_point;
    signal sample_count  : integer range 0 to MAX_WINDOW := 0;
    signal output_valid  : std_logic := '0';
    
begin
    
    -- Effective window size (handle edge cases)
    eff_window <= 1 when window_size <= 1 or window_size > MAX_WINDOW else window_size;
    
    -- Precompute inverse: 1/window
    process(clk)
    begin
        if rising_edge(clk) then
            inv_window <= to_fixpoint(1.0 / real(eff_window));
        end if;
    end process;
    
    -- Sliding Window Logic
    process(clk, reset_n)
        variable acc_var : signed(DATA_W + 16 downto 0);
    begin
        if reset_n = '0' then
            accumulator  <= (others => '0');
            write_ptr    <= 0;
            sample_count <= 0;
            output_valid <= '0';
            buffer_mem   <= (others => (others => '0'));
            
        elsif rising_edge(clk) then
            output_valid <= '0';
            
            if flush = '1' then
                accumulator  <= (others => '0');
                write_ptr    <= 0;
                sample_count <= 0;
                buffer_mem   <= (others => (others => '0'));
                
            elsif valid_in = '1' then
                -- Read oldest sample from circular buffer
                oldest_sample <= buffer_mem(write_ptr);
                
                -- Update accumulator: subtract oldest, add newest
                acc_var := accumulator - resize(oldest_sample, accumulator'length) + 
                           resize(data_in, accumulator'length);
                accumulator <= acc_var;
                
                -- Store new sample in buffer
                buffer_mem(write_ptr) <= data_in;
                
                -- Advance pointer
                if write_ptr = MAX_WINDOW - 1 then
                    write_ptr <= 0;
                else
                    write_ptr <= write_ptr + 1;
                end if;
                
                -- Track count until buffer fills
                if sample_count < eff_window then
                    sample_count <= sample_count + 1;
                end if;
                
                -- Compute output
                if sample_count >= eff_window - 1 then
                    output_reg <= safe_multiply(
                        accumulator(FRAC_BITS+DATA_W-1 downto FRAC_BITS), 
                        inv_window
                    );
                    output_valid <= '1';
                else
                    -- Partial fill: use available samples
                    var partial_inv : fix_point := to_fixpoint(1.0 / real(sample_count + 1));
                begin
                    output_reg <= safe_multiply(
                        accumulator(FRAC_BITS+DATA_W-1 downto FRAC_BITS),
                        partial_inv
                    );
                    output_valid <= '1';
                end if;
            end if;
        end if;
    end process;
    
    data_out  <= output_reg;
    valid_out <= output_valid;
    
end architecture;