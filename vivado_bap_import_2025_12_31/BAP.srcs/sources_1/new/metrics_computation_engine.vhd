-- ============================================================================
-- Entity: metrics_computation_engine.vhd
-- Streaming metrics computation engine
--
-- Computes frame-based:
--   MSE
--   input power
--   output power
--   error power
--
-- Notes:
--   - No real arithmetic
--   - No log10
--   - No floating-point division
--   - dB conversion is done in Python
--   - Suitable for synthesis on AMD Kintex-7 / Genesys 2
-- ============================================================================

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.dsp_constants_and_types.all;

entity metrics_computation_engine is
    generic (
        FRAME_LEN : integer := 1024;
        DATA_W    : integer := DATA_WIDTH
    );
    port (
        clk           : in  std_logic;
        reset_n       : in  std_logic;

        x_in          : in  fix_point;
        d_in          : in  fix_point;
        y_in          : in  fix_point;
        e_in          : in  fix_point;
        valid_in      : in  std_logic;

        metrics_out   : out metrics_record;
        metrics_valid : out std_logic
    );
end entity metrics_computation_engine;


architecture rtl of metrics_computation_engine is

    constant ACC_W     : integer := 64;
    constant AVG_SHIFT : integer := log2ceil(FRAME_LEN);

    signal sample_cnt : integer range 0 to FRAME_LEN := 0;

    signal mse_acc    : signed(ACC_W-1 downto 0) := (others => '0');
    signal xpow_acc   : signed(ACC_W-1 downto 0) := (others => '0');
    signal ypow_acc   : signed(ACC_W-1 downto 0) := (others => '0');
    signal epow_acc   : signed(ACC_W-1 downto 0) := (others => '0');
    signal dpow_acc   : signed(ACC_W-1 downto 0) := (others => '0');

begin

    process(clk, reset_n)
        variable e2_var      : fix_point;
        variable x2_var      : fix_point;
        variable y2_var      : fix_point;
        variable d2_var      : fix_point;

        variable mse_next    : signed(ACC_W-1 downto 0);
        variable xpow_next   : signed(ACC_W-1 downto 0);
        variable ypow_next   : signed(ACC_W-1 downto 0);
        variable epow_next   : signed(ACC_W-1 downto 0);
        variable dpow_next   : signed(ACC_W-1 downto 0);

        variable mse_avg     : signed(ACC_W-1 downto 0);
        variable xpow_avg    : signed(ACC_W-1 downto 0);
        variable ypow_avg    : signed(ACC_W-1 downto 0);
        variable epow_avg    : signed(ACC_W-1 downto 0);
        variable dpow_avg    : signed(ACC_W-1 downto 0);
    begin
        if reset_n = '0' then

            sample_cnt <= 0;

            mse_acc  <= (others => '0');
            xpow_acc <= (others => '0');
            ypow_acc <= (others => '0');
            epow_acc <= (others => '0');
            dpow_acc <= (others => '0');

            metrics_out.mse     <= FIX_ZERO;
            metrics_out.emse    <= FIX_ZERO;
            metrics_out.jmin    <= FIX_ZERO;
            metrics_out.misadj  <= FIX_ZERO;
            metrics_out.snr_in  <= FIX_ZERO;
            metrics_out.snr_out <= FIX_ZERO;
            metrics_out.dsnr    <= FIX_ZERO;
            metrics_out.n90     <= 0;

            metrics_valid <= '0';

        elsif rising_edge(clk) then

            metrics_valid <= '0';

            if valid_in = '1' then

                e2_var := safe_square(e_in);
                x2_var := safe_square(x_in);
                y2_var := safe_square(y_in);
                d2_var := safe_square(d_in);

                mse_next  := mse_acc  + resize(e2_var, ACC_W);
                xpow_next := xpow_acc + resize(x2_var, ACC_W);
                ypow_next := ypow_acc + resize(y2_var, ACC_W);
                epow_next := epow_acc + resize(e2_var, ACC_W);
                dpow_next := dpow_acc + resize(d2_var, ACC_W);

                mse_acc  <= mse_next;
                xpow_acc <= xpow_next;
                ypow_acc <= ypow_next;
                epow_acc <= epow_next;
                dpow_acc <= dpow_next;

                if sample_cnt = FRAME_LEN - 1 then

                    mse_avg  := shift_right(mse_next,  AVG_SHIFT);
                    xpow_avg := shift_right(xpow_next, AVG_SHIFT);
                    ypow_avg := shift_right(ypow_next, AVG_SHIFT);
                    epow_avg := shift_right(epow_next, AVG_SHIFT);
                    dpow_avg := shift_right(dpow_next, AVG_SHIFT);

                    -- Main metric: mean squared error
                    metrics_out.mse <= resize_sat(mse_avg);

                    -- These fields are kept for compatibility with metrics_record.
                    -- More advanced EMSE/Jmin/misadjustment can be evaluated in Python.
                    metrics_out.emse   <= FIX_ZERO;
                    metrics_out.jmin <= resize_sat(dpow_avg);
                    metrics_out.misadj <= FIX_ZERO;

                    -- Raw linear powers, not dB.
                    -- Convert to dB later in Python.
                    metrics_out.snr_in  <= resize_sat(xpow_avg);
                    metrics_out.snr_out <= resize_sat(ypow_avg);
                    metrics_out.dsnr    <= resize_sat(epow_avg);

                    metrics_out.n90 <= 0;

                    metrics_valid <= '1';

                    sample_cnt <= 0;

                    mse_acc  <= (others => '0');
                    xpow_acc <= (others => '0');
                    ypow_acc <= (others => '0');
                    epow_acc <= (others => '0');
                    dpow_acc <= (others => '0');

                else
                    sample_cnt <= sample_cnt + 1;
                end if;

            end if;
        end if;
    end process;

end architecture rtl;