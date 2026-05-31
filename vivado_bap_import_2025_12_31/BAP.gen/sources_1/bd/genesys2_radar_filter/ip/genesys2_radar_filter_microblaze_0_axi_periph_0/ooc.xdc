# aclk {FREQ_HZ 125000000 CLK_DOMAIN genesys2_radar_filter_clk_125M PHASE 0.0} aclk1 {FREQ_HZ 225022502 CLK_DOMAIN genesys2_radar_filter_mig_7series_0_0_ui_clk PHASE 0}
# Clock Domain: genesys2_radar_filter_clk_125M
create_clock -name aclk -period 8.000 [get_ports aclk]
# Clock Domain: genesys2_radar_filter_mig_7series_0_0_ui_clk
create_clock -name aclk1 -period 4.444 [get_ports aclk1]
# Generated clocks
