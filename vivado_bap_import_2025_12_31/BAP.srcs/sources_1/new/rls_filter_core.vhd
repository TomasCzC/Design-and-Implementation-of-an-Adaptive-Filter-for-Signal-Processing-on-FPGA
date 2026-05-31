-- ============================================================================
-- Entity: rls_filter_core.vhd
-- Sequential fixed-point RLS adaptive filter
-- Target: Genesys 2 / AMD Kintex-7
-- Format: signed Q16.16
-- ============================================================================

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.dsp_constants_and_types.all;

entity rls_filter_core is
    generic (
        NUM_TAPS : integer := 16;
        DATA_W   : integer := DATA_WIDTH
    );
    port (
        clk          : in  std_logic;
        reset_n      : in  std_logic;

        lambda       : in  fix_point;
        delta        : in  fix_point := FIX_ONE;
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


architecture rtl of rls_filter_core is

    constant ACC_W : integer := DATA_W + 16;

    type vec_t is array (0 to NUM_TAPS-1) of fix_point;
    type matrix_row_t is array (0 to NUM_TAPS-1) of fix_point;
    type matrix_t is array (0 to NUM_TAPS-1) of matrix_row_t;

    signal x_delay : vec_t := (others => (others => '0'));
    signal w       : vec_t := (others => (others => '0'));

    signal P       : matrix_t;
    signal p_x     : vec_t := (others => (others => '0'));
    signal x_p     : vec_t := (others => (others => '0'));
    signal k_vec   : vec_t := (others => (others => '0'));

    signal y_reg   : fix_point := (others => '0');
    signal e_reg   : fix_point := (others => '0');

    type state_t is (
        S_IDLE,
        S_COMPUTE_Y,
        S_COMPUTE_PX,
        S_COMPUTE_DENOM,
        S_NORMALIZE_K,
        S_COMPUTE_XP,
        S_UPDATE_W,
        S_UPDATE_P,
        S_OUTPUT
    );

    signal state   : state_t := S_IDLE;

    signal row_cnt : integer range 0 to NUM_TAPS-1 := 0;
    signal col_cnt : integer range 0 to NUM_TAPS-1 := 0;

    signal y_accum     : signed(ACC_W-1 downto 0) := (others => '0');
    signal denom_accum : fix_point := FIX_ZERO;
    signal inv_denom   : fix_point := FIX_ONE;
    signal inv_lambda  : fix_point := FIX_ONE;

begin

    process(clk, reset_n)
        variable x_next       : vec_t;
        variable acc_next     : signed(ACC_W-1 downto 0);
        variable px_acc       : signed(ACC_W-1 downto 0);
        variable xp_acc       : signed(ACC_W-1 downto 0);
        variable denom_next   : fix_point;
        variable p_update     : fix_point;
        variable w_delta      : fix_point;
    begin
        if reset_n = '0' then
            x_delay     <= (others => (others => '0'));
            w           <= (others => (others => '0'));
            p_x         <= (others => (others => '0'));
            x_p         <= (others => (others => '0'));
            k_vec       <= (others => (others => '0'));
            y_reg       <= (others => '0');
            e_reg       <= (others => '0');
            y_accum     <= (others => '0');
            denom_accum <= FIX_ZERO;
            inv_denom   <= FIX_ONE;
            inv_lambda  <= FIX_ONE;
            row_cnt     <= 0;
            col_cnt     <= 0;
            valid_out   <= '0';
            state       <= S_IDLE;

            for i in 0 to NUM_TAPS-1 loop
                for j in 0 to NUM_TAPS-1 loop
                    if i = j then
                        P(i)(j) <= FIX_ONE;
                    else
                        P(i)(j) <= FIX_ZERO;
                    end if;
                end loop;
            end loop;

        elsif rising_edge(clk) then
            valid_out <= '0';

            if init_weights = '1' then
                w <= (others => (others => '0'));

                for i in 0 to NUM_TAPS-1 loop
                    for j in 0 to NUM_TAPS-1 loop
                        if i = j then
                            P(i)(j) <= delta;
                        else
                            P(i)(j) <= FIX_ZERO;
                        end if;
                    end loop;
                end loop;
            end if;

            case state is

                when S_IDLE =>
                    if valid_in = '1' then
                        x_next := x_delay;

                        for i in NUM_TAPS-1 downto 1 loop
                            x_next(i) := x_delay(i-1);
                        end loop;
                        x_next(0) := x_in;

                        x_delay <= x_next;
                        y_accum <= (others => '0');
                        row_cnt <= 0;
                        state   <= S_COMPUTE_Y;
                    end if;


                when S_COMPUTE_Y =>
                    acc_next := y_accum + resize(
                        safe_multiply(w(row_cnt), x_delay(row_cnt)),
                        y_accum'length
                    );

                    y_accum <= acc_next;

                    if row_cnt = num_taps_cfg - 1 then
                        y_reg   <= resize_sat(acc_next);
                        e_reg   <= sat_sub(d_in, resize_sat(acc_next));
                        row_cnt <= 0;
                        state   <= S_COMPUTE_PX;
                    else
                        row_cnt <= row_cnt + 1;
                    end if;


                when S_COMPUTE_PX =>
                    px_acc := (others => '0');

                    for j in 0 to NUM_TAPS-1 loop
                        if j < num_taps_cfg then
                            px_acc := px_acc + resize(
                                safe_multiply(P(row_cnt)(j), x_delay(j)),
                                px_acc'length
                            );
                        end if;
                    end loop;

                    p_x(row_cnt) <= resize_sat(px_acc);

                    if row_cnt = num_taps_cfg - 1 then
                        denom_accum <= lambda;
                        row_cnt     <= 0;
                        state       <= S_COMPUTE_DENOM;
                    else
                        row_cnt <= row_cnt + 1;
                    end if;


                when S_COMPUTE_DENOM =>
                    denom_next := sat_add(
                        denom_accum,
                        safe_multiply(x_delay(row_cnt), p_x(row_cnt))
                    );

                    denom_accum <= denom_next;

                    if row_cnt = num_taps_cfg - 1 then
                        inv_denom <= reciprocal_power_approx(denom_next);
                        row_cnt   <= 0;
                        state     <= S_NORMALIZE_K;
                    else
                        row_cnt <= row_cnt + 1;
                    end if;


                when S_NORMALIZE_K =>
                    k_vec(row_cnt) <= safe_multiply(p_x(row_cnt), inv_denom);

                    if row_cnt = num_taps_cfg - 1 then
                        row_cnt <= 0;
                        state   <= S_COMPUTE_XP;
                    else
                        row_cnt <= row_cnt + 1;
                    end if;


                when S_COMPUTE_XP =>
                    xp_acc := (others => '0');

                    for j in 0 to NUM_TAPS-1 loop
                        if j < num_taps_cfg then
                            xp_acc := xp_acc + resize(
                                safe_multiply(x_delay(j), P(j)(row_cnt)),
                                xp_acc'length
                            );
                        end if;
                    end loop;

                    x_p(row_cnt) <= resize_sat(xp_acc);

                    if row_cnt = num_taps_cfg - 1 then
                        row_cnt    <= 0;
                        inv_lambda <= reciprocal_power_approx(lambda);
                        state      <= S_UPDATE_W;
                    else
                        row_cnt <= row_cnt + 1;
                    end if;


                when S_UPDATE_W =>
                    if freeze = '0' then
                        w_delta := safe_multiply(k_vec(row_cnt), e_reg);
                        w(row_cnt) <= sat_add(w(row_cnt), w_delta);
                    end if;

                    if row_cnt = num_taps_cfg - 1 then
                        row_cnt <= 0;
                        col_cnt <= 0;
                        state   <= S_UPDATE_P;
                    else
                        row_cnt <= row_cnt + 1;
                    end if;


                when S_UPDATE_P =>
                    if freeze = '0' then
                        p_update := safe_multiply(k_vec(row_cnt), x_p(col_cnt));
                        P(row_cnt)(col_cnt) <= safe_multiply(
                            sat_sub(P(row_cnt)(col_cnt), p_update),
                            inv_lambda
                        );
                    end if;

                    if col_cnt = num_taps_cfg - 1 then
                        col_cnt <= 0;

                        if row_cnt = num_taps_cfg - 1 then
                            row_cnt <= 0;
                            state   <= S_OUTPUT;
                        else
                            row_cnt <= row_cnt + 1;
                        end if;
                    else
                        col_cnt <= col_cnt + 1;
                    end if;


                when S_OUTPUT =>
                    valid_out <= '1';
                    state     <= S_IDLE;

            end case;
        end if;
    end process;

    y_out <= y_reg;
    e_out <= e_reg;

end architecture;