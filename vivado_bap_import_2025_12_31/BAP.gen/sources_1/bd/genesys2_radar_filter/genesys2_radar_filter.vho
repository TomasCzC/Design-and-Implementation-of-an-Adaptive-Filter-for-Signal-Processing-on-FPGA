-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- Copyright 2022-2026 Advanced Micro Devices, Inc. All Rights Reserved.
-- -------------------------------------------------------------------------------
-- This file contains confidential and proprietary information
-- of AMD and is protected under U.S. and international copyright
-- and other intellectual property laws.
--
-- DISCLAIMER
-- This disclaimer is not a license and does not grant any
-- rights to the materials distributed herewith. Except as
-- otherwise provided in a valid license issued to you by
-- AMD, and to the maximum extent permitted by applicable
-- law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
-- WITH ALL FAULTS, AND AMD HEREBY DISCLAIMS ALL WARRANTIES
-- AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
-- BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
-- INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
-- (2) AMD shall not be liable (whether in contract or tort,
-- including negligence, or under any other theory of
-- liability) for any loss or damage of any kind or nature
-- related to, arising under or in connection with these
-- materials, including for any direct, or any indirect,
-- special, incidental, or consequential loss or damage
-- (including loss of data, profits, goodwill, or any type of
-- loss or damage suffered as a result of any action brought
-- by a third party) even if such damage or loss was
-- reasonably foreseeable or AMD had been advised of the
-- possibility of the same.
--
-- CRITICAL APPLICATIONS
-- AMD products are not designed or intended to be fail-
-- safe, or for use in any application requiring fail-safe
-- performance, such as life-support or safety devices or
-- systems, Class III medical devices, nuclear facilities,
-- applications related to the deployment of airbags, or any
-- other applications that could lead to death, personal
-- injury, or severe property or environmental damage
-- (individually and collectively, "Critical
-- Applications"). Customer assumes the sole risk and
-- liability of any use of AMD products in Critical
-- Applications, subject only to applicable laws and
-- regulations governing limitations on product liability.
--
-- THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
-- PART OF THIS FILE AT ALL TIMES.
--
-- DO NOT MODIFY THIS FILE.

-- MODULE VLNV: amd.com:blockdesign:genesys2_radar_filter:1.0

-- The following code must appear in the VHDL architecture header.

-- COMP_TAG     ------ Begin cut for COMPONENT Declaration ------
COMPONENT genesys2_radar_filter
  PORT (
    ddr3_sdram_dq : INOUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    ddr3_sdram_dqs_p : INOUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    ddr3_sdram_dqs_n : INOUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    ddr3_sdram_addr : OUT STD_LOGIC_VECTOR(14 DOWNTO 0);
    ddr3_sdram_ba : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
    ddr3_sdram_ras_n : OUT STD_LOGIC;
    ddr3_sdram_cas_n : OUT STD_LOGIC;
    ddr3_sdram_we_n : OUT STD_LOGIC;
    ddr3_sdram_reset_n : OUT STD_LOGIC;
    ddr3_sdram_ck_p : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
    ddr3_sdram_ck_n : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
    ddr3_sdram_cke : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
    ddr3_sdram_cs_n : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
    ddr3_sdram_dm : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    ddr3_sdram_odt : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
    clk_125M : IN STD_LOGIC;
    clk_200M : IN STD_LOGIC;
    eth_mdio_mdc_mdc : OUT STD_LOGIC;
    eth_mdio_mdc_mdio_i : IN STD_LOGIC;
    eth_mdio_mdc_mdio_o : OUT STD_LOGIC;
    eth_mdio_mdc_mdio_t : OUT STD_LOGIC;
    eth_rgmii_rd : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    eth_rgmii_rx_ctl : IN STD_LOGIC;
    eth_rgmii_rxc : IN STD_LOGIC;
    eth_rgmii_td : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    eth_rgmii_tx_ctl : OUT STD_LOGIC;
    eth_rgmii_txc : OUT STD_LOGIC;
    usb_uart_rxd : IN STD_LOGIC;
    usb_uart_txd : OUT STD_LOGIC;
    sys_rst_n : IN STD_LOGIC;
    phy_reset_out_tri_o : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
    control_from_mb_tri_o : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    x_sample_from_mb_tri_o : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    d_sample_from_mb_tri_o : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    y_result_to_mb_tri_i : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    e_result_to_mb_tri_i : IN STD_LOGIC_VECTOR(31 DOWNTO 0)
  );
END COMPONENT;
-- COMP_TAG_END ------  End cut for COMPONENT Declaration  ------

-- The following code must appear in the VHDL architecture
-- body. Substitute your own instance name and net names.

-- INST_TAG     ------ Begin cut for INSTANTIATION Template ------
your_instance_name : genesys2_radar_filter
  PORT MAP (
    ddr3_sdram_dq => ddr3_sdram_dq,
    ddr3_sdram_dqs_p => ddr3_sdram_dqs_p,
    ddr3_sdram_dqs_n => ddr3_sdram_dqs_n,
    ddr3_sdram_addr => ddr3_sdram_addr,
    ddr3_sdram_ba => ddr3_sdram_ba,
    ddr3_sdram_ras_n => ddr3_sdram_ras_n,
    ddr3_sdram_cas_n => ddr3_sdram_cas_n,
    ddr3_sdram_we_n => ddr3_sdram_we_n,
    ddr3_sdram_reset_n => ddr3_sdram_reset_n,
    ddr3_sdram_ck_p => ddr3_sdram_ck_p,
    ddr3_sdram_ck_n => ddr3_sdram_ck_n,
    ddr3_sdram_cke => ddr3_sdram_cke,
    ddr3_sdram_cs_n => ddr3_sdram_cs_n,
    ddr3_sdram_dm => ddr3_sdram_dm,
    ddr3_sdram_odt => ddr3_sdram_odt,
    clk_125M => clk_125M,
    clk_200M => clk_200M,
    eth_mdio_mdc_mdc => eth_mdio_mdc_mdc,
    eth_mdio_mdc_mdio_i => eth_mdio_mdc_mdio_i,
    eth_mdio_mdc_mdio_o => eth_mdio_mdc_mdio_o,
    eth_mdio_mdc_mdio_t => eth_mdio_mdc_mdio_t,
    eth_rgmii_rd => eth_rgmii_rd,
    eth_rgmii_rx_ctl => eth_rgmii_rx_ctl,
    eth_rgmii_rxc => eth_rgmii_rxc,
    eth_rgmii_td => eth_rgmii_td,
    eth_rgmii_tx_ctl => eth_rgmii_tx_ctl,
    eth_rgmii_txc => eth_rgmii_txc,
    usb_uart_rxd => usb_uart_rxd,
    usb_uart_txd => usb_uart_txd,
    sys_rst_n => sys_rst_n,
    phy_reset_out_tri_o => phy_reset_out_tri_o,
    control_from_mb_tri_o => control_from_mb_tri_o,
    x_sample_from_mb_tri_o => x_sample_from_mb_tri_o,
    d_sample_from_mb_tri_o => d_sample_from_mb_tri_o,
    y_result_to_mb_tri_i => y_result_to_mb_tri_i,
    e_result_to_mb_tri_i => e_result_to_mb_tri_i
  );
-- INST_TAG_END ------  End cut for INSTANTIATION Template  ------

-- You must compile the wrapper file genesys2_radar_filter.vhd when simulating
-- the module, genesys2_radar_filter. When compiling the wrapper file, be sure to
-- reference the VHDL simulation library.
