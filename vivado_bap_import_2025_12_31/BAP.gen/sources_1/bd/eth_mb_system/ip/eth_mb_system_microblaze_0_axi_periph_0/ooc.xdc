# aclk {FREQ_HZ 100000000 CLK_DOMAIN eth_mb_system_Clk PHASE 0.0}
# Clock Domain: eth_mb_system_Clk
create_clock -name aclk -period 10.000 [get_ports aclk]
# Generated clocks
