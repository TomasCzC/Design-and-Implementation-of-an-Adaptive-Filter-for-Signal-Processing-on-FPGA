// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2025.2 (win64) Build 6299465 Fri Nov 14 19:35:11 GMT 2025
// Date        : Fri May 29 10:09:13 2026
// Host        : TOMAS-PC running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               c:/FPGA/BAP/BAP.gen/sources_1/bd/eth_mb_system/ip/eth_mb_system_axi_bram_ctrl_0_bram_0/eth_mb_system_axi_bram_ctrl_0_bram_0_sim_netlist.v
// Design      : eth_mb_system_axi_bram_ctrl_0_bram_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7k325tffg900-2
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "eth_mb_system_axi_bram_ctrl_0_bram_0,blk_mem_gen_v8_4_12,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "blk_mem_gen_v8_4_12,Vivado 2025.2" *) 
(* NotValidForBitStream *)
module eth_mb_system_axi_bram_ctrl_0_bram_0
   (clka,
    rsta,
    ena,
    wea,
    addra,
    dina,
    douta,
    rsta_busy);
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA CLK" *) (* x_interface_mode = "slave BRAM_PORTA" *) (* x_interface_parameter = "XIL_INTERFACENAME BRAM_PORTA, MEM_ADDRESS_MODE BYTE_ADDRESS, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE BRAM_CTRL, READ_WRITE_MODE READ_WRITE, READ_LATENCY 1" *) input clka;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA RST" *) input rsta;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA EN" *) input ena;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA WE" *) input [3:0]wea;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA ADDR" *) input [31:0]addra;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DIN" *) input [31:0]dina;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DOUT" *) output [31:0]douta;
  output rsta_busy;

  wire [31:0]addra;
  wire clka;
  wire [31:0]dina;
  wire [31:0]douta;
  wire ena;
  wire rsta;
  wire rsta_busy;
  wire [3:0]wea;
  wire NLW_U0_dbiterr_UNCONNECTED;
  wire NLW_U0_rstb_busy_UNCONNECTED;
  wire NLW_U0_s_axi_arready_UNCONNECTED;
  wire NLW_U0_s_axi_awready_UNCONNECTED;
  wire NLW_U0_s_axi_bvalid_UNCONNECTED;
  wire NLW_U0_s_axi_dbiterr_UNCONNECTED;
  wire NLW_U0_s_axi_rlast_UNCONNECTED;
  wire NLW_U0_s_axi_rvalid_UNCONNECTED;
  wire NLW_U0_s_axi_sbiterr_UNCONNECTED;
  wire NLW_U0_s_axi_wready_UNCONNECTED;
  wire NLW_U0_sbiterr_UNCONNECTED;
  wire [31:0]NLW_U0_doutb_UNCONNECTED;
  wire [31:0]NLW_U0_rdaddrecc_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_bid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_bresp_UNCONNECTED;
  wire [31:0]NLW_U0_s_axi_rdaddrecc_UNCONNECTED;
  wire [31:0]NLW_U0_s_axi_rdata_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_rid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_rresp_UNCONNECTED;

  (* C_ADDRA_WIDTH = "32" *) 
  (* C_ADDRB_WIDTH = "32" *) 
  (* C_ALGORITHM = "1" *) 
  (* C_AXI_ID_WIDTH = "4" *) 
  (* C_AXI_SLAVE_TYPE = "0" *) 
  (* C_AXI_TYPE = "1" *) 
  (* C_BYTE_SIZE = "8" *) 
  (* C_COMMON_CLK = "0" *) 
  (* C_COUNT_18K_BRAM = "0" *) 
  (* C_COUNT_36K_BRAM = "2" *) 
  (* C_CTRL_ECC_ALGO = "NONE" *) 
  (* C_DEFAULT_DATA = "0" *) 
  (* C_DISABLE_WARN_BHV_COLL = "0" *) 
  (* C_DISABLE_WARN_BHV_RANGE = "0" *) 
  (* C_ELABORATION_DIR = "./" *) 
  (* C_ENABLE_32BIT_ADDRESS = "1" *) 
  (* C_EN_DEEPSLEEP_PIN = "0" *) 
  (* C_EN_ECC_PIPE = "0" *) 
  (* C_EN_RDADDRA_CHG = "0" *) 
  (* C_EN_RDADDRB_CHG = "0" *) 
  (* C_EN_SAFETY_CKT = "1" *) 
  (* C_EN_SHUTDOWN_PIN = "0" *) 
  (* C_EN_SLEEP_PIN = "0" *) 
  (* C_EST_POWER_SUMMARY = "Estimated Power for IP     :     5.3746 mW" *) 
  (* C_FAMILY = "kintex7" *) 
  (* C_HAS_AXI_ID = "0" *) 
  (* C_HAS_ENA = "1" *) 
  (* C_HAS_ENB = "0" *) 
  (* C_HAS_INJECTERR = "0" *) 
  (* C_HAS_MEM_OUTPUT_REGS_A = "0" *) 
  (* C_HAS_MEM_OUTPUT_REGS_B = "0" *) 
  (* C_HAS_MUX_OUTPUT_REGS_A = "0" *) 
  (* C_HAS_MUX_OUTPUT_REGS_B = "0" *) 
  (* C_HAS_REGCEA = "0" *) 
  (* C_HAS_REGCEB = "0" *) 
  (* C_HAS_RSTA = "1" *) 
  (* C_HAS_RSTB = "0" *) 
  (* C_HAS_SOFTECC_INPUT_REGS_A = "0" *) 
  (* C_HAS_SOFTECC_OUTPUT_REGS_B = "0" *) 
  (* C_INITA_VAL = "0" *) 
  (* C_INITB_VAL = "0" *) 
  (* C_INIT_FILE = "eth_mb_system_axi_bram_ctrl_0_bram_0.mem" *) 
  (* C_INIT_FILE_NAME = "no_coe_file_loaded" *) 
  (* C_INTERFACE_TYPE = "0" *) 
  (* C_LOAD_INIT_FILE = "0" *) 
  (* C_MEM_TYPE = "0" *) 
  (* C_MUX_PIPELINE_STAGES = "0" *) 
  (* C_PRIM_TYPE = "1" *) 
  (* C_READ_DEPTH_A = "2048" *) 
  (* C_READ_DEPTH_B = "2048" *) 
  (* C_READ_LATENCY_A = "1" *) 
  (* C_READ_LATENCY_B = "1" *) 
  (* C_READ_WIDTH_A = "32" *) 
  (* C_READ_WIDTH_B = "32" *) 
  (* C_RSTRAM_A = "0" *) 
  (* C_RSTRAM_B = "0" *) 
  (* C_RST_PRIORITY_A = "CE" *) 
  (* C_RST_PRIORITY_B = "CE" *) 
  (* C_SIM_COLLISION_CHECK = "ALL" *) 
  (* C_USE_BRAM_BLOCK = "1" *) 
  (* C_USE_BYTE_WEA = "1" *) 
  (* C_USE_BYTE_WEB = "1" *) 
  (* C_USE_DEFAULT_DATA = "0" *) 
  (* C_USE_ECC = "0" *) 
  (* C_USE_SOFTECC = "0" *) 
  (* C_USE_URAM = "0" *) 
  (* C_WEA_WIDTH = "4" *) 
  (* C_WEB_WIDTH = "4" *) 
  (* C_WRITE_DEPTH_A = "2048" *) 
  (* C_WRITE_DEPTH_B = "2048" *) 
  (* C_WRITE_MODE_A = "WRITE_FIRST" *) 
  (* C_WRITE_MODE_B = "WRITE_FIRST" *) 
  (* C_WRITE_WIDTH_A = "32" *) 
  (* C_WRITE_WIDTH_B = "32" *) 
  (* C_XDEVICEFAMILY = "kintex7" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  (* is_du_within_envelope = "true" *) 
  eth_mb_system_axi_bram_ctrl_0_bram_0_blk_mem_gen_v8_4_12 U0
       (.addra({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,addra[12:2],1'b0,1'b0}),
        .addrb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .clka(clka),
        .clkb(1'b0),
        .dbiterr(NLW_U0_dbiterr_UNCONNECTED),
        .deepsleep(1'b0),
        .dina(dina),
        .dinb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .douta(douta),
        .doutb(NLW_U0_doutb_UNCONNECTED[31:0]),
        .eccpipece(1'b0),
        .ena(ena),
        .enb(1'b0),
        .injectdbiterr(1'b0),
        .injectsbiterr(1'b0),
        .rdaddrecc(NLW_U0_rdaddrecc_UNCONNECTED[31:0]),
        .regcea(1'b1),
        .regceb(1'b1),
        .rsta(rsta),
        .rsta_busy(rsta_busy),
        .rstb(1'b0),
        .rstb_busy(NLW_U0_rstb_busy_UNCONNECTED),
        .s_aclk(1'b0),
        .s_aresetn(1'b0),
        .s_axi_araddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arburst({1'b0,1'b0}),
        .s_axi_arid({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arlen({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arready(NLW_U0_s_axi_arready_UNCONNECTED),
        .s_axi_arsize({1'b0,1'b0,1'b0}),
        .s_axi_arvalid(1'b0),
        .s_axi_awaddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awburst({1'b0,1'b0}),
        .s_axi_awid({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awlen({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awready(NLW_U0_s_axi_awready_UNCONNECTED),
        .s_axi_awsize({1'b0,1'b0,1'b0}),
        .s_axi_awvalid(1'b0),
        .s_axi_bid(NLW_U0_s_axi_bid_UNCONNECTED[3:0]),
        .s_axi_bready(1'b0),
        .s_axi_bresp(NLW_U0_s_axi_bresp_UNCONNECTED[1:0]),
        .s_axi_bvalid(NLW_U0_s_axi_bvalid_UNCONNECTED),
        .s_axi_dbiterr(NLW_U0_s_axi_dbiterr_UNCONNECTED),
        .s_axi_injectdbiterr(1'b0),
        .s_axi_injectsbiterr(1'b0),
        .s_axi_rdaddrecc(NLW_U0_s_axi_rdaddrecc_UNCONNECTED[31:0]),
        .s_axi_rdata(NLW_U0_s_axi_rdata_UNCONNECTED[31:0]),
        .s_axi_rid(NLW_U0_s_axi_rid_UNCONNECTED[3:0]),
        .s_axi_rlast(NLW_U0_s_axi_rlast_UNCONNECTED),
        .s_axi_rready(1'b0),
        .s_axi_rresp(NLW_U0_s_axi_rresp_UNCONNECTED[1:0]),
        .s_axi_rvalid(NLW_U0_s_axi_rvalid_UNCONNECTED),
        .s_axi_sbiterr(NLW_U0_s_axi_sbiterr_UNCONNECTED),
        .s_axi_wdata({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_wlast(1'b0),
        .s_axi_wready(NLW_U0_s_axi_wready_UNCONNECTED),
        .s_axi_wstrb({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_wvalid(1'b0),
        .sbiterr(NLW_U0_sbiterr_UNCONNECTED),
        .shutdown(1'b0),
        .sleep(1'b0),
        .wea(wea),
        .web({1'b0,1'b0,1'b0,1'b0}));
endmodule
`pragma protect begin_protected
`pragma protect version = 1
`pragma protect encrypt_agent = "XILINX"
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2025.2"
`pragma protect key_keyowner="Synopsys", key_keyname="SNPS-VCS-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
YqH9kwIC39+qbZg4PSfFsXuB9k9wnuxNryS/CfnEri6Ci9fSC6fsrQ/T/hnt3u/yolbJ8DJa1Qu6
Qnm24A9jLbA+fu3Nsmm6/rM6a4vU6OfVl/gTFd/CiWDutv6Dhn6Lim4uUNPahoOR/A2Yc4Zo2tdI
kMLO9gn9WlH2l3O2oXs=

`pragma protect key_keyowner="Aldec", key_keyname="ALDEC15_001", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
XJYO2VHd/cnMxQd3i7/2qRhl57dl+doEKuhAunQyv3vpGRG/jlNxj8PqrgLoF0HMdqE3qJUVE/oq
kBSapqjVjLDMOrNGQ+Tc6VGsKMZH8FE/TXHQJ/IM5Iuiu2eozEwwVUomF+7cfqn+9OsVsqCONQ1M
g0oRlangiqasJDhhMfnlGGqwAwmgWRGQA6dmhTuua1s8zdvIv540zY6p5au8cAKVhqyyKK7wbxEE
SGuFqX+NYoyRV+rfWCcWM+hJEmnWS8LNAKkd13YE2+17sPYzUdZ23DmTxXK6KlAxKFW27CBySUfg
qdNXp2DSs2KAQYih27pBNMuHfGbM/ATFPWFvxg==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VELOCE-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
lYoEi/e8HsDTz6N11EDe/B/iitERmeYndlCklmCluwgb0N4W80JUGVlkd7NlRZHRNhxaNBJPkcjC
n61nO0tb17NwsMwjbY5TF8JWRYTNw1JXCFacvQYrdKv4/7QNQEtwVGiCLxFhOA8aHlWMZIrc2fri
VRMVWaEBcPwCGorlVIM=

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
QEw9fEsWFbdX0OQLvYs/gl+zyEOW3ak9TdQVaq+0AXXOT3LIqF7wDxJ6ZBnlf9mNbdsUVH5tAz1o
H8u7ihJl1L3THEvugW+TS8hkvVbEA9rKO2vV15KAj4Lla7UdFT/xDfe79RFarlLI7yGrubjgdoRi
QWy//UKsffG7IWNwmoSuppWiWB4ZHJtkunNyIkm70JPGyZF62VxJg1MTT+5LUbZG5vZjjuHZud9w
xJaKv1tFP/x8RVqLU5gPOqGqTW7/nKO2S+450Vo4D9vAmBVVcXpaL1EbSmCvQ+qJmcQKtf9qYFRV
Zko08hbpHjPxstqvTDro01jRzB8592m4xU2TWA==

`pragma protect key_keyowner="Real Intent", key_keyname="RI-RSA-KEY-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
TC7q853CWBPPJgbRfgDV1lmjUwSAtliljShAyNFg8sfRfwDzchthzoSPH1UCHV++E2JXacEKq1lB
UWsNP92U4Xh0/Gu+6esOI0pJb8I+TRTxyBN1I4cRQEfQHcwfhbSdeH3yX9OV3opLEqYmT37hWU+J
zCawYnxVESI0FtRzEXve9gdEWlrKKckrT/hp4mvxxOjvOkOSQBvy0elgUOqh6mEOZl+JnUbsR+Wm
CoZLE1eefMZy3FnVmyDNPv3JPXi88aLXMyimal0MYFkTiS4XJiGT3eAIMIbksehXY+eYi/KFpZWQ
GHpX+lG3UmiWWLwyPakFwKEHbrBc70AlJ2eV9g==

`pragma protect key_keyowner="Xilinx", key_keyname="xilinxt_2025.1-2029.x", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
j9nmCKgjPWNChPbpSW6EWLrMA6oCG2JGPoum8px09v0PEAh0DRXZi0J8HPzXUsZgOEMcKpA7X54u
YFcDDCLAQ+urha/eSPbQYHQh4yGCursxAQ1C6LEyNQ2wJ0eLlO2bJeAl/gof06zqsYVM2lLJVNv5
wao1k2bmgPdfpfY3c9vPD0fSMuZPS41EoRS0cQhO5GTZnKdjxm6tEUL3GnTjB8ynSCIbCJUsMtAX
4FRHNa52gudx5B5fagR+lXgFhE7e++rWTJELr7SYB+r5Es8qZLTpCH8TrQxEkV0rY/+e4sAjNE2D
gHw8GD7VcUtc15B8y1BbVmh29qc8Nd3V2i/miA==

`pragma protect key_keyowner="Metrics Technologies Inc.", key_keyname="DSim", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
UkCD6I/Vye4qNoNoa3hIexBXG3xyKUJPAHAjIo7UcNVCDXpMQiYEtPDqExZMfiPlJn2nswCYIfIJ
FYWqMCloKSQyyI/7yZ2EtbyWEklb/P5IyZyvGi6hhFUo/JFTb12b4bK0gZPr+bCDdlVQKTx5GVHz
wptdUJO2omSj8axVMPbLRRtVzlJIZ29dTJ2ATXVXAcBxPnFfHRAMnYYKLeeLExX61vQvpqrkLQHm
XG7hpVzJi56gYKAzxa2BLq072OCVpVS70bfWlhlSTVcSlCrUf+EcarEk4FD8+Ih2NCvrqremG6yn
TtcBn8Xr8M/6zhOYvLi6AD6eArDMKA8n+Ccv8A==

`pragma protect key_keyowner="Atrenta", key_keyname="ATR-SG-RSA-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=384)
`pragma protect key_block
A5y5QVZU8yjPexRVPioSiAGohCHD5DX5FVobuMyhcgQRExLUhPvnnS8HOtxTj/2IapEcz68gFMGG
Hpi+m725u85/om/Vze9pGIW9Mn328Kz2FIg3W5EvGstfGwY+48LiAGAmTR269JS4lJGVYWYOz7Xk
S8cEsFd2m7j8iyKtARJzD90+UdXq/cIIh725jC9i8nbgxB364zddvm1Z/DF3JRw1qFp6GGcuRai1
KNcJ1j8c9wtIgktpsteU3e5+bxHEw8NT3gWXUFYjm00NDq97Jals8Jjktmum2nQxoF7ivPacfEey
gnSF6jRMkTsZObzc30hAhs0CEtc33hZLhPLHSn8pQ0WyvKJLHdd5s2yckgTZtqxC1Sbwe7WEgNXe
ZMX3pIkz+aoXsAL7GBLyVBMVQcyMoF0w8QGAaTe8sqatABwPqXidYRqNROTf62IYcMpV89XYgaTv
EwIn/oni9KOFd2BFVxRZbFGGC4IjvigsTBUijI+Dk6kVnDh240clGcc4

`pragma protect key_keyowner="Cadence Design Systems.", key_keyname="CDS_RSA_KEY_VER_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
Omtp+lCaqUx7Z4qdFj2zrN8LpCkit2eX4hlMtig+ielGm/x4FSZkpjoFmiqdKFPi2eg0pg09MSai
XyGH68UzAR7Xrj8f1jlIoUmMKp4GcxfdqfTeuu7kWGOJEP6cvgTjSJFj2gawDv7f4yZcltnK2x0L
e4GW/rBTmGvZtKWb2ahjINLxPuh3dDaSaWdb+zVgbtyrI5FrjxBkq+aOxSjyNsqnCx1L0uWbxnkl
88NbXN3dTaECXHNm/fsleayM5hKis7kTv9BFajJMGy+BhQlmIYpE+F5zchnTTFUFJZCz1sX9Fc8e
HcY7irB8mR3ajdzjUZLBQEMktp096Nheq3U75A==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
hpeBLwN9x2ZFDwroYLlUe5GjjDepHik2l0c2s3/6S7JPCRkzQSyt2V1Ad/JewAs/QNp5SXSbYYB4
rQl0My1LDMF3xw43r0g2IbcyHVpPhGp0W5msuQdF67afnsRv90iJYWLMI3QkYGCTWAzl4HrLxFSg
3z8XZRK670IcxznOrlvgHmIKsvubZrBkuc1EynrVb9Nw16QnIx2rc4WgcEXeFf+4i1RoYLDd3gXK
NFCNMdtaRYUThunFP6Z4ViZ5UnDmKq+IMhd31jTaqIlWOBDxPI1+v5RJYxIyTbn4rxlKR2fNbl5/
z4OUjBTd+1GH3I2OXlqmAOvIhpe2Z2HH7nZu/A==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-PREC-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
Mt2RhTSUwEIEWeNARbyL+EdfS1UF6nPaL/fKl/7oO2gina93egwCWDLl1fbBtkfaPco0cu4MJ9K3
OraAsyHRlY+MNShmJ1LzAIA1LjZx4y55lu9dlQqSUXR7AW7wVbkg1864mK+hM/1XygU0jvebKNW9
B7xSER+asLO6pxi0mt7uC2PHxLPAYEszFhmnap82TtbDGdQ2qtyekY+ngs+N2fAdsblxVwJruiMl
e6XJ127M8N1mYwhWU2HtRpBOSnnKoHgD9fG51XK/rhk8DxT66QnX9uLPB+H25eDupBJGi1Y5o6x8
hOwZiSUVlBLh7brfzevh7+eRn+7es6wBas0+3w==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 53664)
`pragma protect data_block
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
hgDmfjKi0ZNWx26CXh6n+ZeZwPnio05DjM3Z
`pragma protect end_protected
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;
    parameter GRES_WIDTH = 10000;
    parameter GRES_START = 10000;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    wire GRESTORE;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;
    reg GRESTORE_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;
    assign (strong1, weak0) GRESTORE = GRESTORE_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

    initial begin 
	GRESTORE_int = 1'b0;
	#(GRES_START);
	GRESTORE_int = 1'b1;
	#(GRES_WIDTH);
	GRESTORE_int = 1'b0;
    end

endmodule
`endif
