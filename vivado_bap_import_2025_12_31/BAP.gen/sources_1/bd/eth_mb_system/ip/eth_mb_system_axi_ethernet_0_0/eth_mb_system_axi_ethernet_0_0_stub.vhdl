-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2025.2 (win64) Build 6299465 Fri Nov 14 19:35:11 GMT 2025
-- Date        : Fri May 29 14:07:56 2026
-- Host        : TOMAS-PC running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               c:/FPGA/BAP/BAP.gen/sources_1/bd/eth_mb_system/ip/eth_mb_system_axi_ethernet_0_0/eth_mb_system_axi_ethernet_0_0_stub.vhdl
-- Design      : eth_mb_system_axi_ethernet_0_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7k325tffg900-2
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity eth_mb_system_axi_ethernet_0_0 is
  Port ( 
    s_axi_lite_resetn : in STD_LOGIC;
    s_axi_lite_clk : in STD_LOGIC;
    mac_irq : out STD_LOGIC;
    axis_clk : in STD_LOGIC;
    axi_txd_arstn : in STD_LOGIC;
    axi_txc_arstn : in STD_LOGIC;
    axi_rxd_arstn : in STD_LOGIC;
    axi_rxs_arstn : in STD_LOGIC;
    interrupt : out STD_LOGIC;
    gtx_clk : in STD_LOGIC;
    phy_rst_n : out STD_LOGIC_VECTOR ( 0 to 0 );
    ref_clk : in STD_LOGIC;
    gtx_clk90_out : out STD_LOGIC;
    gtx_clk_out : out STD_LOGIC;
    s_axi_araddr : in STD_LOGIC_VECTOR ( 17 downto 0 );
    s_axi_arready : out STD_LOGIC;
    s_axi_arvalid : in STD_LOGIC;
    s_axi_awaddr : in STD_LOGIC_VECTOR ( 17 downto 0 );
    s_axi_awready : out STD_LOGIC;
    s_axi_awvalid : in STD_LOGIC;
    s_axi_bready : in STD_LOGIC;
    s_axi_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_bvalid : out STD_LOGIC;
    s_axi_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_rready : in STD_LOGIC;
    s_axi_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_rvalid : out STD_LOGIC;
    s_axi_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_wready : out STD_LOGIC;
    s_axi_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_wvalid : in STD_LOGIC;
    s_axis_txc_tdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axis_txc_tkeep : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axis_txc_tlast : in STD_LOGIC;
    s_axis_txc_tready : out STD_LOGIC;
    s_axis_txc_tvalid : in STD_LOGIC;
    s_axis_txd_tdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axis_txd_tkeep : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axis_txd_tlast : in STD_LOGIC;
    s_axis_txd_tready : out STD_LOGIC;
    s_axis_txd_tvalid : in STD_LOGIC;
    m_axis_rxd_tdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axis_rxd_tkeep : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axis_rxd_tlast : out STD_LOGIC;
    m_axis_rxd_tready : in STD_LOGIC;
    m_axis_rxd_tvalid : out STD_LOGIC;
    m_axis_rxs_tdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axis_rxs_tkeep : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axis_rxs_tlast : out STD_LOGIC;
    m_axis_rxs_tready : in STD_LOGIC;
    m_axis_rxs_tvalid : out STD_LOGIC;
    rgmii_rd : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rgmii_rx_ctl : in STD_LOGIC;
    rgmii_rxc : in STD_LOGIC;
    rgmii_td : out STD_LOGIC_VECTOR ( 3 downto 0 );
    rgmii_tx_ctl : out STD_LOGIC;
    rgmii_txc : out STD_LOGIC;
    mdio_mdc : out STD_LOGIC;
    mdio_mdio_i : in STD_LOGIC;
    mdio_mdio_o : out STD_LOGIC;
    mdio_mdio_t : out STD_LOGIC
  );

  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of eth_mb_system_axi_ethernet_0_0 : entity is "eth_mb_system_axi_ethernet_0_0,bd_f264,{}";
  attribute core_generation_info : string;
  attribute core_generation_info of eth_mb_system_axi_ethernet_0_0 : entity is "eth_mb_system_axi_ethernet_0_0,bd_f264,{x_ipProduct=Vivado 2025.2,x_ipVendor=xilinx.com,x_ipLibrary=ip,x_ipName=axi_ethernet,x_ipVersion=8.0,x_ipCoreRevision=0,x_ipLanguage=VHDL,x_ipSimLanguage=VHDL,Component_Name=eth_mb_system_axi_ethernet_0_0,IS_GT_WIZ_OLD=0,GT_SETTINGS=0,USE_BOARD_FLOW=true,ETHERNET_BOARD_INTERFACE=eth_rgmii,speed_1_2p5=1G,PHY_TYPE=RGMII,processor_mode=true,PHYRST_BOARD_INTERFACE=phy_reset_out,PHYRST_BOARD_INTERFACE_DUMMY_PORT=Custom,DIFFCLK_BOARD_INTERFACE=Custom,MDIO_BOARD_INTERFACE=eth_mdio_mdc,ENABLE_LVDS=false,Enable_1588=false,ENABLE_AVB=false,Enable_1588_1step=false,Timer_Format=0,TIMER_CLK_PERIOD=4000,PHYADDR=1,gt_type=GTH,Include_IO=true,SupportLevel=1,GTinEx=false,TransceiverControl=false,EnableAsyncSGMII=false,ClockSelection=Sync,tx_in_upper_nibble=true,txlane0_placement=DIFF_PAIR_0,rxlane0_placement=DIFF_PAIR_0,txlane1_placement=DIFF_PAIR_1,rxlane1_placement=DIFF_PAIR_1,InstantiateBitslice0=false,rxnibblebitslice0used=false,RXMEM=4k,TXMEM=4k,TXCSUM=None,RXCSUM=None,TXVLAN_TRAN=false,RXVLAN_TRAN=false,TXVLAN_TAG=false,RXVLAN_TAG=false,TXVLAN_STRP=false,RXVLAN_STRP=false,MCAST_EXTEND=false,Frame_Filter=true,Number_of_Table_Entries=4,Statistics_Counters=true,Statistics_Reset=false,Statistics_Width=64bit,Enable_Pfc=false,drpclkrate=50.0,gtrefclkrate=125,lvdsclkrate=125,axiliteclkrate=100.0,axisclkrate=100.0,gtrefclksrc=clk0,gtlocation=X0Y0,SIMULATION_MODE=false,VERSAL_GT_BOARD_FLOW=0,x_ipLicense=tri_mode_eth_mac@2015.04(hardware_evaluation),x_ipLicense=eth_avb_endpoint@2015.04(design_linking)}";
  attribute downgradeipidentifiedwarnings : string;
  attribute downgradeipidentifiedwarnings of eth_mb_system_axi_ethernet_0_0 : entity is "yes";
end eth_mb_system_axi_ethernet_0_0;

architecture stub of eth_mb_system_axi_ethernet_0_0 is
  attribute syn_black_box : boolean;
  attribute black_box_pad_pin : string;
  attribute syn_black_box of stub : architecture is true;
  attribute black_box_pad_pin of stub : architecture is "s_axi_lite_resetn,s_axi_lite_clk,mac_irq,axis_clk,axi_txd_arstn,axi_txc_arstn,axi_rxd_arstn,axi_rxs_arstn,interrupt,gtx_clk,phy_rst_n[0:0],ref_clk,gtx_clk90_out,gtx_clk_out,s_axi_araddr[17:0],s_axi_arready,s_axi_arvalid,s_axi_awaddr[17:0],s_axi_awready,s_axi_awvalid,s_axi_bready,s_axi_bresp[1:0],s_axi_bvalid,s_axi_rdata[31:0],s_axi_rready,s_axi_rresp[1:0],s_axi_rvalid,s_axi_wdata[31:0],s_axi_wready,s_axi_wstrb[3:0],s_axi_wvalid,s_axis_txc_tdata[31:0],s_axis_txc_tkeep[3:0],s_axis_txc_tlast,s_axis_txc_tready,s_axis_txc_tvalid,s_axis_txd_tdata[31:0],s_axis_txd_tkeep[3:0],s_axis_txd_tlast,s_axis_txd_tready,s_axis_txd_tvalid,m_axis_rxd_tdata[31:0],m_axis_rxd_tkeep[3:0],m_axis_rxd_tlast,m_axis_rxd_tready,m_axis_rxd_tvalid,m_axis_rxs_tdata[31:0],m_axis_rxs_tkeep[3:0],m_axis_rxs_tlast,m_axis_rxs_tready,m_axis_rxs_tvalid,rgmii_rd[3:0],rgmii_rx_ctl,rgmii_rxc,rgmii_td[3:0],rgmii_tx_ctl,rgmii_txc,mdio_mdc,mdio_mdio_i,mdio_mdio_o,mdio_mdio_t";
  attribute x_interface_info : string;
  attribute x_interface_info of s_axi_lite_resetn : signal is "xilinx.com:signal:reset:1.0 RST.s_axi_lite_resetn RST";
  attribute x_interface_mode : string;
  attribute x_interface_mode of s_axi_lite_resetn : signal is "slave RST.s_axi_lite_resetn";
  attribute x_interface_parameter : string;
  attribute x_interface_parameter of s_axi_lite_resetn : signal is "XIL_INTERFACENAME RST.s_axi_lite_resetn, POLARITY ACTIVE_LOW, INSERT_VIP 0";
  attribute x_interface_info of s_axi_lite_clk : signal is "xilinx.com:signal:clock:1.0 CLK.s_axi_lite_clk CLK";
  attribute x_interface_mode of s_axi_lite_clk : signal is "slave CLK.s_axi_lite_clk";
  attribute x_interface_parameter of s_axi_lite_clk : signal is "XIL_INTERFACENAME CLK.s_axi_lite_clk, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN eth_mb_system_Clk, ASSOCIATED_BUSIF s_axi, ASSOCIATED_RESET s_axi_lite_resetn, INSERT_VIP 0, ASSOCIATED_CLKEN CE";
  attribute x_interface_info of mac_irq : signal is "xilinx.com:signal:interrupt:1.0 INTR.mac_irq INTERRUPT";
  attribute x_interface_mode of mac_irq : signal is "master INTR.mac_irq";
  attribute x_interface_parameter of mac_irq : signal is "XIL_INTERFACENAME INTR.mac_irq, SENSITIVITY EDGE_RISING, PortWidth 1";
  attribute x_interface_info of axis_clk : signal is "xilinx.com:signal:clock:1.0 CLK.axis_clk CLK";
  attribute x_interface_mode of axis_clk : signal is "slave CLK.axis_clk";
  attribute x_interface_parameter of axis_clk : signal is "XIL_INTERFACENAME CLK.axis_clk, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN eth_mb_system_Clk, ASSOCIATED_BUSIF m_axis_rxd:m_axis_rxs:s_axis_txc:s_axis_txd, ASSOCIATED_RESET axi_rxd_arstn:axi_rxs_arstn:axi_txc_arstn:axi_txd_arstn, INSERT_VIP 0";
  attribute x_interface_info of axi_txd_arstn : signal is "xilinx.com:signal:reset:1.0 RST.axi_txd_arstn RST";
  attribute x_interface_mode of axi_txd_arstn : signal is "slave RST.axi_txd_arstn";
  attribute x_interface_parameter of axi_txd_arstn : signal is "XIL_INTERFACENAME RST.axi_txd_arstn, POLARITY ACTIVE_LOW, INSERT_VIP 0";
  attribute x_interface_info of axi_txc_arstn : signal is "xilinx.com:signal:reset:1.0 RST.axi_txc_arstn RST";
  attribute x_interface_mode of axi_txc_arstn : signal is "slave RST.axi_txc_arstn";
  attribute x_interface_parameter of axi_txc_arstn : signal is "XIL_INTERFACENAME RST.axi_txc_arstn, POLARITY ACTIVE_LOW, INSERT_VIP 0";
  attribute x_interface_info of axi_rxd_arstn : signal is "xilinx.com:signal:reset:1.0 RST.axi_rxd_arstn RST";
  attribute x_interface_mode of axi_rxd_arstn : signal is "slave RST.axi_rxd_arstn";
  attribute x_interface_parameter of axi_rxd_arstn : signal is "XIL_INTERFACENAME RST.axi_rxd_arstn, POLARITY ACTIVE_LOW, INSERT_VIP 0";
  attribute x_interface_info of axi_rxs_arstn : signal is "xilinx.com:signal:reset:1.0 RST.axi_rxs_arstn RST";
  attribute x_interface_mode of axi_rxs_arstn : signal is "slave RST.axi_rxs_arstn";
  attribute x_interface_parameter of axi_rxs_arstn : signal is "XIL_INTERFACENAME RST.axi_rxs_arstn, POLARITY ACTIVE_LOW, INSERT_VIP 0";
  attribute x_interface_info of interrupt : signal is "xilinx.com:signal:interrupt:1.0 INTR.interrupt INTERRUPT";
  attribute x_interface_mode of interrupt : signal is "master INTR.interrupt";
  attribute x_interface_parameter of interrupt : signal is "XIL_INTERFACENAME INTR.interrupt, SENSITIVITY LEVEL_HIGH, PortWidth 1";
  attribute x_interface_info of gtx_clk : signal is "xilinx.com:signal:clock:1.0 CLK.gtx_clk CLK";
  attribute x_interface_mode of gtx_clk : signal is "slave CLK.gtx_clk";
  attribute x_interface_parameter of gtx_clk : signal is "XIL_INTERFACENAME CLK.gtx_clk, FREQ_HZ 125000000, FREQ_TOLERANCE_HZ 1000000, PHASE 0, CLK_DOMAIN bd_f264_mac_0_gtx_clk_out, INSERT_VIP 0";
  attribute x_interface_info of phy_rst_n : signal is "xilinx.com:signal:reset:1.0 RST.phy_rst_n RST";
  attribute x_interface_mode of phy_rst_n : signal is "master RST.phy_rst_n";
  attribute x_interface_parameter of phy_rst_n : signal is "XIL_INTERFACENAME RST.phy_rst_n, POLARITY ACTIVE_LOW, INSERT_VIP 0, BOARD.ASSOCIATED_PARAM PHYRST_BOARD_INTERFACE";
  attribute x_interface_info of ref_clk : signal is "xilinx.com:signal:clock:1.0 CLK.ref_clk CLK";
  attribute x_interface_mode of ref_clk : signal is "slave CLK.ref_clk";
  attribute x_interface_parameter of ref_clk : signal is "XIL_INTERFACENAME CLK.ref_clk, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN eth_mb_system_Clk, INSERT_VIP 0";
  attribute x_interface_info of gtx_clk90_out : signal is "xilinx.com:signal:clock:1.0 CLK.gtx_clk90_out CLK";
  attribute x_interface_mode of gtx_clk90_out : signal is "master CLK.gtx_clk90_out";
  attribute x_interface_parameter of gtx_clk90_out : signal is "XIL_INTERFACENAME CLK.gtx_clk90_out, FREQ_HZ 125000000, FREQ_TOLERANCE_HZ 0, PHASE 90, CLK_DOMAIN bd_f264_mac_0_gtx_clk90_out, INSERT_VIP 0";
  attribute x_interface_info of gtx_clk_out : signal is "xilinx.com:signal:clock:1.0 CLK.gtx_clk_out CLK";
  attribute x_interface_mode of gtx_clk_out : signal is "master CLK.gtx_clk_out";
  attribute x_interface_parameter of gtx_clk_out : signal is "XIL_INTERFACENAME CLK.gtx_clk_out, FREQ_HZ 125000000, FREQ_TOLERANCE_HZ 0, PHASE 0, CLK_DOMAIN bd_f264_mac_0_gtx_clk_out, INSERT_VIP 0";
  attribute x_interface_info of s_axi_araddr : signal is "xilinx.com:interface:aximm:1.0 s_axi ARADDR";
  attribute x_interface_mode of s_axi_araddr : signal is "slave s_axi";
  attribute x_interface_parameter of s_axi_araddr : signal is "XIL_INTERFACENAME s_axi, DATA_WIDTH 32, PROTOCOL AXI4LITE, FREQ_HZ 100000000, ID_WIDTH 0, ADDR_WIDTH 18, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, READ_WRITE_MODE READ_WRITE, HAS_BURST 0, HAS_LOCK 0, HAS_PROT 0, HAS_CACHE 0, HAS_QOS 0, HAS_REGION 0, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, SUPPORTS_NARROW_BURST 0, NUM_READ_OUTSTANDING 16, NUM_WRITE_OUTSTANDING 16, MAX_BURST_LENGTH 1, PHASE 0.0, CLK_DOMAIN eth_mb_system_Clk, NUM_READ_THREADS 1, NUM_WRITE_THREADS 1, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0, INSERT_VIP 0";
  attribute x_interface_info of s_axi_arready : signal is "xilinx.com:interface:aximm:1.0 s_axi ARREADY";
  attribute x_interface_info of s_axi_arvalid : signal is "xilinx.com:interface:aximm:1.0 s_axi ARVALID";
  attribute x_interface_info of s_axi_awaddr : signal is "xilinx.com:interface:aximm:1.0 s_axi AWADDR";
  attribute x_interface_info of s_axi_awready : signal is "xilinx.com:interface:aximm:1.0 s_axi AWREADY";
  attribute x_interface_info of s_axi_awvalid : signal is "xilinx.com:interface:aximm:1.0 s_axi AWVALID";
  attribute x_interface_info of s_axi_bready : signal is "xilinx.com:interface:aximm:1.0 s_axi BREADY";
  attribute x_interface_info of s_axi_bresp : signal is "xilinx.com:interface:aximm:1.0 s_axi BRESP";
  attribute x_interface_info of s_axi_bvalid : signal is "xilinx.com:interface:aximm:1.0 s_axi BVALID";
  attribute x_interface_info of s_axi_rdata : signal is "xilinx.com:interface:aximm:1.0 s_axi RDATA";
  attribute x_interface_info of s_axi_rready : signal is "xilinx.com:interface:aximm:1.0 s_axi RREADY";
  attribute x_interface_info of s_axi_rresp : signal is "xilinx.com:interface:aximm:1.0 s_axi RRESP";
  attribute x_interface_info of s_axi_rvalid : signal is "xilinx.com:interface:aximm:1.0 s_axi RVALID";
  attribute x_interface_info of s_axi_wdata : signal is "xilinx.com:interface:aximm:1.0 s_axi WDATA";
  attribute x_interface_info of s_axi_wready : signal is "xilinx.com:interface:aximm:1.0 s_axi WREADY";
  attribute x_interface_info of s_axi_wstrb : signal is "xilinx.com:interface:aximm:1.0 s_axi WSTRB";
  attribute x_interface_info of s_axi_wvalid : signal is "xilinx.com:interface:aximm:1.0 s_axi WVALID";
  attribute x_interface_info of s_axis_txc_tdata : signal is "xilinx.com:interface:axis:1.0 s_axis_txc TDATA";
  attribute x_interface_mode of s_axis_txc_tdata : signal is "slave s_axis_txc";
  attribute x_interface_parameter of s_axis_txc_tdata : signal is "XIL_INTERFACENAME s_axis_txc, TDATA_NUM_BYTES 4, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 1, HAS_TLAST 1, FREQ_HZ 100000000, PHASE 0.0, CLK_DOMAIN eth_mb_system_Clk, LAYERED_METADATA undef, INSERT_VIP 0";
  attribute x_interface_info of s_axis_txc_tkeep : signal is "xilinx.com:interface:axis:1.0 s_axis_txc TKEEP";
  attribute x_interface_info of s_axis_txc_tlast : signal is "xilinx.com:interface:axis:1.0 s_axis_txc TLAST";
  attribute x_interface_info of s_axis_txc_tready : signal is "xilinx.com:interface:axis:1.0 s_axis_txc TREADY";
  attribute x_interface_info of s_axis_txc_tvalid : signal is "xilinx.com:interface:axis:1.0 s_axis_txc TVALID";
  attribute x_interface_info of s_axis_txd_tdata : signal is "xilinx.com:interface:axis:1.0 s_axis_txd TDATA";
  attribute x_interface_mode of s_axis_txd_tdata : signal is "slave s_axis_txd";
  attribute x_interface_parameter of s_axis_txd_tdata : signal is "XIL_INTERFACENAME s_axis_txd, TDATA_NUM_BYTES 4, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 1, HAS_TLAST 1, FREQ_HZ 100000000, PHASE 0.0, CLK_DOMAIN eth_mb_system_Clk, LAYERED_METADATA undef, INSERT_VIP 0";
  attribute x_interface_info of s_axis_txd_tkeep : signal is "xilinx.com:interface:axis:1.0 s_axis_txd TKEEP";
  attribute x_interface_info of s_axis_txd_tlast : signal is "xilinx.com:interface:axis:1.0 s_axis_txd TLAST";
  attribute x_interface_info of s_axis_txd_tready : signal is "xilinx.com:interface:axis:1.0 s_axis_txd TREADY";
  attribute x_interface_info of s_axis_txd_tvalid : signal is "xilinx.com:interface:axis:1.0 s_axis_txd TVALID";
  attribute x_interface_info of m_axis_rxd_tdata : signal is "xilinx.com:interface:axis:1.0 m_axis_rxd TDATA";
  attribute x_interface_mode of m_axis_rxd_tdata : signal is "master m_axis_rxd";
  attribute x_interface_parameter of m_axis_rxd_tdata : signal is "XIL_INTERFACENAME m_axis_rxd, TDATA_NUM_BYTES 4, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 1, HAS_TLAST 1, FREQ_HZ 100000000, PHASE 0.0, CLK_DOMAIN eth_mb_system_Clk, LAYERED_METADATA undef, INSERT_VIP 0";
  attribute x_interface_info of m_axis_rxd_tkeep : signal is "xilinx.com:interface:axis:1.0 m_axis_rxd TKEEP";
  attribute x_interface_info of m_axis_rxd_tlast : signal is "xilinx.com:interface:axis:1.0 m_axis_rxd TLAST";
  attribute x_interface_info of m_axis_rxd_tready : signal is "xilinx.com:interface:axis:1.0 m_axis_rxd TREADY";
  attribute x_interface_info of m_axis_rxd_tvalid : signal is "xilinx.com:interface:axis:1.0 m_axis_rxd TVALID";
  attribute x_interface_info of m_axis_rxs_tdata : signal is "xilinx.com:interface:axis:1.0 m_axis_rxs TDATA";
  attribute x_interface_mode of m_axis_rxs_tdata : signal is "master m_axis_rxs";
  attribute x_interface_parameter of m_axis_rxs_tdata : signal is "XIL_INTERFACENAME m_axis_rxs, TDATA_NUM_BYTES 4, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 1, HAS_TLAST 1, FREQ_HZ 100000000, PHASE 0.0, CLK_DOMAIN eth_mb_system_Clk, LAYERED_METADATA undef, INSERT_VIP 0";
  attribute x_interface_info of m_axis_rxs_tkeep : signal is "xilinx.com:interface:axis:1.0 m_axis_rxs TKEEP";
  attribute x_interface_info of m_axis_rxs_tlast : signal is "xilinx.com:interface:axis:1.0 m_axis_rxs TLAST";
  attribute x_interface_info of m_axis_rxs_tready : signal is "xilinx.com:interface:axis:1.0 m_axis_rxs TREADY";
  attribute x_interface_info of m_axis_rxs_tvalid : signal is "xilinx.com:interface:axis:1.0 m_axis_rxs TVALID";
  attribute x_interface_info of rgmii_rd : signal is "xilinx.com:interface:rgmii:1.0 rgmii RD";
  attribute x_interface_mode of rgmii_rd : signal is "master rgmii";
  attribute x_interface_parameter of rgmii_rd : signal is "XIL_INTERFACENAME rgmii, BOARD.ASSOCIATED_PARAM ETHERNET_BOARD_INTERFACE";
  attribute x_interface_info of rgmii_rx_ctl : signal is "xilinx.com:interface:rgmii:1.0 rgmii RX_CTL";
  attribute x_interface_info of rgmii_rxc : signal is "xilinx.com:interface:rgmii:1.0 rgmii RXC";
  attribute x_interface_info of rgmii_td : signal is "xilinx.com:interface:rgmii:1.0 rgmii TD";
  attribute x_interface_info of rgmii_tx_ctl : signal is "xilinx.com:interface:rgmii:1.0 rgmii TX_CTL";
  attribute x_interface_info of rgmii_txc : signal is "xilinx.com:interface:rgmii:1.0 rgmii TXC";
  attribute x_interface_info of mdio_mdc : signal is "xilinx.com:interface:mdio:1.0 mdio MDC";
  attribute x_interface_mode of mdio_mdc : signal is "master mdio";
  attribute x_interface_parameter of mdio_mdc : signal is "XIL_INTERFACENAME mdio, CAN_DEBUG false, BOARD.ASSOCIATED_PARAM MDIO_BOARD_INTERFACE";
  attribute x_interface_info of mdio_mdio_i : signal is "xilinx.com:interface:mdio:1.0 mdio MDIO_I";
  attribute x_interface_info of mdio_mdio_o : signal is "xilinx.com:interface:mdio:1.0 mdio MDIO_O";
  attribute x_interface_info of mdio_mdio_t : signal is "xilinx.com:interface:mdio:1.0 mdio MDIO_T";
  attribute x_core_info : string;
  attribute x_core_info of stub : architecture is "bd_f264,Vivado 2025.2";
begin
end;
