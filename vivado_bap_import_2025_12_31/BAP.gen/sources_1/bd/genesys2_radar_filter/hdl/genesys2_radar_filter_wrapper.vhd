--Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
--Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2025.2 (win64) Build 6299465 Fri Nov 14 19:35:11 GMT 2025
--Date        : Sun May 31 18:31:59 2026
--Host        : TOMAS-PC running 64-bit major release  (build 9200)
--Command     : generate_target genesys2_radar_filter_wrapper.bd
--Design      : genesys2_radar_filter_wrapper
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity genesys2_radar_filter_wrapper is
  port (
    clk_125M : in STD_LOGIC;
    clk_200M : in STD_LOGIC;
    control_from_mb_tri_o : out STD_LOGIC_VECTOR ( 31 downto 0 );
    d_sample_from_mb_tri_o : out STD_LOGIC_VECTOR ( 31 downto 0 );
    ddr3_sdram_addr : out STD_LOGIC_VECTOR ( 14 downto 0 );
    ddr3_sdram_ba : out STD_LOGIC_VECTOR ( 2 downto 0 );
    ddr3_sdram_cas_n : out STD_LOGIC;
    ddr3_sdram_ck_n : out STD_LOGIC_VECTOR ( 0 to 0 );
    ddr3_sdram_ck_p : out STD_LOGIC_VECTOR ( 0 to 0 );
    ddr3_sdram_cke : out STD_LOGIC_VECTOR ( 0 to 0 );
    ddr3_sdram_cs_n : out STD_LOGIC_VECTOR ( 0 to 0 );
    ddr3_sdram_dm : out STD_LOGIC_VECTOR ( 3 downto 0 );
    ddr3_sdram_dq : inout STD_LOGIC_VECTOR ( 31 downto 0 );
    ddr3_sdram_dqs_n : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    ddr3_sdram_dqs_p : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    ddr3_sdram_odt : out STD_LOGIC_VECTOR ( 0 to 0 );
    ddr3_sdram_ras_n : out STD_LOGIC;
    ddr3_sdram_reset_n : out STD_LOGIC;
    ddr3_sdram_we_n : out STD_LOGIC;
    e_result_to_mb_tri_i : in STD_LOGIC_VECTOR ( 31 downto 0 );
    eth_mdio_mdc_mdc : out STD_LOGIC;
    eth_mdio_mdc_mdio_io : inout STD_LOGIC;
    eth_rgmii_rd : in STD_LOGIC_VECTOR ( 3 downto 0 );
    eth_rgmii_rx_ctl : in STD_LOGIC;
    eth_rgmii_rxc : in STD_LOGIC;
    eth_rgmii_td : out STD_LOGIC_VECTOR ( 3 downto 0 );
    eth_rgmii_tx_ctl : out STD_LOGIC;
    eth_rgmii_txc : out STD_LOGIC;
    phy_reset_out_tri_o : out STD_LOGIC_VECTOR ( 0 to 0 );
    sys_rst_n : in STD_LOGIC;
    usb_uart_rxd : in STD_LOGIC;
    usb_uart_txd : out STD_LOGIC;
    x_sample_from_mb_tri_o : out STD_LOGIC_VECTOR ( 31 downto 0 );
    y_result_to_mb_tri_i : in STD_LOGIC_VECTOR ( 31 downto 0 )
  );
end genesys2_radar_filter_wrapper;

architecture STRUCTURE of genesys2_radar_filter_wrapper is
  component genesys2_radar_filter is
  port (
    ddr3_sdram_dq : inout STD_LOGIC_VECTOR ( 31 downto 0 );
    ddr3_sdram_dqs_p : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    ddr3_sdram_dqs_n : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    ddr3_sdram_addr : out STD_LOGIC_VECTOR ( 14 downto 0 );
    ddr3_sdram_ba : out STD_LOGIC_VECTOR ( 2 downto 0 );
    ddr3_sdram_ras_n : out STD_LOGIC;
    ddr3_sdram_cas_n : out STD_LOGIC;
    ddr3_sdram_we_n : out STD_LOGIC;
    ddr3_sdram_reset_n : out STD_LOGIC;
    ddr3_sdram_ck_p : out STD_LOGIC_VECTOR ( 0 to 0 );
    ddr3_sdram_ck_n : out STD_LOGIC_VECTOR ( 0 to 0 );
    ddr3_sdram_cke : out STD_LOGIC_VECTOR ( 0 to 0 );
    ddr3_sdram_cs_n : out STD_LOGIC_VECTOR ( 0 to 0 );
    ddr3_sdram_dm : out STD_LOGIC_VECTOR ( 3 downto 0 );
    ddr3_sdram_odt : out STD_LOGIC_VECTOR ( 0 to 0 );
    clk_125M : in STD_LOGIC;
    clk_200M : in STD_LOGIC;
    eth_mdio_mdc_mdc : out STD_LOGIC;
    eth_mdio_mdc_mdio_i : in STD_LOGIC;
    eth_mdio_mdc_mdio_o : out STD_LOGIC;
    eth_mdio_mdc_mdio_t : out STD_LOGIC;
    eth_rgmii_rd : in STD_LOGIC_VECTOR ( 3 downto 0 );
    eth_rgmii_rx_ctl : in STD_LOGIC;
    eth_rgmii_rxc : in STD_LOGIC;
    eth_rgmii_td : out STD_LOGIC_VECTOR ( 3 downto 0 );
    eth_rgmii_tx_ctl : out STD_LOGIC;
    eth_rgmii_txc : out STD_LOGIC;
    usb_uart_rxd : in STD_LOGIC;
    usb_uart_txd : out STD_LOGIC;
    sys_rst_n : in STD_LOGIC;
    phy_reset_out_tri_o : out STD_LOGIC_VECTOR ( 0 to 0 );
    control_from_mb_tri_o : out STD_LOGIC_VECTOR ( 31 downto 0 );
    x_sample_from_mb_tri_o : out STD_LOGIC_VECTOR ( 31 downto 0 );
    d_sample_from_mb_tri_o : out STD_LOGIC_VECTOR ( 31 downto 0 );
    y_result_to_mb_tri_i : in STD_LOGIC_VECTOR ( 31 downto 0 );
    e_result_to_mb_tri_i : in STD_LOGIC_VECTOR ( 31 downto 0 )
  );
  end component genesys2_radar_filter;
  component IOBUF is
  port (
    I : in STD_LOGIC;
    O : out STD_LOGIC;
    T : in STD_LOGIC;
    IO : inout STD_LOGIC
  );
  end component IOBUF;
  signal eth_mdio_mdc_mdio_i : STD_LOGIC;
  signal eth_mdio_mdc_mdio_o : STD_LOGIC;
  signal eth_mdio_mdc_mdio_t : STD_LOGIC;
begin
eth_mdio_mdc_mdio_iobuf: component IOBUF
     port map (
      I => eth_mdio_mdc_mdio_o,
      IO => eth_mdio_mdc_mdio_io,
      O => eth_mdio_mdc_mdio_i,
      T => eth_mdio_mdc_mdio_t
    );
genesys2_radar_filter_i: component genesys2_radar_filter
     port map (
      clk_125M => clk_125M,
      clk_200M => clk_200M,
      control_from_mb_tri_o(31 downto 0) => control_from_mb_tri_o(31 downto 0),
      d_sample_from_mb_tri_o(31 downto 0) => d_sample_from_mb_tri_o(31 downto 0),
      ddr3_sdram_addr(14 downto 0) => ddr3_sdram_addr(14 downto 0),
      ddr3_sdram_ba(2 downto 0) => ddr3_sdram_ba(2 downto 0),
      ddr3_sdram_cas_n => ddr3_sdram_cas_n,
      ddr3_sdram_ck_n(0) => ddr3_sdram_ck_n(0),
      ddr3_sdram_ck_p(0) => ddr3_sdram_ck_p(0),
      ddr3_sdram_cke(0) => ddr3_sdram_cke(0),
      ddr3_sdram_cs_n(0) => ddr3_sdram_cs_n(0),
      ddr3_sdram_dm(3 downto 0) => ddr3_sdram_dm(3 downto 0),
      ddr3_sdram_dq(31 downto 0) => ddr3_sdram_dq(31 downto 0),
      ddr3_sdram_dqs_n(3 downto 0) => ddr3_sdram_dqs_n(3 downto 0),
      ddr3_sdram_dqs_p(3 downto 0) => ddr3_sdram_dqs_p(3 downto 0),
      ddr3_sdram_odt(0) => ddr3_sdram_odt(0),
      ddr3_sdram_ras_n => ddr3_sdram_ras_n,
      ddr3_sdram_reset_n => ddr3_sdram_reset_n,
      ddr3_sdram_we_n => ddr3_sdram_we_n,
      e_result_to_mb_tri_i(31 downto 0) => e_result_to_mb_tri_i(31 downto 0),
      eth_mdio_mdc_mdc => eth_mdio_mdc_mdc,
      eth_mdio_mdc_mdio_i => eth_mdio_mdc_mdio_i,
      eth_mdio_mdc_mdio_o => eth_mdio_mdc_mdio_o,
      eth_mdio_mdc_mdio_t => eth_mdio_mdc_mdio_t,
      eth_rgmii_rd(3 downto 0) => eth_rgmii_rd(3 downto 0),
      eth_rgmii_rx_ctl => eth_rgmii_rx_ctl,
      eth_rgmii_rxc => eth_rgmii_rxc,
      eth_rgmii_td(3 downto 0) => eth_rgmii_td(3 downto 0),
      eth_rgmii_tx_ctl => eth_rgmii_tx_ctl,
      eth_rgmii_txc => eth_rgmii_txc,
      phy_reset_out_tri_o(0) => phy_reset_out_tri_o(0),
      sys_rst_n => sys_rst_n,
      usb_uart_rxd => usb_uart_rxd,
      usb_uart_txd => usb_uart_txd,
      x_sample_from_mb_tri_o(31 downto 0) => x_sample_from_mb_tri_o(31 downto 0),
      y_result_to_mb_tri_i(31 downto 0) => y_result_to_mb_tri_i(31 downto 0)
    );
end STRUCTURE;
