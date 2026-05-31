// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2025.2 (win64) Build 6299465 Fri Nov 14 19:35:11 GMT 2025
// Date        : Fri May 29 03:28:10 2026
// Host        : TOMAS-PC running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim -rename_top pixel_buffer -prefix
//               pixel_buffer_ pixel_buffer_sim_netlist.v
// Design      : pixel_buffer
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7k325tffg900-2
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "pixel_buffer,blk_mem_gen_v8_4_12,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "blk_mem_gen_v8_4_12,Vivado 2025.2" *) 
(* NotValidForBitStream *)
module pixel_buffer
   (clka,
    wea,
    addra,
    dina,
    clkb,
    addrb,
    doutb);
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA CLK" *) (* x_interface_mode = "slave BRAM_PORTA" *) (* x_interface_parameter = "XIL_INTERFACENAME BRAM_PORTA, MEM_ADDRESS_MODE BYTE_ADDRESS, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE OTHER, READ_LATENCY 1" *) input clka;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA WE" *) input [0:0]wea;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA ADDR" *) input [8:0]addra;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DIN" *) input [7:0]dina;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB CLK" *) (* x_interface_mode = "slave BRAM_PORTB" *) (* x_interface_parameter = "XIL_INTERFACENAME BRAM_PORTB, MEM_ADDRESS_MODE BYTE_ADDRESS, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE OTHER, READ_LATENCY 1" *) input clkb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB ADDR" *) input [8:0]addrb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB DOUT" *) output [7:0]doutb;

  wire [8:0]addra;
  wire [8:0]addrb;
  wire clka;
  wire [7:0]dina;
  wire [7:0]doutb;
  wire [0:0]wea;
  wire NLW_U0_dbiterr_UNCONNECTED;
  wire NLW_U0_rsta_busy_UNCONNECTED;
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
  wire [7:0]NLW_U0_douta_UNCONNECTED;
  wire [8:0]NLW_U0_rdaddrecc_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_bid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_bresp_UNCONNECTED;
  wire [8:0]NLW_U0_s_axi_rdaddrecc_UNCONNECTED;
  wire [7:0]NLW_U0_s_axi_rdata_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_rid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_rresp_UNCONNECTED;

  (* C_ADDRA_WIDTH = "9" *) 
  (* C_ADDRB_WIDTH = "9" *) 
  (* C_ALGORITHM = "1" *) 
  (* C_AXI_ID_WIDTH = "4" *) 
  (* C_AXI_SLAVE_TYPE = "0" *) 
  (* C_AXI_TYPE = "1" *) 
  (* C_BYTE_SIZE = "9" *) 
  (* C_COMMON_CLK = "1" *) 
  (* C_COUNT_18K_BRAM = "1" *) 
  (* C_COUNT_36K_BRAM = "0" *) 
  (* C_CTRL_ECC_ALGO = "NONE" *) 
  (* C_DEFAULT_DATA = "0" *) 
  (* C_DISABLE_WARN_BHV_COLL = "0" *) 
  (* C_DISABLE_WARN_BHV_RANGE = "0" *) 
  (* C_ELABORATION_DIR = "./" *) 
  (* C_ENABLE_32BIT_ADDRESS = "0" *) 
  (* C_EN_DEEPSLEEP_PIN = "0" *) 
  (* C_EN_ECC_PIPE = "0" *) 
  (* C_EN_RDADDRA_CHG = "0" *) 
  (* C_EN_RDADDRB_CHG = "0" *) 
  (* C_EN_SAFETY_CKT = "0" *) 
  (* C_EN_SHUTDOWN_PIN = "0" *) 
  (* C_EN_SLEEP_PIN = "0" *) 
  (* C_EST_POWER_SUMMARY = "Estimated Power for IP     :     2.68455 mW" *) 
  (* C_FAMILY = "kintex7" *) 
  (* C_HAS_AXI_ID = "0" *) 
  (* C_HAS_ENA = "0" *) 
  (* C_HAS_ENB = "0" *) 
  (* C_HAS_INJECTERR = "0" *) 
  (* C_HAS_MEM_OUTPUT_REGS_A = "0" *) 
  (* C_HAS_MEM_OUTPUT_REGS_B = "0" *) 
  (* C_HAS_MUX_OUTPUT_REGS_A = "0" *) 
  (* C_HAS_MUX_OUTPUT_REGS_B = "0" *) 
  (* C_HAS_REGCEA = "0" *) 
  (* C_HAS_REGCEB = "0" *) 
  (* C_HAS_RSTA = "0" *) 
  (* C_HAS_RSTB = "0" *) 
  (* C_HAS_SOFTECC_INPUT_REGS_A = "0" *) 
  (* C_HAS_SOFTECC_OUTPUT_REGS_B = "0" *) 
  (* C_INITA_VAL = "0" *) 
  (* C_INITB_VAL = "0" *) 
  (* C_INIT_FILE = "pixel_buffer.mem" *) 
  (* C_INIT_FILE_NAME = "no_coe_file_loaded" *) 
  (* C_INTERFACE_TYPE = "0" *) 
  (* C_LOAD_INIT_FILE = "0" *) 
  (* C_MEM_TYPE = "1" *) 
  (* C_MUX_PIPELINE_STAGES = "0" *) 
  (* C_PRIM_TYPE = "1" *) 
  (* C_READ_DEPTH_A = "512" *) 
  (* C_READ_DEPTH_B = "512" *) 
  (* C_READ_LATENCY_A = "1" *) 
  (* C_READ_LATENCY_B = "1" *) 
  (* C_READ_WIDTH_A = "8" *) 
  (* C_READ_WIDTH_B = "8" *) 
  (* C_RSTRAM_A = "0" *) 
  (* C_RSTRAM_B = "0" *) 
  (* C_RST_PRIORITY_A = "CE" *) 
  (* C_RST_PRIORITY_B = "CE" *) 
  (* C_SIM_COLLISION_CHECK = "ALL" *) 
  (* C_USE_BRAM_BLOCK = "0" *) 
  (* C_USE_BYTE_WEA = "0" *) 
  (* C_USE_BYTE_WEB = "0" *) 
  (* C_USE_DEFAULT_DATA = "0" *) 
  (* C_USE_ECC = "0" *) 
  (* C_USE_SOFTECC = "0" *) 
  (* C_USE_URAM = "0" *) 
  (* C_WEA_WIDTH = "1" *) 
  (* C_WEB_WIDTH = "1" *) 
  (* C_WRITE_DEPTH_A = "512" *) 
  (* C_WRITE_DEPTH_B = "512" *) 
  (* C_WRITE_MODE_A = "NO_CHANGE" *) 
  (* C_WRITE_MODE_B = "READ_FIRST" *) 
  (* C_WRITE_WIDTH_A = "8" *) 
  (* C_WRITE_WIDTH_B = "8" *) 
  (* C_XDEVICEFAMILY = "kintex7" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  (* is_du_within_envelope = "true" *) 
  pixel_buffer_blk_mem_gen_v8_4_12 U0
       (.addra(addra),
        .addrb(addrb),
        .clka(clka),
        .clkb(1'b0),
        .dbiterr(NLW_U0_dbiterr_UNCONNECTED),
        .deepsleep(1'b0),
        .dina(dina),
        .dinb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .douta(NLW_U0_douta_UNCONNECTED[7:0]),
        .doutb(doutb),
        .eccpipece(1'b0),
        .ena(1'b0),
        .enb(1'b0),
        .injectdbiterr(1'b0),
        .injectsbiterr(1'b0),
        .rdaddrecc(NLW_U0_rdaddrecc_UNCONNECTED[8:0]),
        .regcea(1'b1),
        .regceb(1'b1),
        .rsta(1'b0),
        .rsta_busy(NLW_U0_rsta_busy_UNCONNECTED),
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
        .s_axi_rdaddrecc(NLW_U0_s_axi_rdaddrecc_UNCONNECTED[8:0]),
        .s_axi_rdata(NLW_U0_s_axi_rdata_UNCONNECTED[7:0]),
        .s_axi_rid(NLW_U0_s_axi_rid_UNCONNECTED[3:0]),
        .s_axi_rlast(NLW_U0_s_axi_rlast_UNCONNECTED),
        .s_axi_rready(1'b0),
        .s_axi_rresp(NLW_U0_s_axi_rresp_UNCONNECTED[1:0]),
        .s_axi_rvalid(NLW_U0_s_axi_rvalid_UNCONNECTED),
        .s_axi_sbiterr(NLW_U0_s_axi_sbiterr_UNCONNECTED),
        .s_axi_wdata({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_wlast(1'b0),
        .s_axi_wready(NLW_U0_s_axi_wready_UNCONNECTED),
        .s_axi_wstrb(1'b0),
        .s_axi_wvalid(1'b0),
        .sbiterr(NLW_U0_sbiterr_UNCONNECTED),
        .shutdown(1'b0),
        .sleep(1'b0),
        .wea(wea),
        .web(1'b0));
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
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 20848)
`pragma protect data_block
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
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
