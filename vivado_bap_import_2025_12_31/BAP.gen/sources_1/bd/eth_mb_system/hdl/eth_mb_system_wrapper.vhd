--Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
--Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2025.2 (win64) Build 6299465 Fri Nov 14 19:35:11 GMT 2025
--Date        : Fri May 29 13:44:23 2026
--Host        : TOMAS-PC running 64-bit major release  (build 9200)
--Command     : generate_target eth_mb_system_wrapper.bd
--Design      : eth_mb_system_wrapper
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity eth_mb_system_wrapper is
  port (
    Clk : in STD_LOGIC;
    control_from_mb_tri_o : out STD_LOGIC_VECTOR ( 31 downto 0 );
    d_sample_from_mb_tri_o : out STD_LOGIC_VECTOR ( 31 downto 0 );
    e_result_to_mb_tri_i : in STD_LOGIC_VECTOR ( 31 downto 0 );
    eth_mdio_mdc_mdc : out STD_LOGIC;
    eth_mdio_mdc_mdio_io : inout STD_LOGIC;
    eth_rgmii_rd : in STD_LOGIC_VECTOR ( 3 downto 0 );
    eth_rgmii_rx_ctl : in STD_LOGIC;
    eth_rgmii_rxc : in STD_LOGIC;
    eth_rgmii_td : out STD_LOGIC_VECTOR ( 3 downto 0 );
    eth_rgmii_tx_ctl : out STD_LOGIC;
    eth_rgmii_txc : out STD_LOGIC;
    phy_reset_out : out STD_LOGIC_VECTOR ( 0 to 0 );
    reset : in STD_LOGIC;
    x_sample_from_mb_tri_o : out STD_LOGIC_VECTOR ( 31 downto 0 );
    y_result_to_mb_tri_i : in STD_LOGIC_VECTOR ( 31 downto 0 )
  );
end eth_mb_system_wrapper;

architecture STRUCTURE of eth_mb_system_wrapper is
  component eth_mb_system is
  port (
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
    x_sample_from_mb_tri_o : out STD_LOGIC_VECTOR ( 31 downto 0 );
    d_sample_from_mb_tri_o : out STD_LOGIC_VECTOR ( 31 downto 0 );
    control_from_mb_tri_o : out STD_LOGIC_VECTOR ( 31 downto 0 );
    y_result_to_mb_tri_i : in STD_LOGIC_VECTOR ( 31 downto 0 );
    e_result_to_mb_tri_i : in STD_LOGIC_VECTOR ( 31 downto 0 );
    Clk : in STD_LOGIC;
    phy_reset_out : out STD_LOGIC_VECTOR ( 0 to 0 );
    reset : in STD_LOGIC
  );
  end component eth_mb_system;
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
eth_mb_system_i: component eth_mb_system
     port map (
      Clk => Clk,
      control_from_mb_tri_o(31 downto 0) => control_from_mb_tri_o(31 downto 0),
      d_sample_from_mb_tri_o(31 downto 0) => d_sample_from_mb_tri_o(31 downto 0),
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
      phy_reset_out(0) => phy_reset_out(0),
      reset => reset,
      x_sample_from_mb_tri_o(31 downto 0) => x_sample_from_mb_tri_o(31 downto 0),
      y_result_to_mb_tri_i(31 downto 0) => y_result_to_mb_tri_i(31 downto 0)
    );
eth_mdio_mdc_mdio_iobuf: component IOBUF
     port map (
      I => eth_mdio_mdc_mdio_o,
      IO => eth_mdio_mdc_mdio_io,
      O => eth_mdio_mdc_mdio_i,
      T => eth_mdio_mdc_mdio_t
    );
end STRUCTURE;
