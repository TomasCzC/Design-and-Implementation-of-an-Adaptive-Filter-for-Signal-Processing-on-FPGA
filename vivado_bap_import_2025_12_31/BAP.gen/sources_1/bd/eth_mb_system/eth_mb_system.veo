// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2026 Advanced Micro Devices, Inc. All Rights Reserved.
// -------------------------------------------------------------------------------
// This file contains confidential and proprietary information
// of AMD and is protected under U.S. and international copyright
// and other intellectual property laws.
//
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// AMD, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND AMD HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) AMD shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or AMD had been advised of the
// possibility of the same.
//
// CRITICAL APPLICATIONS
// AMD products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of AMD products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
//
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
//
// DO NOT MODIFY THIS FILE.

// MODULE VLNV: amd.com:blockdesign:eth_mb_system:1.0

// The following must be inserted into your Verilog file for this
// module to be instantiated. Change the instance name and port connections
// (in parentheses) to your own signal names.

// INST_TAG     ------ Begin cut for INSTANTIATION Template ------
eth_mb_system your_instance_name (
  .eth_mdio_mdc_mdc(eth_mdio_mdc_mdc), // output wire eth_mdio_mdc_mdc
  .eth_mdio_mdc_mdio_i(eth_mdio_mdc_mdio_i), // input wire eth_mdio_mdc_mdio_i
  .eth_mdio_mdc_mdio_o(eth_mdio_mdc_mdio_o), // output wire eth_mdio_mdc_mdio_o
  .eth_mdio_mdc_mdio_t(eth_mdio_mdc_mdio_t), // output wire eth_mdio_mdc_mdio_t
  .eth_rgmii_rd(eth_rgmii_rd), // input wire [3:0] eth_rgmii_rd
  .eth_rgmii_rx_ctl(eth_rgmii_rx_ctl), // input wire eth_rgmii_rx_ctl
  .eth_rgmii_rxc(eth_rgmii_rxc), // input wire eth_rgmii_rxc
  .eth_rgmii_td(eth_rgmii_td), // output wire [3:0] eth_rgmii_td
  .eth_rgmii_tx_ctl(eth_rgmii_tx_ctl), // output wire eth_rgmii_tx_ctl
  .eth_rgmii_txc(eth_rgmii_txc), // output wire eth_rgmii_txc
  .x_sample_from_mb_tri_o(x_sample_from_mb_tri_o), // output wire [31:0] x_sample_from_mb_tri_o
  .d_sample_from_mb_tri_o(d_sample_from_mb_tri_o), // output wire [31:0] d_sample_from_mb_tri_o
  .control_from_mb_tri_o(control_from_mb_tri_o), // output wire [31:0] control_from_mb_tri_o
  .y_result_to_mb_tri_i(y_result_to_mb_tri_i), // input wire [31:0] y_result_to_mb_tri_i
  .e_result_to_mb_tri_i(e_result_to_mb_tri_i), // input wire [31:0] e_result_to_mb_tri_i
  .Clk(Clk), // input wire Clk
  .phy_reset_out(phy_reset_out), // output wire [0:0] phy_reset_out
  .reset(reset) // input wire reset
);
// INST_TAG_END ------  End cut for INSTANTIATION Template  ------

// You must compile the wrapper file eth_mb_system.v when simulating
// the module, eth_mb_system. When compiling the wrapper file, be sure to
// reference the Verilog simulation library.
