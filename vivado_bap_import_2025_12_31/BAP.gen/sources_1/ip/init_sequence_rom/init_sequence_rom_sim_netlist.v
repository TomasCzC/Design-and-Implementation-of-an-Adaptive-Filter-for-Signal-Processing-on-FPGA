// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2025.2 (win64) Build 6299465 Fri Nov 14 19:35:11 GMT 2025
// Date        : Fri May 29 03:20:33 2026
// Host        : TOMAS-PC running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               c:/FPGA/BAP/BAP.gen/sources_1/ip/init_sequence_rom/init_sequence_rom_sim_netlist.v
// Design      : init_sequence_rom
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7k325tffg900-2
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "init_sequence_rom,blk_mem_gen_v8_4_12,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "blk_mem_gen_v8_4_12,Vivado 2025.2" *) 
(* NotValidForBitStream *)
module init_sequence_rom
   (clka,
    addra,
    douta);
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA CLK" *) (* x_interface_mode = "slave BRAM_PORTA" *) (* x_interface_parameter = "XIL_INTERFACENAME BRAM_PORTA, MEM_ADDRESS_MODE BYTE_ADDRESS, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE OTHER, READ_LATENCY 1" *) input clka;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA ADDR" *) input [3:0]addra;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DOUT" *) output [15:0]douta;

  wire [3:0]addra;
  wire clka;
  wire [15:0]douta;
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
  wire [15:0]NLW_U0_doutb_UNCONNECTED;
  wire [3:0]NLW_U0_rdaddrecc_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_bid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_bresp_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_rdaddrecc_UNCONNECTED;
  wire [15:0]NLW_U0_s_axi_rdata_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_rid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_rresp_UNCONNECTED;

  (* C_ADDRA_WIDTH = "4" *) 
  (* C_ADDRB_WIDTH = "4" *) 
  (* C_ALGORITHM = "1" *) 
  (* C_AXI_ID_WIDTH = "4" *) 
  (* C_AXI_SLAVE_TYPE = "0" *) 
  (* C_AXI_TYPE = "1" *) 
  (* C_BYTE_SIZE = "9" *) 
  (* C_COMMON_CLK = "0" *) 
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
  (* C_EST_POWER_SUMMARY = "Estimated Power for IP     :     2.7096 mW" *) 
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
  (* C_INIT_FILE = "init_sequence_rom.mem" *) 
  (* C_INIT_FILE_NAME = "init_sequence_rom.mif" *) 
  (* C_INTERFACE_TYPE = "0" *) 
  (* C_LOAD_INIT_FILE = "1" *) 
  (* C_MEM_TYPE = "3" *) 
  (* C_MUX_PIPELINE_STAGES = "0" *) 
  (* C_PRIM_TYPE = "1" *) 
  (* C_READ_DEPTH_A = "16" *) 
  (* C_READ_DEPTH_B = "16" *) 
  (* C_READ_LATENCY_A = "1" *) 
  (* C_READ_LATENCY_B = "1" *) 
  (* C_READ_WIDTH_A = "16" *) 
  (* C_READ_WIDTH_B = "16" *) 
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
  (* C_WRITE_DEPTH_A = "16" *) 
  (* C_WRITE_DEPTH_B = "16" *) 
  (* C_WRITE_MODE_A = "WRITE_FIRST" *) 
  (* C_WRITE_MODE_B = "WRITE_FIRST" *) 
  (* C_WRITE_WIDTH_A = "16" *) 
  (* C_WRITE_WIDTH_B = "16" *) 
  (* C_XDEVICEFAMILY = "kintex7" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  (* is_du_within_envelope = "true" *) 
  init_sequence_rom_blk_mem_gen_v8_4_12 U0
       (.addra(addra),
        .addrb({1'b0,1'b0,1'b0,1'b0}),
        .clka(clka),
        .clkb(1'b0),
        .dbiterr(NLW_U0_dbiterr_UNCONNECTED),
        .deepsleep(1'b0),
        .dina({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .dinb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .douta(douta),
        .doutb(NLW_U0_doutb_UNCONNECTED[15:0]),
        .eccpipece(1'b0),
        .ena(1'b0),
        .enb(1'b0),
        .injectdbiterr(1'b0),
        .injectsbiterr(1'b0),
        .rdaddrecc(NLW_U0_rdaddrecc_UNCONNECTED[3:0]),
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
        .s_axi_rdaddrecc(NLW_U0_s_axi_rdaddrecc_UNCONNECTED[3:0]),
        .s_axi_rdata(NLW_U0_s_axi_rdata_UNCONNECTED[15:0]),
        .s_axi_rid(NLW_U0_s_axi_rid_UNCONNECTED[3:0]),
        .s_axi_rlast(NLW_U0_s_axi_rlast_UNCONNECTED),
        .s_axi_rready(1'b0),
        .s_axi_rresp(NLW_U0_s_axi_rresp_UNCONNECTED[1:0]),
        .s_axi_rvalid(NLW_U0_s_axi_rvalid_UNCONNECTED),
        .s_axi_sbiterr(NLW_U0_s_axi_sbiterr_UNCONNECTED),
        .s_axi_wdata({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_wlast(1'b0),
        .s_axi_wready(NLW_U0_s_axi_wready_UNCONNECTED),
        .s_axi_wstrb(1'b0),
        .s_axi_wvalid(1'b0),
        .sbiterr(NLW_U0_sbiterr_UNCONNECTED),
        .shutdown(1'b0),
        .sleep(1'b0),
        .wea(1'b0),
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
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 19424)
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
