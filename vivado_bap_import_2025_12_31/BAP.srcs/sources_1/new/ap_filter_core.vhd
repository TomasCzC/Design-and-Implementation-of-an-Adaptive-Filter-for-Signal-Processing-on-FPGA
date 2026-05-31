-- ============================================================================
-- Entity: ap_filter_core.vhd
-- Implements AP (Affine Projection) Adaptive Filter
-- With stability enforcement: mu < 1/order
-- ============================================================================
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.dsp_constants_and_types.all;

entity ap_filter_core is
    generic (
        NUM_TAPS   : integer := 32;
        MAX_ORDER  : integer := 8;             -- AP projection order
        DATA_W     : integer := DATA_WIDTH
    );
    port (
        clk        : in  std_logic;
        reset_n    : in  std_logic;
        
        mu         : in  fix_point;
        ap_order   : in  integer range 1 to MAX_ORDER;
        eps        : in  fix_point := to_fixpoint(1e-6);
        num_taps   : in  integer range 1 to NUM_TAPS;
        
        x_in       : in  fix_point;
        d_in       : in  fix_point;
        valid_in   : in  std_logic;
        
        y_out      : out fix_point;
        e_out      : out fix_point;
        valid_out  : out std_logic;
        
        init_weights : in  std_logic;
        freeze     : in  std_logic
    );
end entity;

architecture rtl of ap_filter_core is
    
    -- Input matrix (order x taps)
    type input_matrix is array (0 to MAX_ORDER-1, 0 to NUM_TAPS-1) of fix_point;
    signal X_mat : input_matrix := (others => (others => (others => '0')));
    
    -- Error vector
    type error_vec is array (0 to MAX_ORDER-1) of fix_point;
    signal e_vec : error_vec := (others => (others => '0'));
    
    -- Weights
    type weight_vec is array (0 to NUM_TAPS-1) of fix_point;
    signal w     : weight_vec := (others => (others => '0'));
    
    -- Clamped mu: mu < 1/order
    signal mu_clamped : fix_point;
    
    -- State machine
    type ap_state is (AP_IDLE, AP_SHIFT_X, AP_COMPUTE_E, AP_SOLVE, 
                      AP_UPDATE_W, AP_OUTPUT);
    signal state : ap_state := AP_IDLE;
    
    signal y_reg : fix_point;
    signal ord_cnt : integer range 0 to MAX_ORDER-1 := 0;
    signal tap_cnt : integer range 0 to NUM_TAPS-1 := 0;
    
begin
    
    -- Stability enforcement
    process(clk)
        variable mu_max : real;
    begin
        if rising_edge(clk) then
            mu_max := 1.0 / real(ap_order) - 1e-6;
            if to_real(mu) > mu_max then
                mu_clamped <= to_fixpoint(mu_max);
            else
                mu_clamped <= mu;
            end if;
        end if;
    end process;
    
    process(clk, reset_n)
        variable y_acc : signed(DATA_W+15 downto 0);
    begin
        if reset_n = '0' then
            X_mat <= (others => (others => (others => '0')));
            w     <= (others => (others => '0'));
            state <= AP_IDLE;
            y_reg <= (others => '0');
            
        elsif rising_edge(clk) then
            valid_out <= '0';
            
            if init_weights = '1' then
                w <= (others => (others => '0'));
                X_mat <= (others => (others => (others => '0')));
            end if;
            
            case state is
                
                when AP_IDLE =>
                    if valid_in = '1' then
                        state <= AP_SHIFT_X;
                        ord_cnt <= 0;
                    end if;
                
                when AP_SHIFT_X =>
                    -- Shift input matrix rows up
                    for o in MAX_ORDER-1 downto 1 loop
                        for t in 0 to num_taps-1 loop
                            X_mat(o, t) <= X_mat(o-1, t);
                        end loop;
                    end loop;
                    
                    -- New row at position 0
                    if tap_cnt = 0 then
                        X_mat(0, 0) <= x_in;
                    end if;
                    
                    if tap_cnt = num_taps - 1 then
                        state <= AP_COMPUTE_E;
                        tap_cnt <= 0;
                        y_acc := (others => '0');
                    else
                        if tap_cnt > 0 then
                            X_mat(0, tap_cnt) <= X_mat(0, tap_cnt-1);  -- Simplified shift
                        end if;
                        tap_cnt <= tap_cnt + 1;
                    end if;
                
                when AP_COMPUTE_E =>
                    -- Compute errors for each order
                    y_acc := (others => '0');
                    for t in 0 to num_taps-1 loop
                        y_acc := y_acc + resize(safe_multiply(w(t), X_mat(ord_cnt, t)), y_acc'length);
                    end loop;
                    
                    -- Need desired vector here - simplified assumes d_in is scalar
                    e_vec(ord_cnt) <= d_in - y_acc(FRAC_BITS+DATA_W-1 downto FRAC_BITS);
                    
                    if ord_cnt = ap_order - 1 then
                        y_reg <= y_acc(FRAC_BITS+DATA_W-1 downto FRAC_BITS);
                        state <= AP_SOLVE;
                        tap_cnt <= 0;
                    else
                        ord_cnt <= ord_cnt + 1;
                    end if;
                
                when AP_SOLVE =>
                    -- Solve simplified AP update (would need matrix inversion in full version)
                    -- Using approximate solution for hardware efficiency
                    if freeze = '0' then
                        variable update : fix_point;
                    begin
                        update := safe_multiply(
                            safe_multiply(mu_clamped, e_vec(0)),
                            X_mat(0, tap_cnt)
                        );
                        w(tap_cnt) <= w(tap_cnt) + update;
                    end if;
                    
                    if tap_cnt = num_taps - 1 then
                        state <= AP_OUTPUT;
                    else
                        tap_cnt <= tap_cnt + 1;
                    end if;
                
                when AP_OUTPUT =>
                    y_out <= y_reg;
                    e_out <= e_vec(0);
                    valid_out <= '1';
                    state <= AP_IDLE;
                
            end case;
        end if;
    end process;
    
end architecture;