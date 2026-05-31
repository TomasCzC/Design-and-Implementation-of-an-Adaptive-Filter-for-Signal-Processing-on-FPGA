-- ============================================================================
-- Package: dsp_constants_and_types.vhd
-- Common fixed-point types and synthesizable helper functions
-- Target: Genesys 2 / AMD Kintex-7 XC7K325T
-- Format: signed Q16.16
-- ============================================================================

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

package dsp_constants_and_types is

    constant CLK_FREQ       : integer := 200_000_000;
    constant DATA_WIDTH     : integer := 32;
    constant FRAC_BITS      : integer := 16;
    constant INT_BITS       : integer := DATA_WIDTH - FRAC_BITS;

    constant MAX_TAP_COUNT  : integer := 128;
    constant MAX_DATA_LEN   : integer := 4096;
    constant FFT_POINTS     : integer := 1024;

    subtype fix_point is signed(DATA_WIDTH-1 downto 0);
    type fix_point_array is array (natural range <>) of fix_point;

    type complex_fix is record
        re : fix_point;
        im : fix_point;
    end record;

    type complex_fix_array is array (natural range <>) of complex_fix;

    type filter_algorithm is (
        ALG_LMS,
        ALG_NLMS,
        ALG_RLS
    );

    type operation_status is (IDLE, BUSY, DONE, ERROR);

    type metrics_record is record
        mse     : fix_point;
        emse    : fix_point;
        jmin    : fix_point;
        misadj  : fix_point;
        snr_in  : fix_point;
        snr_out : fix_point;
        dsnr    : fix_point;
        n90     : integer;
    end record;

    type filter_params is record
        mu      : fix_point;
        order   : integer;
        lambda  : fix_point;
        eps     : fix_point;
        beta    : fix_point;
    end record;

    type ram_read_port is record
        addr    : integer range 0 to MAX_DATA_LEN-1;
        data    : fix_point;
        enable  : std_logic;
    end record;

    type ram_write_port is record
        addr    : integer range 0 to MAX_DATA_LEN-1;
        data    : fix_point;
        enable  : std_logic;
    end record;

    constant SCALE_Q16 : integer := 2**FRAC_BITS;

    constant FIX_ZERO     : fix_point := to_signed(0, DATA_WIDTH);
    constant FIX_ONE      : fix_point := to_signed(SCALE_Q16, DATA_WIDTH);
    constant FIX_TWO      : fix_point := to_signed(2*SCALE_Q16, DATA_WIDTH);
    constant FIX_FOUR     : fix_point := to_signed(4*SCALE_Q16, DATA_WIDTH);
    constant FIX_HALF     : fix_point := to_signed(SCALE_Q16/2, DATA_WIDTH);
    constant FIX_QUARTER  : fix_point := to_signed(SCALE_Q16/4, DATA_WIDTH);
    constant FIX_EIGHTH   : fix_point := to_signed(SCALE_Q16/8, DATA_WIDTH);

    constant FIX_MAX      : fix_point := to_signed(2147483647, DATA_WIDTH);
    constant FIX_MIN      : fix_point := to_signed(-2147483647, DATA_WIDTH);
    constant EPS_FIX      : fix_point := to_signed(1, DATA_WIDTH);

    constant MU_DEFAULT_LMS  : fix_point := to_signed(655, DATA_WIDTH);      -- approx. 0.01
    constant MU_DEFAULT_NLMS : fix_point := to_signed(32768, DATA_WIDTH);    -- approx. 0.5
    constant MU_NLMS_MAX     : fix_point := to_signed(127795, DATA_WIDTH);   -- approx. 1.95

    function q16_frac(num : integer; den : integer) return fix_point;

    function clamp_value(a : fix_point; maxval : fix_point) return fix_point;
    function sat_add(a, b : fix_point) return fix_point;
    function sat_sub(a, b : fix_point) return fix_point;
    function resize_sat(a : signed) return fix_point;

    function safe_abs(a : fix_point) return fix_point;
    function safe_multiply(a, b : fix_point) return fix_point;
    function safe_square(a : fix_point) return fix_point;

    function safe_log10_of_square(a : fix_point) return fix_point;
    function reciprocal_power_approx(den : fix_point) return fix_point;
    function log2ceil(n : integer) return integer;

end package;


package body dsp_constants_and_types is

    function q16_frac(num : integer; den : integer) return fix_point is
        variable tmp : integer;
    begin
        if den = 0 then
            return FIX_MAX;
        else
            tmp := (num * SCALE_Q16) / den;
            return to_signed(tmp, DATA_WIDTH);
        end if;
    end function;


    function resize_sat(a : signed) return fix_point is
        variable max_ext : signed(a'range);
        variable min_ext : signed(a'range);
        variable result  : fix_point;
    begin
        max_ext := resize(FIX_MAX, a'length);
        min_ext := resize(FIX_MIN, a'length);

        if a > max_ext then
            result := FIX_MAX;
        elsif a < min_ext then
            result := FIX_MIN;
        else
            result := resize(a, DATA_WIDTH);
        end if;

        return result;
    end function;


    function clamp_value(a : fix_point; maxval : fix_point) return fix_point is
        variable result : fix_point;
    begin
        if a > maxval then
            result := maxval;
        elsif a < -maxval then
            result := -maxval;
        else
            result := a;
        end if;

        return result;
    end function;


    function sat_add(a, b : fix_point) return fix_point is
        variable tmp : signed(DATA_WIDTH downto 0);
    begin
        tmp := resize(a, DATA_WIDTH+1) + resize(b, DATA_WIDTH+1);
        return resize_sat(tmp);
    end function;


    function sat_sub(a, b : fix_point) return fix_point is
        variable tmp : signed(DATA_WIDTH downto 0);
    begin
        tmp := resize(a, DATA_WIDTH+1) - resize(b, DATA_WIDTH+1);
        return resize_sat(tmp);
    end function;


    function safe_abs(a : fix_point) return fix_point is
    begin
        if a(a'high) = '0' then
            return a;
        elsif a = FIX_MIN then
            return FIX_MAX;
        else
            return -a;
        end if;
    end function;


    function safe_multiply(a, b : fix_point) return fix_point is
        variable product_full : signed(2*DATA_WIDTH-1 downto 0);
        variable shifted_full : signed(2*DATA_WIDTH-1 downto 0);
    begin
        product_full := a * b;
        shifted_full := shift_right(product_full, FRAC_BITS);
        return resize_sat(shifted_full);
    end function;


    function safe_square(a : fix_point) return fix_point is
    begin
        return safe_multiply(a, a);
    end function;


    function safe_log10_of_square(a : fix_point) return fix_point is
    begin
        return FIX_ZERO;
    end function;


    function reciprocal_power_approx(den : fix_point) return fix_point is
    begin
        if den <= EPS_FIX then
            return FIX_ONE;
        elsif den <= FIX_QUARTER then
            return FIX_FOUR;
        elsif den <= FIX_HALF then
            return FIX_TWO;
        elsif den <= FIX_ONE then
            return FIX_ONE;
        elsif den <= FIX_TWO then
            return FIX_HALF;
        elsif den <= FIX_FOUR then
            return FIX_QUARTER;
        else
            return FIX_EIGHTH;
        end if;
    end function;


    function log2ceil(n : integer) return integer is
        variable p : integer := 1;
        variable r : integer := 0;
    begin
        while p < n loop
            p := p * 2;
            r := r + 1;
        end loop;
        return r;
    end function;

end package body;