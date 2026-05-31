// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2025.2 (win64) Build 6299465 Fri Nov 14 19:35:11 GMT 2025
// Date        : Fri May 29 14:07:56 2026
// Host        : TOMAS-PC running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               c:/FPGA/BAP/BAP.gen/sources_1/bd/eth_mb_system/ip/eth_mb_system_axi_ethernet_0_0/eth_mb_system_axi_ethernet_0_0_stub.v
// Design      : eth_mb_system_axi_ethernet_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7k325tffg900-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* CHECK_LICENSE_TYPE = "eth_mb_system_axi_ethernet_0_0,bd_f264,{}" *) (* core_generation_info = "eth_mb_system_axi_ethernet_0_0,bd_f264,{x_ipProduct=Vivado 2025.2,x_ipVendor=xilinx.com,x_ipLibrary=ip,x_ipName=axi_ethernet,x_ipVersion=8.0,x_ipCoreRevision=0,x_ipLanguage=VHDL,x_ipSimLanguage=VHDL,Component_Name=eth_mb_system_axi_ethernet_0_0,IS_GT_WIZ_OLD=0,GT_SETTINGS=0,USE_BOARD_FLOW=true,ETHERNET_BOARD_INTERFACE=eth_rgmii,speed_1_2p5=1G,PHY_TYPE=RGMII,processor_mode=true,PHYRST_BOARD_INTERFACE=phy_reset_out,PHYRST_BOARD_INTERFACE_DUMMY_PORT=Custom,DIFFCLK_BOARD_INTERFACE=Custom,MDIO_BOARD_INTERFACE=eth_mdio_mdc,ENABLE_LVDS=false,Enable_1588=false,ENABLE_AVB=false,Enable_1588_1step=false,Timer_Format=0,TIMER_CLK_PERIOD=4000,PHYADDR=1,gt_type=GTH,Include_IO=true,SupportLevel=1,GTinEx=false,TransceiverControl=false,EnableAsyncSGMII=false,ClockSelection=Sync,tx_in_upper_nibble=true,txlane0_placement=DIFF_PAIR_0,rxlane0_placement=DIFF_PAIR_0,txlane1_placement=DIFF_PAIR_1,rxlane1_placement=DIFF_PAIR_1,InstantiateBitslice0=false,rxnibblebitslice0used=false,RXMEM=4k,TXMEM=4k,TXCSUM=None,RXCSUM=None,TXVLAN_TRAN=false,RXVLAN_TRAN=false,TXVLAN_TAG=false,RXVLAN_TAG=false,TXVLAN_STRP=false,RXVLAN_STRP=false,MCAST_EXTEND=false,Frame_Filter=true,Number_of_Table_Entries=4,Statistics_Counters=true,Statistics_Reset=false,Statistics_Width=64bit,Enable_Pfc=false,drpclkrate=50.0,gtrefclkrate=125,lvdsclkrate=125,axiliteclkrate=100.0,axisclkrate=100.0,gtrefclksrc=clk0,gtlocation=X0Y0,SIMULATION_MODE=false,VERSAL_GT_BOARD_FLOW=0,x_ipLicense=tri_mode_eth_mac@2015.04(hardware_evaluation),x_ipLicense=eth_avb_endpoint@2015.04(design_linking)}" *) (* downgradeipidentifiedwarnings = "yes" *) 
(* x_core_info = "bd_f264,Vivado 2025.2" *) 
module eth_mb_system_axi_ethernet_0_0(s_axi_lite_resetn, s_axi_lite_clk, mac_irq, 
  axis_clk, axi_txd_arstn, axi_txc_arstn, axi_rxd_arstn, axi_rxs_arstn, interrupt, gtx_clk, 
  phy_rst_n, ref_clk, gtx_clk90_out, gtx_clk_out, s_axi_araddr, s_axi_arready, s_axi_arvalid, 
  s_axi_awaddr, s_axi_awready, s_axi_awvalid, s_axi_bready, s_axi_bresp, s_axi_bvalid, 
  s_axi_rdata, s_axi_rready, s_axi_rresp, s_axi_rvalid, s_axi_wdata, s_axi_wready, s_axi_wstrb, 
  s_axi_wvalid, s_axis_txc_tdata, s_axis_txc_tkeep, s_axis_txc_tlast, s_axis_txc_tready, 
  s_axis_txc_tvalid, s_axis_txd_tdata, s_axis_txd_tkeep, s_axis_txd_tlast, 
  s_axis_txd_tready, s_axis_txd_tvalid, m_axis_rxd_tdata, m_axis_rxd_tkeep, 
  m_axis_rxd_tlast, m_axis_rxd_tready, m_axis_rxd_tvalid, m_axis_rxs_tdata, 
  m_axis_rxs_tkeep, m_axis_rxs_tlast, m_axis_rxs_tready, m_axis_rxs_tvalid, rgmii_rd, 
  rgmii_rx_ctl, rgmii_rxc, rgmii_td, rgmii_tx_ctl, rgmii_txc, mdio_mdc, mdio_mdio_i, mdio_mdio_o, 
  mdio_mdio_t)
/* synthesis syn_black_box black_box_pad_pin="s_axi_lite_resetn,s_axi_lite_clk,mac_irq,axis_clk,axi_txd_arstn,axi_txc_arstn,axi_rxd_arstn,axi_rxs_arstn,interrupt,gtx_clk,phy_rst_n[0:0],ref_clk,gtx_clk90_out,gtx_clk_out,s_axi_araddr[17:0],s_axi_arready,s_axi_arvalid,s_axi_awaddr[17:0],s_axi_awready,s_axi_awvalid,s_axi_bready,s_axi_bresp[1:0],s_axi_bvalid,s_axi_rdata[31:0],s_axi_rready,s_axi_rresp[1:0],s_axi_rvalid,s_axi_wdata[31:0],s_axi_wready,s_axi_wstrb[3:0],s_axi_wvalid,s_axis_txc_tdata[31:0],s_axis_txc_tkeep[3:0],s_axis_txc_tlast,s_axis_txc_tready,s_axis_txc_tvalid,s_axis_txd_tdata[31:0],s_axis_txd_tkeep[3:0],s_axis_txd_tlast,s_axis_txd_tready,s_axis_txd_tvalid,m_axis_rxd_tdata[31:0],m_axis_rxd_tkeep[3:0],m_axis_rxd_tlast,m_axis_rxd_tready,m_axis_rxd_tvalid,m_axis_rxs_tdata[31:0],m_axis_rxs_tkeep[3:0],m_axis_rxs_tlast,m_axis_rxs_tready,m_axis_rxs_tvalid,rgmii_rd[3:0],rgmii_rx_ctl,rgmii_rxc,rgmii_td[3:0],rgmii_tx_ctl,rgmii_txc,mdio_mdc,mdio_mdio_i,mdio_mdio_o,mdio_mdio_t" */;
  (* x_interface_info = "xilinx.com:signal:reset:1.0 RST.s_axi_lite_resetn RST" *) (* x_interface_mode = "slave RST.s_axi_lite_resetn" *) (* x_interface_parameter = "XIL_INTERFACENAME RST.s_axi_lite_resetn, POLARITY ACTIVE_LOW, INSERT_VIP 0" *) input s_axi_lite_resetn;
  (* x_interface_info = "xilinx.com:signal:clock:1.0 CLK.s_axi_lite_clk CLK" *) (* x_interface_mode = "slave CLK.s_axi_lite_clk" *) (* x_interface_parameter = "XIL_INTERFACENAME CLK.s_axi_lite_clk, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN eth_mb_system_Clk, ASSOCIATED_BUSIF s_axi, ASSOCIATED_RESET s_axi_lite_resetn, INSERT_VIP 0, ASSOCIATED_CLKEN CE" *) input s_axi_lite_clk;
  (* x_interface_info = "xilinx.com:signal:interrupt:1.0 INTR.mac_irq INTERRUPT" *) (* x_interface_mode = "master INTR.mac_irq" *) (* x_interface_parameter = "XIL_INTERFACENAME INTR.mac_irq, SENSITIVITY EDGE_RISING, PortWidth 1" *) output mac_irq;
  (* x_interface_info = "xilinx.com:signal:clock:1.0 CLK.axis_clk CLK" *) (* x_interface_mode = "slave CLK.axis_clk" *) (* x_interface_parameter = "XIL_INTERFACENAME CLK.axis_clk, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN eth_mb_system_Clk, ASSOCIATED_BUSIF m_axis_rxd:m_axis_rxs:s_axis_txc:s_axis_txd, ASSOCIATED_RESET axi_rxd_arstn:axi_rxs_arstn:axi_txc_arstn:axi_txd_arstn, INSERT_VIP 0" *) input axis_clk;
  (* x_interface_info = "xilinx.com:signal:reset:1.0 RST.axi_txd_arstn RST" *) (* x_interface_mode = "slave RST.axi_txd_arstn" *) (* x_interface_parameter = "XIL_INTERFACENAME RST.axi_txd_arstn, POLARITY ACTIVE_LOW, INSERT_VIP 0" *) input axi_txd_arstn;
  (* x_interface_info = "xilinx.com:signal:reset:1.0 RST.axi_txc_arstn RST" *) (* x_interface_mode = "slave RST.axi_txc_arstn" *) (* x_interface_parameter = "XIL_INTERFACENAME RST.axi_txc_arstn, POLARITY ACTIVE_LOW, INSERT_VIP 0" *) input axi_txc_arstn;
  (* x_interface_info = "xilinx.com:signal:reset:1.0 RST.axi_rxd_arstn RST" *) (* x_interface_mode = "slave RST.axi_rxd_arstn" *) (* x_interface_parameter = "XIL_INTERFACENAME RST.axi_rxd_arstn, POLARITY ACTIVE_LOW, INSERT_VIP 0" *) input axi_rxd_arstn;
  (* x_interface_info = "xilinx.com:signal:reset:1.0 RST.axi_rxs_arstn RST" *) (* x_interface_mode = "slave RST.axi_rxs_arstn" *) (* x_interface_parameter = "XIL_INTERFACENAME RST.axi_rxs_arstn, POLARITY ACTIVE_LOW, INSERT_VIP 0" *) input axi_rxs_arstn;
  (* x_interface_info = "xilinx.com:signal:interrupt:1.0 INTR.interrupt INTERRUPT" *) (* x_interface_mode = "master INTR.interrupt" *) (* x_interface_parameter = "XIL_INTERFACENAME INTR.interrupt, SENSITIVITY LEVEL_HIGH, PortWidth 1" *) output interrupt;
  (* x_interface_info = "xilinx.com:signal:clock:1.0 CLK.gtx_clk CLK" *) (* x_interface_mode = "slave CLK.gtx_clk" *) (* x_interface_parameter = "XIL_INTERFACENAME CLK.gtx_clk, FREQ_HZ 125000000, FREQ_TOLERANCE_HZ 1000000, PHASE 0, CLK_DOMAIN bd_f264_mac_0_gtx_clk_out, INSERT_VIP 0" *) input gtx_clk;
  (* x_interface_info = "xilinx.com:signal:reset:1.0 RST.phy_rst_n RST" *) (* x_interface_mode = "master RST.phy_rst_n" *) (* x_interface_parameter = "XIL_INTERFACENAME RST.phy_rst_n, POLARITY ACTIVE_LOW, INSERT_VIP 0, BOARD.ASSOCIATED_PARAM PHYRST_BOARD_INTERFACE" *) output [0:0]phy_rst_n;
  (* x_interface_info = "xilinx.com:signal:clock:1.0 CLK.ref_clk CLK" *) (* x_interface_mode = "slave CLK.ref_clk" *) (* x_interface_parameter = "XIL_INTERFACENAME CLK.ref_clk, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN eth_mb_system_Clk, INSERT_VIP 0" *) input ref_clk;
  (* x_interface_info = "xilinx.com:signal:clock:1.0 CLK.gtx_clk90_out CLK" *) (* x_interface_mode = "master CLK.gtx_clk90_out" *) (* x_interface_parameter = "XIL_INTERFACENAME CLK.gtx_clk90_out, FREQ_HZ 125000000, FREQ_TOLERANCE_HZ 0, PHASE 90, CLK_DOMAIN bd_f264_mac_0_gtx_clk90_out, INSERT_VIP 0" *) output gtx_clk90_out;
  (* x_interface_info = "xilinx.com:signal:clock:1.0 CLK.gtx_clk_out CLK" *) (* x_interface_mode = "master CLK.gtx_clk_out" *) (* x_interface_parameter = "XIL_INTERFACENAME CLK.gtx_clk_out, FREQ_HZ 125000000, FREQ_TOLERANCE_HZ 0, PHASE 0, CLK_DOMAIN bd_f264_mac_0_gtx_clk_out, INSERT_VIP 0" *) output gtx_clk_out;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 s_axi ARADDR" *) (* x_interface_mode = "slave s_axi" *) (* x_interface_parameter = "XIL_INTERFACENAME s_axi, DATA_WIDTH 32, PROTOCOL AXI4LITE, FREQ_HZ 100000000, ID_WIDTH 0, ADDR_WIDTH 18, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, READ_WRITE_MODE READ_WRITE, HAS_BURST 0, HAS_LOCK 0, HAS_PROT 0, HAS_CACHE 0, HAS_QOS 0, HAS_REGION 0, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, SUPPORTS_NARROW_BURST 0, NUM_READ_OUTSTANDING 16, NUM_WRITE_OUTSTANDING 16, MAX_BURST_LENGTH 1, PHASE 0.0, CLK_DOMAIN eth_mb_system_Clk, NUM_READ_THREADS 1, NUM_WRITE_THREADS 1, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0, INSERT_VIP 0" *) input [17:0]s_axi_araddr;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 s_axi ARREADY" *) output s_axi_arready;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 s_axi ARVALID" *) input s_axi_arvalid;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 s_axi AWADDR" *) input [17:0]s_axi_awaddr;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 s_axi AWREADY" *) output s_axi_awready;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 s_axi AWVALID" *) input s_axi_awvalid;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 s_axi BREADY" *) input s_axi_bready;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 s_axi BRESP" *) output [1:0]s_axi_bresp;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 s_axi BVALID" *) output s_axi_bvalid;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 s_axi RDATA" *) output [31:0]s_axi_rdata;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 s_axi RREADY" *) input s_axi_rready;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 s_axi RRESP" *) output [1:0]s_axi_rresp;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 s_axi RVALID" *) output s_axi_rvalid;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 s_axi WDATA" *) input [31:0]s_axi_wdata;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 s_axi WREADY" *) output s_axi_wready;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 s_axi WSTRB" *) input [3:0]s_axi_wstrb;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 s_axi WVALID" *) input s_axi_wvalid;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 s_axis_txc TDATA" *) (* x_interface_mode = "slave s_axis_txc" *) (* x_interface_parameter = "XIL_INTERFACENAME s_axis_txc, TDATA_NUM_BYTES 4, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 1, HAS_TLAST 1, FREQ_HZ 100000000, PHASE 0.0, CLK_DOMAIN eth_mb_system_Clk, LAYERED_METADATA undef, INSERT_VIP 0" *) input [31:0]s_axis_txc_tdata;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 s_axis_txc TKEEP" *) input [3:0]s_axis_txc_tkeep;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 s_axis_txc TLAST" *) input s_axis_txc_tlast;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 s_axis_txc TREADY" *) output s_axis_txc_tready;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 s_axis_txc TVALID" *) input s_axis_txc_tvalid;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 s_axis_txd TDATA" *) (* x_interface_mode = "slave s_axis_txd" *) (* x_interface_parameter = "XIL_INTERFACENAME s_axis_txd, TDATA_NUM_BYTES 4, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 1, HAS_TLAST 1, FREQ_HZ 100000000, PHASE 0.0, CLK_DOMAIN eth_mb_system_Clk, LAYERED_METADATA undef, INSERT_VIP 0" *) input [31:0]s_axis_txd_tdata;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 s_axis_txd TKEEP" *) input [3:0]s_axis_txd_tkeep;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 s_axis_txd TLAST" *) input s_axis_txd_tlast;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 s_axis_txd TREADY" *) output s_axis_txd_tready;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 s_axis_txd TVALID" *) input s_axis_txd_tvalid;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 m_axis_rxd TDATA" *) (* x_interface_mode = "master m_axis_rxd" *) (* x_interface_parameter = "XIL_INTERFACENAME m_axis_rxd, TDATA_NUM_BYTES 4, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 1, HAS_TLAST 1, FREQ_HZ 100000000, PHASE 0.0, CLK_DOMAIN eth_mb_system_Clk, LAYERED_METADATA undef, INSERT_VIP 0" *) output [31:0]m_axis_rxd_tdata;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 m_axis_rxd TKEEP" *) output [3:0]m_axis_rxd_tkeep;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 m_axis_rxd TLAST" *) output m_axis_rxd_tlast;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 m_axis_rxd TREADY" *) input m_axis_rxd_tready;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 m_axis_rxd TVALID" *) output m_axis_rxd_tvalid;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 m_axis_rxs TDATA" *) (* x_interface_mode = "master m_axis_rxs" *) (* x_interface_parameter = "XIL_INTERFACENAME m_axis_rxs, TDATA_NUM_BYTES 4, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 1, HAS_TLAST 1, FREQ_HZ 100000000, PHASE 0.0, CLK_DOMAIN eth_mb_system_Clk, LAYERED_METADATA undef, INSERT_VIP 0" *) output [31:0]m_axis_rxs_tdata;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 m_axis_rxs TKEEP" *) output [3:0]m_axis_rxs_tkeep;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 m_axis_rxs TLAST" *) output m_axis_rxs_tlast;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 m_axis_rxs TREADY" *) input m_axis_rxs_tready;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 m_axis_rxs TVALID" *) output m_axis_rxs_tvalid;
  (* x_interface_info = "xilinx.com:interface:rgmii:1.0 rgmii RD" *) (* x_interface_mode = "master rgmii" *) (* x_interface_parameter = "XIL_INTERFACENAME rgmii, BOARD.ASSOCIATED_PARAM ETHERNET_BOARD_INTERFACE" *) input [3:0]rgmii_rd;
  (* x_interface_info = "xilinx.com:interface:rgmii:1.0 rgmii RX_CTL" *) input rgmii_rx_ctl;
  (* x_interface_info = "xilinx.com:interface:rgmii:1.0 rgmii RXC" *) input rgmii_rxc;
  (* x_interface_info = "xilinx.com:interface:rgmii:1.0 rgmii TD" *) output [3:0]rgmii_td;
  (* x_interface_info = "xilinx.com:interface:rgmii:1.0 rgmii TX_CTL" *) output rgmii_tx_ctl;
  (* x_interface_info = "xilinx.com:interface:rgmii:1.0 rgmii TXC" *) output rgmii_txc;
  (* x_interface_info = "xilinx.com:interface:mdio:1.0 mdio MDC" *) (* x_interface_mode = "master mdio" *) (* x_interface_parameter = "XIL_INTERFACENAME mdio, CAN_DEBUG false, BOARD.ASSOCIATED_PARAM MDIO_BOARD_INTERFACE" *) output mdio_mdc;
  (* x_interface_info = "xilinx.com:interface:mdio:1.0 mdio MDIO_I" *) input mdio_mdio_i;
  (* x_interface_info = "xilinx.com:interface:mdio:1.0 mdio MDIO_O" *) output mdio_mdio_o;
  (* x_interface_info = "xilinx.com:interface:mdio:1.0 mdio MDIO_T" *) output mdio_mdio_t;
endmodule
