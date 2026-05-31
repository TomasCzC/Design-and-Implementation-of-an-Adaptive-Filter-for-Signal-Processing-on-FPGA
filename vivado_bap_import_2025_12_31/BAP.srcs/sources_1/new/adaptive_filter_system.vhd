-- ============================================================================
-- Entity: adaptive_filter_system.vhd
-- Internal DSP system for adaptive filtering
--
-- Contains:
--   - LMS filter
--   - NLMS filter
--   - RLS filter
--   - streaming metrics computation
--
-- This is NOT the board-level top.
-- Board-specific signals such as differential clock, Ethernet PHY, OLED,
-- buttons and constraints belong to genesys2_top.vhd.
--
-- SW1..SW0:
--   00 = LMS
--   01 = NLMS
--   10 = RLS
--   11 = LMS fallback
--
-- SW2:
--   freeze filter adaptation
-- ============================================================================

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

use work.dsp_constants_and_types.all;

entity adaptive_filter_system is
    generic (
        NUM_TAPS  : integer := 16;
        FRAME_LEN : integer := 1024
    );
    port (
        ------------------------------------------------------------------------
        -- Clock and reset
        ------------------------------------------------------------------------
        clk          : in  std_logic;
        reset_n      : in  std_logic;

        ------------------------------------------------------------------------
        -- User control
        ------------------------------------------------------------------------
        sw           : in  std_logic_vector(2 downto 0);
        init_weights : in  std_logic;

        ------------------------------------------------------------------------
        -- Input sample stream
        --
        -- x_in:
        --   Reference/input signal for the adaptive filter.
        --
        -- d_in:
        --   Desired signal.
        --
        -- valid_in:
        --   One-clock valid pulse for each input sample.
        ------------------------------------------------------------------------
        x_in         : in  fix_point;
        d_in         : in  fix_point;
        valid_in     : in  std_logic;

        ------------------------------------------------------------------------
        -- Filter outputs
        --
        -- y_out:
        --   Filter output.
        --
        -- e_out:
        --   Error signal d(n) - y(n).
        --   In adaptive noise cancellation this is usually the cleaned signal.
        ------------------------------------------------------------------------
        y_out        : out fix_point;
        e_out        : out fix_point;
        valid_out    : out std_logic;

        ------------------------------------------------------------------------
        -- Metrics output
        ------------------------------------------------------------------------
        metrics_out   : out metrics_record;
        metrics_valid : out std_logic;

        ------------------------------------------------------------------------
        -- Debug/status LEDs
        ------------------------------------------------------------------------
        led          : out std_logic_vector(7 downto 0)
    );
end entity adaptive_filter_system;


architecture rtl of adaptive_filter_system is

    ---------------------------------------------------------------------------
    -- Algorithm selection
    ---------------------------------------------------------------------------
    signal alg_select_s : filter_algorithm := ALG_LMS;

    ---------------------------------------------------------------------------
    -- Algorithm parameters
    ---------------------------------------------------------------------------
    signal mu_s       : fix_point := MU_DEFAULT_LMS;
    signal lambda_s   : fix_point := FIX_ONE;
    signal num_taps_s : integer range 1 to NUM_TAPS := NUM_TAPS;

    ---------------------------------------------------------------------------
    -- Filter internal signals
    ---------------------------------------------------------------------------
    signal y_s     : fix_point := FIX_ZERO;
    signal e_s     : fix_point := FIX_ZERO;
    signal valid_s : std_logic := '0';

    signal w_addr_s : integer range 0 to NUM_TAPS-1 := 0;
    signal w_data_s : fix_point := FIX_ZERO;

    signal filter_busy_s : std_logic := '0';

    ---------------------------------------------------------------------------
    -- Metrics internal signals
    ---------------------------------------------------------------------------
    signal metrics_out_s   : metrics_record;
    signal metrics_valid_s : std_logic := '0';

begin

    ---------------------------------------------------------------------------
    -- Algorithm selection from switches
    --
    -- SW1..SW0:
    --   00 = LMS
    --   01 = NLMS
    --   10 = RLS
    --   11 = LMS fallback
    ---------------------------------------------------------------------------
    process(sw)
    begin
        case sw(1 downto 0) is
            when "00" =>
                alg_select_s <= ALG_LMS;

            when "01" =>
                alg_select_s <= ALG_NLMS;

            when "10" =>
                alg_select_s <= ALG_RLS;

            when others =>
                alg_select_s <= ALG_LMS;
        end case;
    end process;


    ---------------------------------------------------------------------------
    -- Parameter selection
    ---------------------------------------------------------------------------
    mu_s <= MU_DEFAULT_LMS  when alg_select_s = ALG_LMS  else
            MU_DEFAULT_NLMS when alg_select_s = ALG_NLMS else
            q16_frac(1, 100);

    -- RLS forgetting factor lambda = 0.99
    lambda_s <= q16_frac(99, 100);


    ---------------------------------------------------------------------------
    -- Adaptive filter runner
    ---------------------------------------------------------------------------
    u_filter_runner : entity work.filter_runner_controller
        generic map (
            MAX_TAPS => NUM_TAPS,
            DATA_W   => DATA_WIDTH
        )
        port map (
            clk            => clk,
            reset_n        => reset_n,

            alg_select     => alg_select_s,

            params_mu      => mu_s,
            params_lambda  => lambda_s,
            params_eps     => EPS_FIX,

            limit_mu_lo    => FIX_ZERO,
            limit_mu_hi    => MU_NLMS_MAX,

            num_taps       => num_taps_s,

            x_in           => x_in,
            d_in           => d_in,
            valid_in       => valid_in,

            y_out          => y_s,
            e_out          => e_s,

            w_monitor_addr => w_addr_s,
            w_monitor_data => w_data_s,

            valid_out      => valid_s,

            start          => valid_in,
            init_w         => init_weights,
            freeze         => sw(2),
            busy           => filter_busy_s
        );


    ---------------------------------------------------------------------------
    -- Metrics computation
    --
    -- This module operates directly on the filtered stream.
    -- It does not use FFT and does not use floating-point arithmetic.
    ---------------------------------------------------------------------------
    u_metrics : entity work.metrics_computation_engine
        generic map (
            FRAME_LEN => FRAME_LEN,
            DATA_W    => DATA_WIDTH
        )
        port map (
            clk           => clk,
            reset_n       => reset_n,

            x_in          => x_in,
            d_in          => d_in,
            y_in          => y_s,
            e_in          => e_s,
            valid_in      => valid_s,

            metrics_out   => metrics_out_s,
            metrics_valid => metrics_valid_s
        );


    ---------------------------------------------------------------------------
    -- Output assignment
    ---------------------------------------------------------------------------
    y_out     <= y_s;
    e_out     <= e_s;
    valid_out <= valid_s;

    metrics_out   <= metrics_out_s;
    metrics_valid <= metrics_valid_s;


    ---------------------------------------------------------------------------
    -- Debug LEDs
    --
    -- LED0 = LMS selected
    -- LED1 = NLMS selected
    -- LED2 = RLS selected
    -- LED3 = input sample valid
    -- LED4 = output sample valid
    -- LED5 = filter busy
    -- LED6 = metrics valid
    -- LED7 = adaptation frozen
    ---------------------------------------------------------------------------
    led(0) <= '1' when alg_select_s = ALG_LMS  else '0';
    led(1) <= '1' when alg_select_s = ALG_NLMS else '0';
    led(2) <= '1' when alg_select_s = ALG_RLS  else '0';
    led(3) <= valid_in;
    led(4) <= valid_s;
    led(5) <= filter_busy_s;
    led(6) <= metrics_valid_s;
    led(7) <= sw(2);

end architecture rtl;