-- ============================================================================
-- Entity: top_level.vhd
-- Board-level top for Digilent Genesys 2 / AMD Kintex-7
--
-- Integrates:
--   - clk_wiz_0
--   - genesys2_radar_filter_wrapper
--   - adaptive_filter_system
--   - oled_filter_status
--
-- Required clocking:
--   clk_wiz_0/clk_out1 = 100 MHz  -> reserved / currently unused
--   clk_wiz_0/clk_out2 = 200 MHz  -> BD reference clock logic
--   clk_wiz_0/clk_out3 = 25  MHz  -> adaptive_filter_system
--   clk_wiz_0/clk_out4 = 125 MHz  -> MicroBlaze / AXI / Ethernet GTX clock
--
-- Data path:
--   PC UDP
--     -> MicroBlaze/lwIP
--     -> AXI GPIO x_sample_from_mb / d_sample_from_mb
--     -> adaptive_filter_system
--     -> AXI GPIO y_result_to_mb / e_result_to_mb
--     -> MicroBlaze/lwIP
--     -> PC UDP
-- ============================================================================

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

use work.dsp_constants_and_types.all;

entity top_level is
    port (
        ------------------------------------------------------------------------
        -- Genesys 2 differential system clock and reset
        ------------------------------------------------------------------------
        sysclk_p   : in  std_logic;
        sysclk_n   : in  std_logic;
        cpu_resetn : in  std_logic;

        ------------------------------------------------------------------------
        -- Buttons
        ------------------------------------------------------------------------
        btnc : in std_logic;
        btnd : in std_logic;
        btnu : in std_logic;

        ------------------------------------------------------------------------
        -- Switches and LEDs
        ------------------------------------------------------------------------
        sw  : in  std_logic_vector(7 downto 0);
        led : out std_logic_vector(7 downto 0);

        ------------------------------------------------------------------------
        -- OLED
        ------------------------------------------------------------------------
        oled_sdin : out std_logic;
        oled_sclk : out std_logic;
        oled_dc   : out std_logic;
        oled_res  : out std_logic;
        oled_vbat : out std_logic;
        oled_vdd  : out std_logic;

        ------------------------------------------------------------------------
        -- DDR3 SDRAM
        ------------------------------------------------------------------------
        ddr3_sdram_addr    : out   std_logic_vector(14 downto 0);
        ddr3_sdram_ba      : out   std_logic_vector(2 downto 0);
        ddr3_sdram_cas_n   : out   std_logic;
        ddr3_sdram_ck_n    : out   std_logic_vector(0 to 0);
        ddr3_sdram_ck_p    : out   std_logic_vector(0 to 0);
        ddr3_sdram_cke     : out   std_logic_vector(0 to 0);
        ddr3_sdram_cs_n    : out   std_logic_vector(0 to 0);
        ddr3_sdram_dm      : out   std_logic_vector(3 downto 0);
        ddr3_sdram_dq      : inout std_logic_vector(31 downto 0);
        ddr3_sdram_dqs_n   : inout std_logic_vector(3 downto 0);
        ddr3_sdram_dqs_p   : inout std_logic_vector(3 downto 0);
        ddr3_sdram_odt     : out   std_logic_vector(0 to 0);
        ddr3_sdram_ras_n   : out   std_logic;
        ddr3_sdram_reset_n : out   std_logic;
        ddr3_sdram_we_n    : out   std_logic;

        ------------------------------------------------------------------------
        -- USB UART
        ------------------------------------------------------------------------
        usb_uart_rxd : in  std_logic;
        usb_uart_txd : out std_logic;

        ------------------------------------------------------------------------
        -- Ethernet auxiliary signals
        ------------------------------------------------------------------------
        eth_int_b : in std_logic;
        eth_pme_b : in std_logic;

        ------------------------------------------------------------------------
        -- Ethernet MDIO / MDC
        ------------------------------------------------------------------------
        eth_mdc      : out   std_logic;
        eth_mdio     : inout std_logic;
        ETH_PHYRST_N : out   std_logic;

        ------------------------------------------------------------------------
        -- Ethernet RGMII
        ------------------------------------------------------------------------
        eth_rxck  : in  std_logic;
        eth_rxctl : in  std_logic;
        eth_rxd   : in  std_logic_vector(3 downto 0);

        eth_txck  : out std_logic;
        ETH_TX_EN : out std_logic;
        eth_txd   : out std_logic_vector(3 downto 0)
    );
end entity top_level;


architecture rtl of top_level is

    ---------------------------------------------------------------------------
    -- Clock wizard
    --
    -- clk_out1 = 100 MHz
    -- clk_out2 = 200 MHz
    -- clk_out3 = 25 MHz
    -- clk_out4 = 125 MHz
    ---------------------------------------------------------------------------
    component clk_wiz_0 is
        port (
            clk_in1_p : in  std_logic;
            clk_in1_n : in  std_logic;
            reset     : in  std_logic;
            clk_out1  : out std_logic;
            clk_out2  : out std_logic;
            clk_out3  : out std_logic;
            clk_out4  : out std_logic;
            locked    : out std_logic
        );
    end component;


    ---------------------------------------------------------------------------
    -- Clock and reset
    ---------------------------------------------------------------------------
    signal clk_100M_s       : std_logic := '0';
    signal clk_125M_s       : std_logic := '0';
    signal clk_200M_s       : std_logic := '0';
    signal clk_filter_s     : std_logic := '0';
    signal clk_locked_s     : std_logic := '0';

    -- Main MicroBlaze / AXI / Ethernet clock domain.
    signal clk_mb_s         : std_logic := '0';

    signal clk_reset_s      : std_logic := '0';
    signal reset_n_s        : std_logic := '0';

    signal filter_reset_ff  : std_logic_vector(1 downto 0) := (others => '0');
    signal filter_reset_n_s : std_logic := '0';


    ---------------------------------------------------------------------------
    -- Ethernet / MicroBlaze GPIO signals, 125 MHz domain
    ---------------------------------------------------------------------------
    signal control_from_mb_s  : std_logic_vector(31 downto 0) := (others => '0');
    signal control_from_mb_d  : std_logic_vector(31 downto 0) := (others => '0');

    signal x_sample_from_mb_s : std_logic_vector(31 downto 0) := (others => '0');
    signal d_sample_from_mb_s : std_logic_vector(31 downto 0) := (others => '0');

    signal y_result_to_mb_s   : std_logic_vector(31 downto 0) := (others => '0');
    signal e_result_to_mb_s   : std_logic_vector(31 downto 0) := (others => '0');

    signal phy_reset_vec_s    : std_logic_vector(0 to 0) := (others => '0');


    ---------------------------------------------------------------------------
    -- Request handshake from 125 MHz domain to 25 MHz filter domain
    ---------------------------------------------------------------------------
    signal sample_valid_sys_s        : std_logic := '0';
    signal init_weights_sys_s        : std_logic := '0';
    signal freeze_sys_s              : std_logic := '0';

    signal sample_valid_toggle_sys_s : std_logic := '0';
    signal init_weights_toggle_sys_s : std_logic := '0';

    signal sample_valid_meta_f_s     : std_logic := '0';
    signal sample_valid_sync_f_s     : std_logic := '0';
    signal sample_valid_sync_d_f_s   : std_logic := '0';

    signal init_weights_meta_f_s     : std_logic := '0';
    signal init_weights_sync_f_s     : std_logic := '0';
    signal init_weights_sync_d_f_s   : std_logic := '0';

    signal freeze_meta_f_s           : std_logic := '0';
    signal freeze_filter_s           : std_logic := '0';

    signal sw_filter_meta_s          : std_logic_vector(2 downto 0) := (others => '0');
    signal sw_filter_s               : std_logic_vector(2 downto 0) := (others => '0');

    signal x_sample_hold_s           : std_logic_vector(31 downto 0) := (others => '0');
    signal d_sample_hold_s           : std_logic_vector(31 downto 0) := (others => '0');

    signal x_sample_filter_vec_s     : std_logic_vector(31 downto 0) := (others => '0');
    signal d_sample_filter_vec_s     : std_logic_vector(31 downto 0) := (others => '0');

    signal sample_valid_filter_s     : std_logic := '0';
    signal init_weights_filter_s     : std_logic := '0';


    ---------------------------------------------------------------------------
    -- Adaptive filter signals, 25 MHz domain
    ---------------------------------------------------------------------------
    signal x_sample_s       : fix_point := FIX_ZERO;
    signal d_sample_s       : fix_point := FIX_ZERO;

    signal y_filtered_s     : fix_point := FIX_ZERO;
    signal e_filtered_s     : fix_point := FIX_ZERO;

    signal filter_valid_s   : std_logic := '0';

    signal metrics_s        : metrics_record;
    signal metrics_valid_s  : std_logic := '0';

    signal dsp_led_filter_s : std_logic_vector(7 downto 0) := (others => '0');


    ---------------------------------------------------------------------------
    -- Result transfer from 25 MHz filter domain to 125 MHz domain
    ---------------------------------------------------------------------------
    signal y_result_filter_vec_s     : std_logic_vector(31 downto 0) := (others => '0');
    signal e_result_filter_vec_s     : std_logic_vector(31 downto 0) := (others => '0');

    signal filter_valid_toggle_f_s   : std_logic := '0';
    signal filter_valid_meta_sys_s   : std_logic := '0';
    signal filter_valid_sync_sys_s   : std_logic := '0';
    signal filter_valid_sync_d_sys_s : std_logic := '0';

    signal filter_valid_sys_s        : std_logic := '0';

    signal metrics_valid_meta_sys_s  : std_logic := '0';
    signal metrics_valid_sys_s       : std_logic := '0';

    signal dsp_led_meta_sys_s        : std_logic_vector(7 downto 0) := (others => '0');
    signal dsp_led_sys_s             : std_logic_vector(7 downto 0) := (others => '0');


begin

    ---------------------------------------------------------------------------
    -- Clock generation
    ---------------------------------------------------------------------------
    clk_reset_s <= not cpu_resetn;

    u_clk_wiz_0 : clk_wiz_0
        port map (
            clk_in1_p => sysclk_p,
            clk_in1_n => sysclk_n,
            reset     => clk_reset_s,
            clk_out1  => clk_100M_s,    -- 100 MHz, reserved
            clk_out2  => clk_200M_s,    -- 200 MHz
            clk_out3  => clk_filter_s,  -- 25 MHz
            clk_out4  => clk_125M_s,    -- 125 MHz for Ethernet / BD
            locked    => clk_locked_s
        );

    clk_mb_s <= clk_125M_s;

    reset_n_s <= cpu_resetn and clk_locked_s;


    ---------------------------------------------------------------------------
    -- Filter reset synchronizer
    ---------------------------------------------------------------------------
    process(clk_filter_s)
    begin
        if rising_edge(clk_filter_s) then
            if reset_n_s = '0' then
                filter_reset_ff <= (others => '0');
            else
                filter_reset_ff <= filter_reset_ff(0) & '1';
            end if;
        end if;
    end process;

    filter_reset_n_s <= filter_reset_ff(1);


    ---------------------------------------------------------------------------
    -- MicroBlaze + Ethernet + AXI GPIO system
    ---------------------------------------------------------------------------
    u_eth_mb_system : entity work.genesys2_radar_filter_wrapper
        port map (
            --------------------------------------------------------------------
            -- Clocks and reset into Block Design
            -- clk_125M is now connected to the real 125 MHz clock.
            --------------------------------------------------------------------
            clk_125M  => clk_mb_s,
            clk_200M  => clk_200M_s,
            sys_rst_n => reset_n_s,

            --------------------------------------------------------------------
            -- AXI GPIO from MicroBlaze to filter
            --------------------------------------------------------------------
            control_from_mb_tri_o  => control_from_mb_s,
            x_sample_from_mb_tri_o => x_sample_from_mb_s,
            d_sample_from_mb_tri_o => d_sample_from_mb_s,

            --------------------------------------------------------------------
            -- AXI GPIO from filter to MicroBlaze
            --------------------------------------------------------------------
            y_result_to_mb_tri_i => y_result_to_mb_s,
            e_result_to_mb_tri_i => e_result_to_mb_s,

            --------------------------------------------------------------------
            -- DDR3 SDRAM
            --------------------------------------------------------------------
            ddr3_sdram_addr    => ddr3_sdram_addr,
            ddr3_sdram_ba      => ddr3_sdram_ba,
            ddr3_sdram_cas_n   => ddr3_sdram_cas_n,
            ddr3_sdram_ck_n    => ddr3_sdram_ck_n,
            ddr3_sdram_ck_p    => ddr3_sdram_ck_p,
            ddr3_sdram_cke     => ddr3_sdram_cke,
            ddr3_sdram_cs_n    => ddr3_sdram_cs_n,
            ddr3_sdram_dm      => ddr3_sdram_dm,
            ddr3_sdram_dq      => ddr3_sdram_dq,
            ddr3_sdram_dqs_n   => ddr3_sdram_dqs_n,
            ddr3_sdram_dqs_p   => ddr3_sdram_dqs_p,
            ddr3_sdram_odt     => ddr3_sdram_odt,
            ddr3_sdram_ras_n   => ddr3_sdram_ras_n,
            ddr3_sdram_reset_n => ddr3_sdram_reset_n,
            ddr3_sdram_we_n    => ddr3_sdram_we_n,

            --------------------------------------------------------------------
            -- Ethernet MDIO / MDC
            --------------------------------------------------------------------
            eth_mdio_mdc_mdc     => eth_mdc,
            eth_mdio_mdc_mdio_io => eth_mdio,

            --------------------------------------------------------------------
            -- Ethernet RGMII input
            --------------------------------------------------------------------
            eth_rgmii_rd     => eth_rxd,
            eth_rgmii_rx_ctl => eth_rxctl,
            eth_rgmii_rxc    => eth_rxck,

            --------------------------------------------------------------------
            -- Ethernet RGMII output
            --------------------------------------------------------------------
            eth_rgmii_td     => eth_txd,
            eth_rgmii_tx_ctl => ETH_TX_EN,
            eth_rgmii_txc    => eth_txck,

            --------------------------------------------------------------------
            -- PHY reset from AXI GPIO
            --------------------------------------------------------------------
            phy_reset_out_tri_o => phy_reset_vec_s,

            --------------------------------------------------------------------
            -- USB UART
            --------------------------------------------------------------------
            usb_uart_rxd => usb_uart_rxd,
            usb_uart_txd => usb_uart_txd
        );

    ETH_PHYRST_N <= phy_reset_vec_s(0);


    ---------------------------------------------------------------------------
    -- Control edge detection in 125 MHz domain
    --
    -- control_from_mb_s(0): valid_in command from MicroBlaze
    -- control_from_mb_s(1): init_weights command from MicroBlaze
    -- control_from_mb_s(2): freeze level from MicroBlaze
    ---------------------------------------------------------------------------
    process(clk_mb_s)
    begin
        if rising_edge(clk_mb_s) then
            if reset_n_s = '0' then
                control_from_mb_d         <= (others => '0');
                sample_valid_toggle_sys_s <= '0';
                init_weights_toggle_sys_s <= '0';
                x_sample_hold_s           <= (others => '0');
                d_sample_hold_s           <= (others => '0');
            else
                control_from_mb_d <= control_from_mb_s;

                if control_from_mb_s(0) = '1' and control_from_mb_d(0) = '0' then
                    x_sample_hold_s           <= x_sample_from_mb_s;
                    d_sample_hold_s           <= d_sample_from_mb_s;
                    sample_valid_toggle_sys_s <= not sample_valid_toggle_sys_s;
                end if;

                if control_from_mb_s(1) = '1' and control_from_mb_d(1) = '0' then
                    init_weights_toggle_sys_s <= not init_weights_toggle_sys_s;
                end if;
            end if;
        end if;
    end process;

    sample_valid_sys_s <= control_from_mb_s(0) and not control_from_mb_d(0);
    init_weights_sys_s <= control_from_mb_s(1) and not control_from_mb_d(1);
    freeze_sys_s       <= sw(2) or control_from_mb_s(2);


    ---------------------------------------------------------------------------
    -- Synchronize MicroBlaze commands into 25 MHz filter domain
    ---------------------------------------------------------------------------
    process(clk_filter_s)
    begin
        if rising_edge(clk_filter_s) then
            if filter_reset_n_s = '0' then
                sample_valid_meta_f_s   <= '0';
                sample_valid_sync_f_s   <= '0';
                sample_valid_sync_d_f_s <= '0';

                init_weights_meta_f_s   <= '0';
                init_weights_sync_f_s   <= '0';
                init_weights_sync_d_f_s <= '0';

                freeze_meta_f_s         <= '0';
                freeze_filter_s         <= '0';

                sw_filter_meta_s        <= (others => '0');
                sw_filter_s             <= (others => '0');

                x_sample_filter_vec_s   <= (others => '0');
                d_sample_filter_vec_s   <= (others => '0');

                sample_valid_filter_s   <= '0';
                init_weights_filter_s   <= '0';
            else
                ----------------------------------------------------------------
                -- Toggle synchronizers for one-shot commands
                ----------------------------------------------------------------
                sample_valid_meta_f_s   <= sample_valid_toggle_sys_s;
                sample_valid_sync_f_s   <= sample_valid_meta_f_s;
                sample_valid_sync_d_f_s <= sample_valid_sync_f_s;

                init_weights_meta_f_s   <= init_weights_toggle_sys_s;
                init_weights_sync_f_s   <= init_weights_meta_f_s;
                init_weights_sync_d_f_s <= init_weights_sync_f_s;

                sample_valid_filter_s <= sample_valid_sync_f_s xor sample_valid_sync_d_f_s;
                init_weights_filter_s <= init_weights_sync_f_s xor init_weights_sync_d_f_s;

                ----------------------------------------------------------------
                -- Synchronize level controls
                ----------------------------------------------------------------
                freeze_meta_f_s <= freeze_sys_s;
                freeze_filter_s <= freeze_meta_f_s;

                sw_filter_meta_s(1 downto 0) <= sw(1 downto 0);
                sw_filter_meta_s(2)          <= freeze_filter_s;
                sw_filter_s                  <= sw_filter_meta_s;

                ----------------------------------------------------------------
                -- Capture sample words when a new valid command arrives
                ----------------------------------------------------------------
                if (sample_valid_sync_f_s xor sample_valid_sync_d_f_s) = '1' then
                    x_sample_filter_vec_s <= x_sample_hold_s;
                    d_sample_filter_vec_s <= d_sample_hold_s;
                end if;
            end if;
        end if;
    end process;


    ---------------------------------------------------------------------------
    -- Convert synchronized MicroBlaze GPIO data to fixed-point samples
    ---------------------------------------------------------------------------
    x_sample_s <= resize(signed(x_sample_filter_vec_s), x_sample_s'length);
    d_sample_s <= resize(signed(d_sample_filter_vec_s), d_sample_s'length);


    ---------------------------------------------------------------------------
    -- Adaptive filter system, 25 MHz domain
    ---------------------------------------------------------------------------
    u_adaptive_filter_system : entity work.adaptive_filter_system
        generic map (
            NUM_TAPS  => 16,
            FRAME_LEN => 1024
        )
        port map (
            clk          => clk_filter_s,
            reset_n      => filter_reset_n_s,

            sw           => sw_filter_s,
            init_weights => init_weights_filter_s,

            x_in         => x_sample_s,
            d_in         => d_sample_s,
            valid_in     => sample_valid_filter_s,

            y_out        => y_filtered_s,
            e_out        => e_filtered_s,
            valid_out    => filter_valid_s,

            metrics_out   => metrics_s,
            metrics_valid => metrics_valid_s,

            led          => dsp_led_filter_s
        );


    ---------------------------------------------------------------------------
    -- Register filter result in 25 MHz domain
    ---------------------------------------------------------------------------
    process(clk_filter_s)
    begin
        if rising_edge(clk_filter_s) then
            if filter_reset_n_s = '0' then
                y_result_filter_vec_s   <= (others => '0');
                e_result_filter_vec_s   <= (others => '0');
                filter_valid_toggle_f_s <= '0';
            else
                if filter_valid_s = '1' then
                    y_result_filter_vec_s   <= std_logic_vector(resize(y_filtered_s, 32));
                    e_result_filter_vec_s   <= std_logic_vector(resize(e_filtered_s, 32));
                    filter_valid_toggle_f_s <= not filter_valid_toggle_f_s;
                end if;
            end if;
        end if;
    end process;


    ---------------------------------------------------------------------------
    -- Transfer filter result back to 125 MHz MicroBlaze / AXI domain
    ---------------------------------------------------------------------------
    process(clk_mb_s)
    begin
        if rising_edge(clk_mb_s) then
            if reset_n_s = '0' then
                filter_valid_meta_sys_s   <= '0';
                filter_valid_sync_sys_s   <= '0';
                filter_valid_sync_d_sys_s <= '0';

                filter_valid_sys_s        <= '0';

                y_result_to_mb_s          <= (others => '0');
                e_result_to_mb_s          <= (others => '0');

                metrics_valid_meta_sys_s  <= '0';
                metrics_valid_sys_s       <= '0';

                dsp_led_meta_sys_s        <= (others => '0');
                dsp_led_sys_s             <= (others => '0');
            else
                ----------------------------------------------------------------
                -- Synchronize result-valid toggle
                ----------------------------------------------------------------
                filter_valid_meta_sys_s   <= filter_valid_toggle_f_s;
                filter_valid_sync_sys_s   <= filter_valid_meta_sys_s;
                filter_valid_sync_d_sys_s <= filter_valid_sync_sys_s;

                filter_valid_sys_s <= filter_valid_sync_sys_s xor filter_valid_sync_d_sys_s;

                if (filter_valid_sync_sys_s xor filter_valid_sync_d_sys_s) = '1' then
                    y_result_to_mb_s <= y_result_filter_vec_s;
                    e_result_to_mb_s <= e_result_filter_vec_s;
                end if;

                ----------------------------------------------------------------
                -- Slow/status signals for OLED and LEDs
                ----------------------------------------------------------------
                metrics_valid_meta_sys_s <= metrics_valid_s;
                metrics_valid_sys_s      <= metrics_valid_meta_sys_s;

                dsp_led_meta_sys_s <= dsp_led_filter_s;
                dsp_led_sys_s      <= dsp_led_meta_sys_s;
            end if;
        end if;
    end process;


    ---------------------------------------------------------------------------
    -- OLED status display, 125 MHz domain
    ---------------------------------------------------------------------------
    u_oled_filter_status : entity work.oled_filter_status
        generic map (
            REFRESH_DIV => 12_500_000
        )
        port map (
            clk  => clk_mb_s,

            rstn => reset_n_s,
            btnC => btnc,
            btnD => btnd,
            btnU => btnu,

            alg_sel       => sw(1 downto 0),
            input_valid   => sample_valid_sys_s,
            output_valid  => filter_valid_sys_s,
            filter_busy   => dsp_led_sys_s(5),
            metrics_valid => metrics_valid_sys_s,
            freeze        => freeze_sys_s,

            oled_sdin => oled_sdin,
            oled_sclk => oled_sclk,
            oled_dc   => oled_dc,
            oled_res  => oled_res,
            oled_vbat => oled_vbat,
            oled_vdd  => oled_vdd,

            led => open
        );


    ---------------------------------------------------------------------------
    -- Board LEDs
    ---------------------------------------------------------------------------
    led <= dsp_led_sys_s;


    ---------------------------------------------------------------------------
    -- Unused auxiliary Ethernet inputs
    ---------------------------------------------------------------------------
    -- eth_int_b and eth_pme_b are intentionally unused in this minimal design.

end architecture rtl;