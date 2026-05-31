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

// MODULE VLNV: amd.com:blockdesign:genesys2_radar_filter:1.0

`timescale 1ps / 1ps

`include "vivado_interfaces.svh"

module genesys2_radar_filter_sv (
  (* X_INTERFACE_IGNORE = "true" *)
  inout wire [31:0] ddr3_sdram_dq,
  (* X_INTERFACE_IGNORE = "true" *)
  inout wire [3:0] ddr3_sdram_dqs_p,
  (* X_INTERFACE_IGNORE = "true" *)
  inout wire [3:0] ddr3_sdram_dqs_n,
  (* X_INTERFACE_IGNORE = "true" *)
  output wire [14:0] ddr3_sdram_addr,
  (* X_INTERFACE_IGNORE = "true" *)
  output wire [2:0] ddr3_sdram_ba,
  (* X_INTERFACE_IGNORE = "true" *)
  output wire ddr3_sdram_ras_n,
  (* X_INTERFACE_IGNORE = "true" *)
  output wire ddr3_sdram_cas_n,
  (* X_INTERFACE_IGNORE = "true" *)
  output wire ddr3_sdram_we_n,
  (* X_INTERFACE_IGNORE = "true" *)
  output wire ddr3_sdram_reset_n,
  (* X_INTERFACE_IGNORE = "true" *)
  output wire [0:0] ddr3_sdram_ck_p,
  (* X_INTERFACE_IGNORE = "true" *)
  output wire [0:0] ddr3_sdram_ck_n,
  (* X_INTERFACE_IGNORE = "true" *)
  output wire [0:0] ddr3_sdram_cke,
  (* X_INTERFACE_IGNORE = "true" *)
  output wire [0:0] ddr3_sdram_cs_n,
  (* X_INTERFACE_IGNORE = "true" *)
  output wire [3:0] ddr3_sdram_dm,
  (* X_INTERFACE_IGNORE = "true" *)
  output wire [0:0] ddr3_sdram_odt,
  (* X_INTERFACE_IGNORE = "true" *)
  input wire clk_125M,
  (* X_INTERFACE_IGNORE = "true" *)
  input wire clk_200M,
  (* X_INTERFACE_IGNORE = "true" *)
  output wire eth_mdio_mdc_mdc,
  (* X_INTERFACE_IGNORE = "true" *)
  input wire eth_mdio_mdc_mdio_i,
  (* X_INTERFACE_IGNORE = "true" *)
  output wire eth_mdio_mdc_mdio_o,
  (* X_INTERFACE_IGNORE = "true" *)
  output wire eth_mdio_mdc_mdio_t,
  (* X_INTERFACE_IGNORE = "true" *)
  input wire [3:0] eth_rgmii_rd,
  (* X_INTERFACE_IGNORE = "true" *)
  input wire eth_rgmii_rx_ctl,
  (* X_INTERFACE_IGNORE = "true" *)
  input wire eth_rgmii_rxc,
  (* X_INTERFACE_IGNORE = "true" *)
  output wire [3:0] eth_rgmii_td,
  (* X_INTERFACE_IGNORE = "true" *)
  output wire eth_rgmii_tx_ctl,
  (* X_INTERFACE_IGNORE = "true" *)
  output wire eth_rgmii_txc,
  (* X_INTERFACE_IGNORE = "true" *)
  input wire usb_uart_rxd,
  (* X_INTERFACE_IGNORE = "true" *)
  output wire usb_uart_txd,
  (* X_INTERFACE_IGNORE = "true" *)
  input wire sys_rst_n,
  (* X_INTERFACE_IGNORE = "true" *)
  output wire [0:0] phy_reset_out_tri_o,
  (* X_INTERFACE_IGNORE = "true" *)
  output wire [31:0] control_from_mb_tri_o,
  (* X_INTERFACE_IGNORE = "true" *)
  output wire [31:0] x_sample_from_mb_tri_o,
  (* X_INTERFACE_IGNORE = "true" *)
  output wire [31:0] d_sample_from_mb_tri_o,
  (* X_INTERFACE_IGNORE = "true" *)
  input wire [31:0] y_result_to_mb_tri_i,
  (* X_INTERFACE_IGNORE = "true" *)
  input wire [31:0] e_result_to_mb_tri_i
);

  genesys2_radar_filter inst (
    .ddr3_sdram_dq(ddr3_sdram_dq),
    .ddr3_sdram_dqs_p(ddr3_sdram_dqs_p),
    .ddr3_sdram_dqs_n(ddr3_sdram_dqs_n),
    .ddr3_sdram_addr(ddr3_sdram_addr),
    .ddr3_sdram_ba(ddr3_sdram_ba),
    .ddr3_sdram_ras_n(ddr3_sdram_ras_n),
    .ddr3_sdram_cas_n(ddr3_sdram_cas_n),
    .ddr3_sdram_we_n(ddr3_sdram_we_n),
    .ddr3_sdram_reset_n(ddr3_sdram_reset_n),
    .ddr3_sdram_ck_p(ddr3_sdram_ck_p),
    .ddr3_sdram_ck_n(ddr3_sdram_ck_n),
    .ddr3_sdram_cke(ddr3_sdram_cke),
    .ddr3_sdram_cs_n(ddr3_sdram_cs_n),
    .ddr3_sdram_dm(ddr3_sdram_dm),
    .ddr3_sdram_odt(ddr3_sdram_odt),
    .clk_125M(clk_125M),
    .clk_200M(clk_200M),
    .eth_mdio_mdc_mdc(eth_mdio_mdc_mdc),
    .eth_mdio_mdc_mdio_i(eth_mdio_mdc_mdio_i),
    .eth_mdio_mdc_mdio_o(eth_mdio_mdc_mdio_o),
    .eth_mdio_mdc_mdio_t(eth_mdio_mdc_mdio_t),
    .eth_rgmii_rd(eth_rgmii_rd),
    .eth_rgmii_rx_ctl(eth_rgmii_rx_ctl),
    .eth_rgmii_rxc(eth_rgmii_rxc),
    .eth_rgmii_td(eth_rgmii_td),
    .eth_rgmii_tx_ctl(eth_rgmii_tx_ctl),
    .eth_rgmii_txc(eth_rgmii_txc),
    .usb_uart_rxd(usb_uart_rxd),
    .usb_uart_txd(usb_uart_txd),
    .sys_rst_n(sys_rst_n),
    .phy_reset_out_tri_o(phy_reset_out_tri_o),
    .control_from_mb_tri_o(control_from_mb_tri_o),
    .x_sample_from_mb_tri_o(x_sample_from_mb_tri_o),
    .d_sample_from_mb_tri_o(d_sample_from_mb_tri_o),
    .y_result_to_mb_tri_i(y_result_to_mb_tri_i),
    .e_result_to_mb_tri_i(e_result_to_mb_tri_i)
  );

endmodule
