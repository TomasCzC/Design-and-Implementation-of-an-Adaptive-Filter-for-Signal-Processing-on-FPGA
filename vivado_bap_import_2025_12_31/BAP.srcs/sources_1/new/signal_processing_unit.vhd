-- ============================================================================
-- Entity: signal_processing_unit.vhd
-- Basic safe fixed-point processing unit
-- ============================================================================

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.dsp_constants_and_types.all;

entity signal_processing_unit is
    generic (
        DATA_W : integer := DATA_WIDTH
    );
    port (
        clk         : in  std_logic;
        reset_n     : in  std_logic;

        op_mode     : in  std_logic_vector(2 downto 0);
        -- 000: clamp
        -- 001: square
        -- 010: log10 square placeholder
        -- 011: abs
        -- 100: pass cleaned sample

        data_in     : in  fix_point;
        data_in_re  : in  fix_point := (others => '0');
        data_in_im  : in  fix_point := (others => '0');
        is_complex  : in  std_logic := '0';
        max_val     : in  fix_point := FIX_MAX;
        valid_in    : in  std_logic;

        data_out    : out fix_point;
        valid_out   : out std_logic;
        busy        : out std_logic
    );
end entity;


architecture rtl of signal_processing_unit is

    signal output_reg : fix_point := (others => '0');
    signal valid_reg  : std_logic := '0';
    signal busy_reg   : std_logic := '0';

begin

    process(clk, reset_n)
        variable abs_re     : fix_point;
        variable abs_im     : fix_point;
        variable mx         : fix_point;
        variable mn         : fix_point;
        variable mag_approx : fix_point;
        variable cleaned    : fix_point;
    begin
        if reset_n = '0' then
            output_reg <= (others => '0');
            valid_reg  <= '0';
            busy_reg   <= '0';

        elsif rising_edge(clk) then
            valid_reg <= '0';
            busy_reg  <= '0';

            if valid_in = '1' then
                busy_reg <= '1';

                if is_complex = '1' then
                    abs_re := safe_abs(data_in_re);
                    abs_im := safe_abs(data_in_im);

                    if abs_re > abs_im then
                        mx := abs_re;
                        mn := abs_im;
                    else
                        mx := abs_im;
                        mn := abs_re;
                    end if;

                    mag_approx := sat_add(mx, shift_right(mn, 1));
                    cleaned := clamp_value(mag_approx, max_val);
                else
                    cleaned := clamp_value(data_in, max_val);
                end if;

                case op_mode is
                    when "000" =>
                        output_reg <= cleaned;

                    when "001" =>
                        output_reg <= safe_square(cleaned);

                    when "010" =>
                        output_reg <= safe_log10_of_square(cleaned);

                    when "011" =>
                        output_reg <= safe_abs(cleaned);

                    when "100" =>
                        output_reg <= cleaned;

                    when others =>
                        output_reg <= FIX_ZERO;
                end case;

                valid_reg <= '1';
            end if;
        end if;
    end process;

    data_out  <= output_reg;
    valid_out <= valid_reg;
    busy      <= busy_reg;

end architecture;