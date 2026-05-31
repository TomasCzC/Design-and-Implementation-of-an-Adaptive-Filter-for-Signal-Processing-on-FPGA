-- ============================================================================
-- Entity: filter_runner_controller.vhd
-- Filter selector for LMS / NLMS / RLS
-- ============================================================================

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.dsp_constants_and_types.all;

entity filter_runner_controller is
    generic (
        MAX_TAPS : integer := 16;
        DATA_W   : integer := DATA_WIDTH
    );
    port (
        clk            : in  std_logic;
        reset_n        : in  std_logic;

        alg_select     : in  filter_algorithm;

        params_mu      : in  fix_point;
        params_lambda  : in  fix_point := FIX_ONE;
        params_eps     : in  fix_point := EPS_FIX;

        limit_mu_lo    : in  fix_point := FIX_ZERO;
        limit_mu_hi    : in  fix_point := MU_NLMS_MAX;

        num_taps       : in  integer range 1 to MAX_TAPS;

        x_in           : in  fix_point;
        d_in           : in  fix_point;
        valid_in       : in  std_logic;

        y_out          : out fix_point;
        e_out          : out fix_point;

        w_monitor_addr : out integer range 0 to MAX_TAPS-1;
        w_monitor_data : out fix_point;

        valid_out      : out std_logic;

        start          : in  std_logic;
        init_w         : in  std_logic;
        freeze         : in  std_logic;
        busy           : out std_logic
    );
end entity;


architecture structural of filter_runner_controller is

    signal enforced_mu : fix_point := MU_DEFAULT_LMS;

    signal lms_valid_in  : std_logic;
    signal nlms_valid_in : std_logic;
    signal rls_valid_in  : std_logic;

    signal lms_y_sig  : fix_point;
    signal lms_e_sig  : fix_point;
    signal nlms_y_sig : fix_point;
    signal nlms_e_sig : fix_point;
    signal rls_y_sig  : fix_point;
    signal rls_e_sig  : fix_point;

    signal lms_valid_sig  : std_logic;
    signal nlms_valid_sig : std_logic;
    signal rls_valid_sig  : std_logic;

    signal lms_w_addr : integer range 0 to MAX_TAPS-1;
    signal lms_w_data : fix_point;

begin

    lms_valid_in  <= valid_in when alg_select = ALG_LMS  else '0';
    nlms_valid_in <= valid_in when alg_select = ALG_NLMS else '0';
    rls_valid_in  <= valid_in when alg_select = ALG_RLS  else '0';


    process(clk, reset_n)
        variable clipped_mu : fix_point;
    begin
        if reset_n = '0' then
            enforced_mu <= MU_DEFAULT_LMS;

        elsif rising_edge(clk) then
            if params_mu > limit_mu_hi then
                clipped_mu := limit_mu_hi;
            elsif params_mu < limit_mu_lo then
                clipped_mu := limit_mu_lo;
            else
                clipped_mu := params_mu;
            end if;

            case alg_select is
                when ALG_NLMS =>
                    if clipped_mu > MU_NLMS_MAX then
                        enforced_mu <= MU_NLMS_MAX;
                    else
                        enforced_mu <= clipped_mu;
                    end if;

                when ALG_LMS =>
                    enforced_mu <= clipped_mu;

                when ALG_RLS =>
                    enforced_mu <= clipped_mu;
            end case;
        end if;
    end process;


    u_lms : entity work.lms_filter_core
        generic map (
            NUM_TAPS => MAX_TAPS,
            DATA_W   => DATA_W
        )
        port map (
            clk          => clk,
            reset_n      => reset_n,
            mu           => enforced_mu,
            num_taps_cfg => num_taps,
            x_in         => x_in,
            d_in         => d_in,
            valid_in     => lms_valid_in,
            y_out        => lms_y_sig,
            e_out        => lms_e_sig,
            w_out_addr   => lms_w_addr,
            w_out_data   => lms_w_data,
            valid_out    => lms_valid_sig,
            init_weights => init_w,
            freeze       => freeze
        );


    u_nlms : entity work.nlms_filter_core
        generic map (
            NUM_TAPS => MAX_TAPS,
            DATA_W   => DATA_W
        )
        port map (
            clk          => clk,
            reset_n      => reset_n,
            mu           => enforced_mu,
            eps          => params_eps,
            num_taps_cfg     => num_taps,
            x_in         => x_in,
            d_in         => d_in,
            valid_in     => nlms_valid_in,
            y_out        => nlms_y_sig,
            e_out        => nlms_e_sig,
            valid_out    => nlms_valid_sig,
            init_weights => init_w,
            freeze       => freeze
        );


    u_rls : entity work.rls_filter_core
        generic map (
            NUM_TAPS => MAX_TAPS,
            DATA_W   => DATA_W
        )
        port map (
            clk          => clk,
            reset_n      => reset_n,
            lambda       => params_lambda,
            delta        => FIX_ONE,
            num_taps_cfg     => num_taps,
            x_in         => x_in,
            d_in         => d_in,
            valid_in     => rls_valid_in,
            y_out        => rls_y_sig,
            e_out        => rls_e_sig,
            valid_out    => rls_valid_sig,
            init_weights => init_w,
            freeze       => freeze
        );


    process(alg_select,
            lms_y_sig, lms_e_sig, lms_valid_sig,
            nlms_y_sig, nlms_e_sig, nlms_valid_sig,
            rls_y_sig, rls_e_sig, rls_valid_sig,
            lms_w_addr, lms_w_data)
    begin
        y_out          <= FIX_ZERO;
        e_out          <= FIX_ZERO;
        valid_out      <= '0';
        w_monitor_addr <= 0;
        w_monitor_data <= FIX_ZERO;

        case alg_select is
            when ALG_LMS =>
                y_out          <= lms_y_sig;
                e_out          <= lms_e_sig;
                valid_out      <= lms_valid_sig;
                w_monitor_addr <= lms_w_addr;
                w_monitor_data <= lms_w_data;

            when ALG_NLMS =>
                y_out          <= nlms_y_sig;
                e_out          <= nlms_e_sig;
                valid_out      <= nlms_valid_sig;

            when ALG_RLS =>
                y_out          <= rls_y_sig;
                e_out          <= rls_e_sig;
                valid_out      <= rls_valid_sig;
        end case;
    end process;

    busy <= start or valid_in or lms_valid_sig or nlms_valid_sig or rls_valid_sig;

end architecture;