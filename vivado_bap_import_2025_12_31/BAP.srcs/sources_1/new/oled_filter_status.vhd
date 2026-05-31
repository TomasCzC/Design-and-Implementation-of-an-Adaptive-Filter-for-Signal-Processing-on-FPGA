-- ============================================================================
-- Entity: oled_filter_status.vhd
-- OLED status display for adaptive filtering system
--
-- Shows:
--   Row 0: ADAPTIVE FILTER
--   Row 1: MODE: LMS / NLMS / RLS
--   Row 2: IN / OUT / BUSY status
--   Row 3: METRICS / FREEZE status
--
-- Dependencies:
--   OLEDCtrl
--   debouncer
--
-- Notes:
--   - This module does NOT instantiate clk_wiz_0.
--   - Use board-level top_level.vhd to generate/provide clk.
--   - Intended to be instantiated from the main Genesys 2 top-level.
-- ============================================================================

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity oled_filter_status is
    generic (
        -- For 100 MHz clock:
        -- 10_000_000 gives approximately 10 Hz refresh rate.
        REFRESH_DIV : integer := 10_000_000
    );
    port (
        ------------------------------------------------------------------------
        -- Clock
        ------------------------------------------------------------------------
        clk : in std_logic;

        ------------------------------------------------------------------------
        -- Buttons
        ------------------------------------------------------------------------
        rstn : in std_logic;  -- active-low button input from board
        btnC : in std_logic;  -- toggle full display
        btnD : in std_logic;  -- clear OLED
        btnU : in std_logic;  -- force refresh

        ------------------------------------------------------------------------
        -- Adaptive filter status inputs
        --
        -- alg_sel:
        --   00 = LMS
        --   01 = NLMS
        --   10 = RLS
        --   11 = LMS fallback / reserved
        ------------------------------------------------------------------------
        alg_sel       : in std_logic_vector(1 downto 0);
        input_valid   : in std_logic;
        output_valid  : in std_logic;
        filter_busy   : in std_logic;
        metrics_valid : in std_logic;
        freeze        : in std_logic;

        ------------------------------------------------------------------------
        -- OLED physical outputs
        ------------------------------------------------------------------------
        oled_sdin : out std_logic;
        oled_sclk : out std_logic;
        oled_dc   : out std_logic;
        oled_res  : out std_logic;
        oled_vbat : out std_logic;
        oled_vdd  : out std_logic;

        ------------------------------------------------------------------------
        -- Optional debug LEDs
        ------------------------------------------------------------------------
        led : out std_logic_vector(7 downto 0)
    );
end entity oled_filter_status;


architecture rtl of oled_filter_status is

    ---------------------------------------------------------------------------
    -- Component declarations
    ---------------------------------------------------------------------------

    component OLEDCtrl is
        port (
            clk                : in  std_logic;

            write_start        : in  std_logic;
            write_ascii_data   : in  std_logic_vector(7 downto 0);
            write_base_addr    : in  std_logic_vector(8 downto 0);
            write_ready        : out std_logic;

            update_start       : in  std_logic;
            update_ready       : out std_logic;
            update_clear       : in  std_logic;

            disp_on_start      : in  std_logic;
            disp_on_ready      : out std_logic;

            disp_off_start     : in  std_logic;
            disp_off_ready     : out std_logic;

            toggle_disp_start  : in  std_logic;
            toggle_disp_ready  : out std_logic;

            SDIN               : out std_logic;
            SCLK               : out std_logic;
            DC                 : out std_logic;
            RES                : out std_logic;
            VBAT               : out std_logic;
            VDD                : out std_logic
        );
    end component;


    component debouncer is
        generic (
            COUNT_MAX   : integer := 65535;
            COUNT_WIDTH : integer := 16
        );
        port (
            clk : in  std_logic;
            A   : in  std_logic;
            B   : out std_logic
        );
    end component;


    ---------------------------------------------------------------------------
    -- Types and constants
    ---------------------------------------------------------------------------

    subtype byte_t is std_logic_vector(7 downto 0);

    type state_t is (
        Idle,
        Init,
        Active,
        Done,
        FullDisp,
        Write,
        WriteWait,
        UpdateWait
    );

    constant AUTO_START : boolean := true;

    constant ROW0_STR : string(1 to 16) := "ADAPTIVE FILTER ";


    ---------------------------------------------------------------------------
    -- Helper functions
    ---------------------------------------------------------------------------

    function bool_to_sl(b : boolean) return std_logic is
    begin
        if b then
            return '1';
        else
            return '0';
        end if;
    end function;


    function initial_state return state_t is
    begin
        if AUTO_START then
            return Init;
        else
            return Idle;
        end if;
    end function;


    function char_to_slv(c : character) return byte_t is
    begin
        return std_logic_vector(to_unsigned(character'pos(c), 8));
    end function;


    function sl_to_char(s : std_logic) return character is
    begin
        if s = '1' then
            return '1';
        else
            return '0';
        end if;
    end function;


    function get_status_char(
        row_i          : integer;
        col_i          : integer;
        alg_i          : std_logic_vector(1 downto 0);
        input_valid_i  : std_logic;
        output_valid_i : std_logic;
        busy_i         : std_logic;
        metrics_i      : std_logic;
        freeze_i       : std_logic
    ) return byte_t is
        variable row_str : string(1 to 16);
    begin

        case row_i is

            --------------------------------------------------------------------
            -- Row 0
            --------------------------------------------------------------------
            when 0 =>
                row_str := ROW0_STR;


            --------------------------------------------------------------------
            -- Row 1: algorithm name
            --------------------------------------------------------------------
            when 1 =>
                case alg_i is
                    when "00" =>
                        row_str := "MODE: LMS       ";

                    when "01" =>
                        row_str := "MODE: NLMS      ";

                    when "10" =>
                        row_str := "MODE: RLS       ";

                    when others =>
                        row_str := "MODE: LMS       ";
                end case;


            --------------------------------------------------------------------
            -- Row 2: input/output/busy status
            --
            -- "IN:0 OUT:0 B:0  "
            --      ^     ^   ^
            --      4     10  14
            --------------------------------------------------------------------
            when 2 =>
                row_str := "IN:0 OUT:0 B:0  ";
                row_str(4)  := sl_to_char(input_valid_i);
                row_str(10) := sl_to_char(output_valid_i);
                row_str(14) := sl_to_char(busy_i);


            --------------------------------------------------------------------
            -- Row 3: metrics/freeze status
            --
            -- "MET:0 FRZ:0     "
            --       ^     ^
            --       5     11
            --------------------------------------------------------------------
            when 3 =>
                row_str := "MET:0 FRZ:0     ";
                row_str(5)  := sl_to_char(metrics_i);
                row_str(11) := sl_to_char(freeze_i);


            --------------------------------------------------------------------
            when others =>
                row_str := "                ";

        end case;

        if col_i >= 0 and col_i <= 15 then
            return char_to_slv(row_str(col_i + 1));
        else
            return x"20";
        end if;

    end function;


    ---------------------------------------------------------------------------
    -- State machine registers
    ---------------------------------------------------------------------------

    signal state : state_t := initial_state;

    signal once : std_logic := '0';


    ---------------------------------------------------------------------------
    -- OLED control signals
    ---------------------------------------------------------------------------

    signal update_start      : std_logic := '0';
    signal disp_on_start     : std_logic := bool_to_sl(AUTO_START);
    signal disp_off_start    : std_logic := '0';
    signal toggle_disp_start : std_logic := '0';
    signal write_start       : std_logic := '0';

    signal update_clear      : std_logic := '0';
    signal write_base_addr   : unsigned(8 downto 0) := (others => '0');
    signal write_ascii_data  : std_logic_vector(7 downto 0) := (others => '0');

    signal disp_on_ready     : std_logic;
    signal disp_off_ready    : std_logic;
    signal toggle_disp_ready : std_logic;
    signal update_ready      : std_logic;
    signal write_ready       : std_logic;


    ---------------------------------------------------------------------------
    -- Debounced button signals
    ---------------------------------------------------------------------------

    signal rst      : std_logic;
    signal rstn_inv : std_logic;
    signal dBtnC    : std_logic;
    signal dBtnU    : std_logic;
    signal dBtnD    : std_logic;


    ---------------------------------------------------------------------------
    -- Internal ready/status signals
    ---------------------------------------------------------------------------

    signal init_done  : std_logic;
    signal init_ready : std_logic;


    ---------------------------------------------------------------------------
    -- Refresh timer
    ---------------------------------------------------------------------------

    signal refresh_counter : integer range 0 to REFRESH_DIV-1 := 0;
    signal refresh_pending : std_logic := '1';


begin

    ---------------------------------------------------------------------------
    -- Local inverted reset for debouncer
    ---------------------------------------------------------------------------

    rstn_inv <= not rstn;


    ---------------------------------------------------------------------------
    -- OLED controller
    ---------------------------------------------------------------------------

    m_OLEDCtrl : OLEDCtrl
        port map (
            clk               => clk,

            write_start       => write_start,
            write_ascii_data  => write_ascii_data,
            write_base_addr   => std_logic_vector(write_base_addr),
            write_ready       => write_ready,

            update_start      => update_start,
            update_ready      => update_ready,
            update_clear      => update_clear,

            disp_on_start     => disp_on_start,
            disp_on_ready     => disp_on_ready,

            disp_off_start    => disp_off_start,
            disp_off_ready    => disp_off_ready,

            toggle_disp_start => toggle_disp_start,
            toggle_disp_ready => toggle_disp_ready,

            SDIN              => oled_sdin,
            SCLK              => oled_sclk,
            DC                => oled_dc,
            RES               => oled_res,
            VBAT              => oled_vbat,
            VDD               => oled_vdd
        );


    ---------------------------------------------------------------------------
    -- Character lookup from write_base_addr
    ---------------------------------------------------------------------------

    process(write_base_addr, alg_sel, input_valid, output_valid,
            filter_busy, metrics_valid, freeze)
        variable row_idx : integer range 0 to 3;
        variable col_idx : integer range 0 to 15;
    begin
        row_idx := to_integer(write_base_addr(8 downto 7));
        col_idx := to_integer(write_base_addr(6 downto 3));

        write_ascii_data <= get_status_char(
            row_idx,
            col_idx,
            alg_sel,
            input_valid,
            output_valid,
            filter_busy,
            metrics_valid,
            freeze
        );
    end process;


    ---------------------------------------------------------------------------
    -- Debouncers
    ---------------------------------------------------------------------------

    get_dBtnC : debouncer
        generic map (
            COUNT_MAX   => 65535,
            COUNT_WIDTH => 16
        )
        port map (
            clk => clk,
            A   => btnC,
            B   => dBtnC
        );


    get_dBtnU : debouncer
        generic map (
            COUNT_MAX   => 65535,
            COUNT_WIDTH => 16
        )
        port map (
            clk => clk,
            A   => btnU,
            B   => dBtnU
        );


    get_dBtnD : debouncer
        generic map (
            COUNT_MAX   => 65535,
            COUNT_WIDTH => 16
        )
        port map (
            clk => clk,
            A   => btnD,
            B   => dBtnD
        );


    get_rstn : debouncer
        generic map (
            COUNT_MAX   => 65535,
            COUNT_WIDTH => 16
        )
        port map (
            clk => clk,
            A   => rstn_inv,
            B   => rst
        );


    ---------------------------------------------------------------------------
    -- Ready signal parsing
    ---------------------------------------------------------------------------

    init_done  <= disp_off_ready or toggle_disp_ready or write_ready or update_ready;
    init_ready <= disp_on_ready;


    ---------------------------------------------------------------------------
    -- Debug LED output
    ---------------------------------------------------------------------------

    led(0) <= update_ready;
    led(1) <= write_ready;
    led(2) <= input_valid;
    led(3) <= output_valid;
    led(4) <= filter_busy;
    led(5) <= metrics_valid;
    led(6) <= freeze;
    led(7) <= rst;


    ---------------------------------------------------------------------------
    -- Main OLED control state machine
    ---------------------------------------------------------------------------

    process(clk)
    begin
        if rising_edge(clk) then

            --------------------------------------------------------------------
            -- Default one-clock command pulses
            --------------------------------------------------------------------
            write_start       <= '0';
            update_start      <= '0';
            disp_on_start     <= '0';
            disp_off_start    <= '0';
            toggle_disp_start <= '0';


            --------------------------------------------------------------------
            -- Periodic refresh request
            --------------------------------------------------------------------
            if refresh_counter = REFRESH_DIV - 1 then
                refresh_counter <= 0;
                refresh_pending <= '1';
            else
                refresh_counter <= refresh_counter + 1;
            end if;


            --------------------------------------------------------------------
            -- FSM
            --------------------------------------------------------------------
            case state is

                ----------------------------------------------------------------
                when Idle =>

                    once <= '0';

                    if rst = '1' and init_ready = '1' then
                        disp_on_start <= '1';
                        state         <= Init;
                    end if;


                ----------------------------------------------------------------
                when Init =>

                    if rst = '0' and init_done = '1' then
                        refresh_pending <= '1';
                        state           <= Active;
                    end if;


                ----------------------------------------------------------------
                when Active =>

                    if rst = '1' and disp_off_ready = '1' then

                        disp_off_start <= '1';
                        state          <= Done;

                    elsif dBtnD = '1' and update_ready = '1' then

                        update_start <= '1';
                        update_clear <= '1';
                        state        <= UpdateWait;

                    elsif dBtnC = '1' and toggle_disp_ready = '1' then

                        toggle_disp_start <= '1';
                        state             <= FullDisp;

                    elsif (refresh_pending = '1' or dBtnU = '1' or once = '0') and write_ready = '1' then

                        write_start     <= '1';
                        write_base_addr <= (others => '0');
                        update_clear    <= '0';

                        refresh_pending <= '0';

                        state <= WriteWait;

                    end if;


                ----------------------------------------------------------------
                when Write =>

                    write_start     <= '1';
                    write_base_addr <= write_base_addr + to_unsigned(8, 9);

                    state <= WriteWait;


                ----------------------------------------------------------------
                when WriteWait =>

                    if write_ready = '1' then

                        if write_base_addr = to_unsigned(16#1F8#, 9) then

                            once <= '1';

                            -- After rewriting local OLED memory,
                            -- immediately update physical display.
                            if update_ready = '1' then
                                update_start <= '1';
                                update_clear <= '0';
                                state        <= UpdateWait;
                            else
                                state <= Active;
                            end if;

                        else

                            state <= Write;

                        end if;
                    end if;


                ----------------------------------------------------------------
                when UpdateWait =>

                    if dBtnU = '0' and dBtnD = '0' and init_done = '1' then
                        state <= Active;
                    end if;


                ----------------------------------------------------------------
                when Done =>

                    if rst = '0' and init_ready = '1' then
                        state <= Idle;
                    end if;


                ----------------------------------------------------------------
                when FullDisp =>

                    if dBtnC = '0' and init_done = '1' then
                        state <= Active;
                    end if;


                ----------------------------------------------------------------
                when others =>

                    state <= Idle;

            end case;
        end if;
    end process;

end architecture rtl;