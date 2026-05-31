-- ============================================================================
-- Entity: nlms_filter_core.vhd
-- NLMS adaptive filter, synthesizable Q16.16 implementation
-- ============================================================================

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.dsp_constants_and_types.all;

entity nlms_filter_core is
    generic (
        NUM_TAPS : integer := 32;
        DATA_W   : integer := DATA_WIDTH
    );
    port (
        clk          : in  std_logic;
        reset_n      : in  std_logic;

        mu           : in  fix_point;
        eps          : in  fix_point := EPS_FIX;
        num_taps_cfg     : in  integer range 1 to NUM_TAPS;

        x_in         : in  fix_point;
        d_in         : in  fix_point;
        valid_in     : in  std_logic;

        y_out        : out fix_point;
        e_out        : out fix_point;
        valid_out    : out std_logic;

        init_weights : in  std_logic;
        freeze       : in  std_logic
    );
end entity;


architecture rtl of nlms_filter_core is

    constant ACC_W : integer := DATA_W + 16;

    type sample_array_t is array (0 to NUM_TAPS-1) of fix_point;

    signal x_delay : sample_array_t := (others => (others => '0'));
    signal weights : sample_array_t := (others => (others => '0'));

    signal mu_clamped : fix_point := MU_DEFAULT_NLMS;

    signal y_reg : fix_point := (others => '0');
    signal e_reg : fix_point := (others => '0');

    signal norm_inv      : fix_point := FIX_ONE;
    signal update_active : std_logic := '0';
    signal tap_cnt       : integer range 0 to NUM_TAPS-1 := 0;

begin

    process(clk)
    begin
        if rising_edge(clk) then
            if mu > MU_NLMS_MAX then
                mu_clamped <= MU_NLMS_MAX;
            elsif mu(mu'high) = '1' then
                mu_clamped <= FIX_ZERO;
            else
                mu_clamped <= mu;
            end if;
        end if;
    end process;


    process(clk, reset_n)
        variable x_next       : sample_array_t;
        variable y_acc        : signed(ACC_W-1 downto 0);
        variable p_acc        : signed(ACC_W-1 downto 0);
        variable y_fix        : fix_point;
        variable p_fix        : fix_point;
        variable mu_e         : fix_point;
        variable mu_e_norm    : fix_point;
        variable weight_delta : fix_point;
    begin
        if reset_n = '0' then
            x_delay       <= (others => (others => '0'));
            weights       <= (others => (others => '0'));
            y_reg         <= (others => '0');
            e_reg         <= (others => '0');
            norm_inv      <= FIX_ONE;
            update_active <= '0';
            tap_cnt       <= 0;
            valid_out     <= '0';

        elsif rising_edge(clk) then
            valid_out <= '0';

            if init_weights = '1' then
                weights <= (others => (others => '0'));
            end if;

            if valid_in = '1' and update_active = '0' then

                x_next := x_delay;

                for i in NUM_TAPS-1 downto 1 loop
                    x_next(i) := x_delay(i-1);
                end loop;
                x_next(0) := x_in;

                y_acc := (others => '0');
                p_acc := (others => '0');

                for i in 0 to NUM_TAPS-1 loop
                    if i < num_taps_cfg then
                        y_acc := y_acc + resize(
                            safe_multiply(weights(i), x_next(i)),
                            y_acc'length
                        );

                        p_acc := p_acc + resize(
                            safe_square(x_next(i)),
                            p_acc'length
                        );
                    end if;
                end loop;

                y_fix := resize_sat(y_acc);
                p_fix := sat_add(resize_sat(p_acc), eps);

                y_reg    <= y_fix;
                e_reg    <= sat_sub(d_in, y_fix);
                norm_inv <= reciprocal_power_approx(p_fix);
                x_delay  <= x_next;

                tap_cnt       <= 0;
                update_active <= '1';

            elsif update_active = '1' then

                if freeze = '0' then
                    mu_e      := safe_multiply(mu_clamped, e_reg);
                    mu_e_norm := safe_multiply(mu_e, norm_inv);

                    weight_delta := safe_multiply(mu_e_norm, x_delay(tap_cnt));
                    weights(tap_cnt) <= sat_add(weights(tap_cnt), weight_delta);
                end if;

                if tap_cnt = num_taps_cfg - 1 then
                    tap_cnt       <= 0;
                    update_active <= '0';
                    valid_out     <= '1';
                else
                    tap_cnt <= tap_cnt + 1;
                end if;

            end if;
        end if;
    end process;

    y_out <= y_reg;
    e_out <= e_reg;

end architecture;