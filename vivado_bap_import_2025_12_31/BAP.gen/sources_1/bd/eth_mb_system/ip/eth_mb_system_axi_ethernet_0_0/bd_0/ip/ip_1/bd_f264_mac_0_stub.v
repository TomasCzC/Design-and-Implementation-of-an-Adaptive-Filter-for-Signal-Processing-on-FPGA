// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2025.2 (win64) Build 6299465 Fri Nov 14 19:35:11 GMT 2025
// Date        : Fri May 29 13:47:55 2026
// Host        : TOMAS-PC running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               c:/FPGA/BAP/BAP.gen/sources_1/bd/eth_mb_system/ip/eth_mb_system_axi_ethernet_0_0/bd_0/ip/ip_1/bd_f264_mac_0_stub.v
// Design      : bd_f264_mac_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7k325tffg900-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* core_generation_info = "bd_f264_mac_0,bd_f264_mac_0_support,{x_ipProduct=Vivado 2025.2,x_ipVendor=xilinx.com,x_ipLibrary=ip,x_ipName=tri_mode_ethernet_mac,x_ipVersion=9.0,x_ipCoreRevision=39,x_ipLanguage=VHDL,x_ipSimLanguage=VHDL,c_component_name=bd_f264_mac_0,c_physical_interface=RGMII,c_half_duplex=false,c_en_iodelay=true,c_has_host=true,c_has_mdio=true,c_mdio_external=false,c_axilite_freq=150.00,c_add_filter=true,c_at_entries=4,c_family=kintex7,c_mac_speed=TRI_SPEED,c_int_clk_src=User_Clk2,c_int_mode_type=BASEX,c_has_stats=true,c_num_stats=34,c_cntr_rst=false,c_stats_width=64,c_avb=false,c_1588=0,c_tx_inband_cf_enable=false,c_rx_inband_ts_enable=false,c_tx_tuser_width=1,c_rx_vec_width=79,c_tx_vec_width=79,c_addr_width=12,c_pfc=false,c_mii_io=true,c_data_rate=1_Gbps,x_ipLicense=tri_mode_eth_mac@2015.04(hardware_evaluation),x_ipLicense=eth_avb_endpoint@2015.04(design_linking)}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "bd_f264_mac_0_support,Vivado 2025.2" *) 
module bd_f264_mac_0(gtx_clk, gtx_clk_out, gtx_clk90_out, refclk, 
  glbl_rstn, rx_axi_rstn, tx_axi_rstn, rx_enable, rx_statistics_vector, rx_statistics_valid, 
  rx_mac_aclk, rx_reset, rx_axis_mac_tdata, rx_axis_mac_tvalid, rx_axis_mac_tlast, 
  rx_axis_mac_tuser, rx_axis_filter_tuser, tx_enable, tx_ifg_delay, tx_statistics_vector, 
  tx_statistics_valid, tx_mac_aclk, tx_reset, tx_axis_mac_tdata, tx_axis_mac_tvalid, 
  tx_axis_mac_tlast, tx_axis_mac_tuser, tx_axis_mac_tready, pause_req, pause_val, speedis100, 
  speedis10100, rgmii_txd, rgmii_tx_ctl, rgmii_txc, rgmii_rxd, rgmii_rx_ctl, rgmii_rxc, 
  inband_link_status, inband_clock_speed, inband_duplex_status, mdio_i, mdio_o, mdio_t, mdc, 
  s_axi_aclk, s_axi_resetn, s_axi_awaddr, s_axi_awvalid, s_axi_awready, s_axi_wdata, 
  s_axi_wvalid, s_axi_wready, s_axi_bresp, s_axi_bvalid, s_axi_bready, s_axi_araddr, 
  s_axi_arvalid, s_axi_arready, s_axi_rdata, s_axi_rresp, s_axi_rvalid, s_axi_rready, mac_irq)
/* synthesis syn_black_box black_box_pad_pin="glbl_rstn,rx_axi_rstn,tx_axi_rstn,rx_enable,rx_statistics_vector[27:0],rx_statistics_valid,rx_reset,rx_axis_mac_tdata[7:0],rx_axis_mac_tvalid,rx_axis_mac_tlast,rx_axis_mac_tuser,rx_axis_filter_tuser[4:0],tx_enable,tx_ifg_delay[7:0],tx_statistics_vector[31:0],tx_statistics_valid,tx_reset,tx_axis_mac_tdata[7:0],tx_axis_mac_tvalid,tx_axis_mac_tlast,tx_axis_mac_tuser[0:0],tx_axis_mac_tready,pause_req,pause_val[15:0],speedis100,speedis10100,rgmii_txd[3:0],rgmii_tx_ctl,rgmii_txc,rgmii_rxd[3:0],rgmii_rx_ctl,rgmii_rxc,inband_link_status,inband_clock_speed[1:0],inband_duplex_status,mdio_i,mdio_o,mdio_t,mdc,s_axi_resetn,s_axi_awaddr[11:0],s_axi_awvalid,s_axi_awready,s_axi_wdata[31:0],s_axi_wvalid,s_axi_wready,s_axi_bresp[1:0],s_axi_bvalid,s_axi_bready,s_axi_araddr[11:0],s_axi_arvalid,s_axi_arready,s_axi_rdata[31:0],s_axi_rresp[1:0],s_axi_rvalid,s_axi_rready,mac_irq" */
/* synthesis syn_force_seq_prim="gtx_clk" */
/* synthesis syn_force_seq_prim="gtx_clk_out" */
/* synthesis syn_force_seq_prim="gtx_clk90_out" */
/* synthesis syn_force_seq_prim="refclk" */
/* synthesis syn_force_seq_prim="rx_mac_aclk" */
/* synthesis syn_force_seq_prim="tx_mac_aclk" */
/* synthesis syn_force_seq_prim="s_axi_aclk" */;
  input gtx_clk /* synthesis syn_isclock = 1 */;
  output gtx_clk_out /* synthesis syn_isclock = 1 */;
  output gtx_clk90_out /* synthesis syn_isclock = 1 */;
  input refclk /* synthesis syn_isclock = 1 */;
  input glbl_rstn;
  input rx_axi_rstn;
  input tx_axi_rstn;
  output rx_enable;
  output [27:0]rx_statistics_vector;
  output rx_statistics_valid;
  output rx_mac_aclk /* synthesis syn_isclock = 1 */;
  output rx_reset;
  output [7:0]rx_axis_mac_tdata;
  output rx_axis_mac_tvalid;
  output rx_axis_mac_tlast;
  output rx_axis_mac_tuser;
  output [4:0]rx_axis_filter_tuser;
  output tx_enable;
  input [7:0]tx_ifg_delay;
  output [31:0]tx_statistics_vector;
  output tx_statistics_valid;
  output tx_mac_aclk /* synthesis syn_isclock = 1 */;
  output tx_reset;
  input [7:0]tx_axis_mac_tdata;
  input tx_axis_mac_tvalid;
  input tx_axis_mac_tlast;
  input [0:0]tx_axis_mac_tuser;
  output tx_axis_mac_tready;
  input pause_req;
  input [15:0]pause_val;
  output speedis100;
  output speedis10100;
  output [3:0]rgmii_txd;
  output rgmii_tx_ctl;
  output rgmii_txc;
  input [3:0]rgmii_rxd;
  input rgmii_rx_ctl;
  input rgmii_rxc;
  output inband_link_status;
  output [1:0]inband_clock_speed;
  output inband_duplex_status;
  input mdio_i;
  output mdio_o;
  output mdio_t;
  output mdc;
  input s_axi_aclk /* synthesis syn_isclock = 1 */;
  input s_axi_resetn;
  input [11:0]s_axi_awaddr;
  input s_axi_awvalid;
  output s_axi_awready;
  input [31:0]s_axi_wdata;
  input s_axi_wvalid;
  output s_axi_wready;
  output [1:0]s_axi_bresp;
  output s_axi_bvalid;
  input s_axi_bready;
  input [11:0]s_axi_araddr;
  input s_axi_arvalid;
  output s_axi_arready;
  output [31:0]s_axi_rdata;
  output [1:0]s_axi_rresp;
  output s_axi_rvalid;
  input s_axi_rready;
  output mac_irq;
endmodule
