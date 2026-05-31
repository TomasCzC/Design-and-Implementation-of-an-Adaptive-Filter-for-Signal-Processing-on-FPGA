// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2025.2 (win64) Build 6299465 Fri Nov 14 19:35:11 GMT 2025
// Date        : Fri May 29 14:06:16 2026
// Host        : TOMAS-PC running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               c:/FPGA/BAP/BAP.gen/sources_1/bd/eth_mb_system/ip/eth_mb_system_axi_ethernet_0_0/bd_0/ip/ip_2/bd_f264_c_shift_ram_0_0_sim_netlist.v
// Design      : bd_f264_c_shift_ram_0_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7k325tffg900-2
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "bd_f264_c_shift_ram_0_0,c_shift_ram_v12_0_20,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "c_shift_ram_v12_0_20,Vivado 2025.2" *) 
(* NotValidForBitStream *)
module bd_f264_c_shift_ram_0_0
   (D,
    CLK,
    CE,
    SCLR,
    Q);
  (* x_interface_info = "xilinx.com:signal:data:1.0 d_intf DATA" *) (* x_interface_mode = "slave d_intf" *) (* x_interface_parameter = "XIL_INTERFACENAME d_intf, LAYERED_METADATA undef" *) input [0:0]D;
  (* x_interface_info = "xilinx.com:signal:clock:1.0 clk_intf CLK" *) (* x_interface_mode = "slave clk_intf" *) (* x_interface_parameter = "XIL_INTERFACENAME clk_intf, ASSOCIATED_BUSIF q_intf:sinit_intf:sset_intf:d_intf:a_intf, ASSOCIATED_RESET SCLR, ASSOCIATED_CLKEN CE, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN eth_mb_system_Clk, INSERT_VIP 0" *) input CLK;
  (* x_interface_info = "xilinx.com:signal:clockenable:1.0 ce_intf CE" *) (* x_interface_mode = "slave ce_intf" *) (* x_interface_parameter = "XIL_INTERFACENAME ce_intf, POLARITY ACTIVE_HIGH" *) input CE;
  (* x_interface_info = "xilinx.com:signal:reset:1.0 sclr_intf RST" *) (* x_interface_mode = "slave sclr_intf" *) (* x_interface_parameter = "XIL_INTERFACENAME sclr_intf, POLARITY ACTIVE_HIGH, INSERT_VIP 0" *) input SCLR;
  (* x_interface_info = "xilinx.com:signal:data:1.0 q_intf DATA" *) (* x_interface_mode = "master q_intf" *) (* x_interface_parameter = "XIL_INTERFACENAME q_intf, LAYERED_METADATA xilinx.com:interface:datatypes:1.0 {DATA {datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value data} bitwidth {attribs {resolve_type generated dependency data_bitwidth format long minimum {} maximum {}} value 1} bitoffset {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0}}} DATA_WIDTH 1}" *) output [0:0]Q;

  wire CE;
  wire CLK;
  wire [0:0]D;
  wire [0:0]Q;
  wire SCLR;

  (* C_AINIT_VAL = "0" *) 
  (* C_HAS_CE = "1" *) 
  (* C_HAS_SCLR = "1" *) 
  (* C_HAS_SINIT = "0" *) 
  (* C_HAS_SSET = "0" *) 
  (* C_SINIT_VAL = "0" *) 
  (* C_SYNC_ENABLE = "0" *) 
  (* C_SYNC_PRIORITY = "1" *) 
  (* C_WIDTH = "1" *) 
  (* c_addr_width = "4" *) 
  (* c_default_data = "0" *) 
  (* c_depth = "1" *) 
  (* c_elaboration_dir = "./" *) 
  (* c_has_a = "0" *) 
  (* c_mem_init_file = "no_coe_file_loaded" *) 
  (* c_opt_goal = "0" *) 
  (* c_parser_type = "0" *) 
  (* c_read_mif = "0" *) 
  (* c_reg_last_bit = "1" *) 
  (* c_shift_type = "0" *) 
  (* c_verbosity = "0" *) 
  (* c_xdevicefamily = "kintex7" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  (* is_du_within_envelope = "true" *) 
  bd_f264_c_shift_ram_0_0_c_shift_ram_v12_0_20 U0
       (.A({1'b0,1'b0,1'b0,1'b0}),
        .CE(CE),
        .CLK(CLK),
        .D(D),
        .Q(Q),
        .SCLR(SCLR),
        .SINIT(1'b0),
        .SSET(1'b0));
endmodule
`pragma protect begin_protected
`pragma protect version = 1
`pragma protect encrypt_agent = "XILINX"
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2025.2"
`pragma protect key_keyowner="Synopsys", key_keyname="SNPS-VCS-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
CLe4hIBuPoGhpVl7WcpdPrkOqRB4Jx17xO25OhKMzcudPtO7fyzQcLT1Hwfd0j30ICv/93MrjmYk
VkhpZR9EpEAjIIkPAj6Uz1DaF5W+ZmnNsekRAyk+3Lm7DCkEdldRunmAMklLXDYSE0BHPyNZb6/O
1fVccxPwFw6jSpxzyJ8=

`pragma protect key_keyowner="Aldec", key_keyname="ALDEC15_001", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
ACw/whBd4sJPjEXsPWy+A9hsrulOjhl03yGnO0wIJb/8lOFB6tmCM94OcdNwiMaV6kg8YzX1Zq7/
NE2RxoRW0a7WAr7xvZPy265UGSafgRDCpO1KBNNkYutsmHT7D2OLTvT4FaHp5hZFRk+z43Ve8ygQ
YJTKyx5ivjb/80JLBvE8hnVCpYkZN6VnhMHuf1XLNa0oxWLQ2z+ODAbTE0KVd6D6DWycqrbcGtw9
RfO96KL4+hS2NraPUOWRVGCJvHh+C9oFURQ8sSL1vIHuy9U+A+C/triRYJ4Yl8X5mPDgDSLb9GaP
flIuoeMAprVt1E/Bi7vgnF6kuuRtRrRwCbGG1A==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VELOCE-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
WhGTCsy16/t+nTOk+CGv7tpQem4v8f0JcfhtmHJKBQmUKRgMWECn1vAxv7cTlF5fBXBuNPE5ekvE
eE5xvFBz6Hn8xUu09f8xFM1K5WhbovRkMP3+0G0ookHnjX6DsYKCCqav35emaqOkBS5JhVj2EBPk
XLtGUbRCypldy9j1hdo=

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
HTqbg+eKkopQi5dj/L+szqmPwRpBkCcaMjACO+UpXthtee/no4xSMcGn8abIY3SPv4TzrnuqqXPm
0AF2N3wLbDTLOGfRyerYPQtOSICnY0YK1FpPbRpt8J37qRX06v29OCgAKQCRzqcyktN979XHA61i
y9kXKs0ecYFb/aEJn+r/Ms4/zkik5QDSibn9rXgrCIaAq3oV/qy4/eOC1I7HxFJ7pQLvD6TaOwrX
4JOp3lWwPc+YVayAWfwfSM8th7MZKBhpSD1StLeBRJc4CJ5oDLwaMgHEFCXxx3pyxq8QdKSuHOu3
Wi8mjTwcR+O/8mCaI/EQL04GZntygGZa6NRnQQ==

`pragma protect key_keyowner="Real Intent", key_keyname="RI-RSA-KEY-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
o91QaUL83RhelLkEm4+751/SyYIekusmli7rQ/VnKAUITjkJaEGeiMiekUqrom206GlehlLCRUuJ
Qk6ai4cQrpKj2AErAd0Y5kUpeM5RS+aWpFjtOYrSHMdr4rMfgbsw35qJ6v9hjgJLVLLd2hyabIYi
/IO+Syqy221cIW0MUUpzoOJ9CjxdiirdkOfTk4p5NvXD0hVLjTWo5izC8MmrhTohoXTCLeDPBtni
h9yjKz34xbfDJ73edDWDKZuzkcksNcD8JDufI8TXjti6zIBBimw59rFhS2J51ljYPnYfZPiVePJ5
N7uOtLgm5YB9EYVkYBImzlegfvfeWKMlMPTN2Q==

`pragma protect key_keyowner="Xilinx", key_keyname="xilinxt_2025.1-2029.x", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
lJKy9Zjha63A0h02ApuEz30etxi10kyaT0MM37kT8C079RoQxr/jzSdPRVB6DZEoEoxq3B3ZtFpY
YjPONLB3n6tCjDMSDQ3C1I1mBthQK6OvvTRuHUxb1l9/aLvQKKbftHNrYBApn8VpMjP6CLucAxZp
+odccI1IV35j33TcUjek8yCrtxEmdzWv0t5wOEQA4WTFVG1fU6/a+jfGVGHnhJhasL7Jl0YilFPM
HWd3rJlyr2xUSar0v6pd0AVRt6yFuPoCpA/gavX0kZRv+AugezxEfo89yWvJY2XTRZkZi3hMrZuv
vLK4usOzcbsPeMWzlO01N6DMHirnppE7yicsAA==

`pragma protect key_keyowner="Metrics Technologies Inc.", key_keyname="DSim", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
qZguQpkzQaubvif4ozJshLhSpVr4NjQRAvIToSXk4wKAhLoTGGfhff6h7uytylGeHmy/9jn719Sv
HAjAigAvx8FgkAdQ9HshMaw6B/CLhf7qqwtfgiEb8k4WEUmEBTliot58LPV7jCEMD1VBzZWYR4K/
F/3P7X3moGjkrFh9KcmMY5GwF7k9LuqZmEI6DK0O8ZCX0hTQnQ2olSPRWHDbVMSNk21ob6q2E7m5
xpDVITSJEGo0sugVShTUXPzIS2aLKbIkU7M7Hafar7cSxwCvM01LmXbK2kk/TJ1BnxjpTLKgqxru
qHGOZsfM5HZn/M3rQKeaLTsgoxJg0TzUyDcG2Q==

`pragma protect key_keyowner="Atrenta", key_keyname="ATR-SG-RSA-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=384)
`pragma protect key_block
hKe8IASictRpxK+UNDyBjdExv+cunUPc6ZpI+7czTzAehV4HfB+YDHOd05j6V2WSrIfjaa5Yc1RS
G3r38XeIaYh1ZL1ZSXdIVLclvWkAD0ZTUVklwYY6ca20tDHHAciXUrro3jg9kGe8H2Gojjw+VQZC
vGGdV4/DF3pjMdpz4nyJJWNfnYLPmx19+G3AsjJsk77LkeQJ3ac7KA942yZdeDmv4Gv409a95Tsb
ybgnN5fxmPfJ1KacG4k/Zu07i7vPA7/85FRrgptHJL0ytlZgmOydqGwz345i+KR6+tR6P3ZfO0s6
zos96acnjsr2RnP6pIJ30EKJj+IMY98YqW+6wBHZ1tOwA0LCIHrVhIyGe0B5IXV4RAxNY/K/8cZ4
j/W2apPE52Pk/hvYFtfyEVf1mS/lGq/t2LznNsZMt82q93Jb8hxwC6Zd8lrmm2hfqYfOAmlZmf6O
EfYHOP1GurKAmfr07eaBzMSZGJa/fC0AncpmpYD7OL9jcP2lP5UBi+qa

`pragma protect key_keyowner="Cadence Design Systems.", key_keyname="CDS_RSA_KEY_VER_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
HO+y/HjEaXV9is2kIeddm5ja325WYl9z3UGUIfNECIbhm1CsOvhNxo06AGFh3AtmMj1fkyl7FpO4
5p6qJPGuMnf7KaoL2lbPdT1FmXinUUneD7TyneDl5s/cvecL9iNEtBuembSpR8uFQlqW3j5MnIU0
UISBysTQ8EGO9RDHkRKXJVBUPunFpCoxViEHDwuLeOfZnsSUNCm1TQkVN6lCJVpqMXGrell2v+/D
+BJWT6gUeDiXDTY/zYKkdaf1QckERhcVJjNORVmQDjxTeDa6GJ1AmksSzrK2M3vTp9axAcWS5ak3
FP7Oo1kxa1CXdzBltgltp8wxugADWHbPbfb6Kw==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 2112)
`pragma protect data_block
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
9YmP
`pragma protect end_protected
`pragma protect begin_protected
`pragma protect version = 1
`pragma protect encrypt_agent = "XILINX"
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2025.2"
`pragma protect key_keyowner="Synopsys", key_keyname="SNPS-VCS-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
CLe4hIBuPoGhpVl7WcpdPrkOqRB4Jx17xO25OhKMzcudPtO7fyzQcLT1Hwfd0j30ICv/93MrjmYk
VkhpZR9EpEAjIIkPAj6Uz1DaF5W+ZmnNsekRAyk+3Lm7DCkEdldRunmAMklLXDYSE0BHPyNZb6/O
1fVccxPwFw6jSpxzyJ8=

`pragma protect key_keyowner="Aldec", key_keyname="ALDEC15_001", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
ACw/whBd4sJPjEXsPWy+A9hsrulOjhl03yGnO0wIJb/8lOFB6tmCM94OcdNwiMaV6kg8YzX1Zq7/
NE2RxoRW0a7WAr7xvZPy265UGSafgRDCpO1KBNNkYutsmHT7D2OLTvT4FaHp5hZFRk+z43Ve8ygQ
YJTKyx5ivjb/80JLBvE8hnVCpYkZN6VnhMHuf1XLNa0oxWLQ2z+ODAbTE0KVd6D6DWycqrbcGtw9
RfO96KL4+hS2NraPUOWRVGCJvHh+C9oFURQ8sSL1vIHuy9U+A+C/triRYJ4Yl8X5mPDgDSLb9GaP
flIuoeMAprVt1E/Bi7vgnF6kuuRtRrRwCbGG1A==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VELOCE-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
WhGTCsy16/t+nTOk+CGv7tpQem4v8f0JcfhtmHJKBQmUKRgMWECn1vAxv7cTlF5fBXBuNPE5ekvE
eE5xvFBz6Hn8xUu09f8xFM1K5WhbovRkMP3+0G0ookHnjX6DsYKCCqav35emaqOkBS5JhVj2EBPk
XLtGUbRCypldy9j1hdo=

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
HTqbg+eKkopQi5dj/L+szqmPwRpBkCcaMjACO+UpXthtee/no4xSMcGn8abIY3SPv4TzrnuqqXPm
0AF2N3wLbDTLOGfRyerYPQtOSICnY0YK1FpPbRpt8J37qRX06v29OCgAKQCRzqcyktN979XHA61i
y9kXKs0ecYFb/aEJn+r/Ms4/zkik5QDSibn9rXgrCIaAq3oV/qy4/eOC1I7HxFJ7pQLvD6TaOwrX
4JOp3lWwPc+YVayAWfwfSM8th7MZKBhpSD1StLeBRJc4CJ5oDLwaMgHEFCXxx3pyxq8QdKSuHOu3
Wi8mjTwcR+O/8mCaI/EQL04GZntygGZa6NRnQQ==

`pragma protect key_keyowner="Real Intent", key_keyname="RI-RSA-KEY-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
o91QaUL83RhelLkEm4+751/SyYIekusmli7rQ/VnKAUITjkJaEGeiMiekUqrom206GlehlLCRUuJ
Qk6ai4cQrpKj2AErAd0Y5kUpeM5RS+aWpFjtOYrSHMdr4rMfgbsw35qJ6v9hjgJLVLLd2hyabIYi
/IO+Syqy221cIW0MUUpzoOJ9CjxdiirdkOfTk4p5NvXD0hVLjTWo5izC8MmrhTohoXTCLeDPBtni
h9yjKz34xbfDJ73edDWDKZuzkcksNcD8JDufI8TXjti6zIBBimw59rFhS2J51ljYPnYfZPiVePJ5
N7uOtLgm5YB9EYVkYBImzlegfvfeWKMlMPTN2Q==

`pragma protect key_keyowner="Xilinx", key_keyname="xilinxt_2025.1-2029.x", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
lJKy9Zjha63A0h02ApuEz30etxi10kyaT0MM37kT8C079RoQxr/jzSdPRVB6DZEoEoxq3B3ZtFpY
YjPONLB3n6tCjDMSDQ3C1I1mBthQK6OvvTRuHUxb1l9/aLvQKKbftHNrYBApn8VpMjP6CLucAxZp
+odccI1IV35j33TcUjek8yCrtxEmdzWv0t5wOEQA4WTFVG1fU6/a+jfGVGHnhJhasL7Jl0YilFPM
HWd3rJlyr2xUSar0v6pd0AVRt6yFuPoCpA/gavX0kZRv+AugezxEfo89yWvJY2XTRZkZi3hMrZuv
vLK4usOzcbsPeMWzlO01N6DMHirnppE7yicsAA==

`pragma protect key_keyowner="Metrics Technologies Inc.", key_keyname="DSim", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
qZguQpkzQaubvif4ozJshLhSpVr4NjQRAvIToSXk4wKAhLoTGGfhff6h7uytylGeHmy/9jn719Sv
HAjAigAvx8FgkAdQ9HshMaw6B/CLhf7qqwtfgiEb8k4WEUmEBTliot58LPV7jCEMD1VBzZWYR4K/
F/3P7X3moGjkrFh9KcmMY5GwF7k9LuqZmEI6DK0O8ZCX0hTQnQ2olSPRWHDbVMSNk21ob6q2E7m5
xpDVITSJEGo0sugVShTUXPzIS2aLKbIkU7M7Hafar7cSxwCvM01LmXbK2kk/TJ1BnxjpTLKgqxru
qHGOZsfM5HZn/M3rQKeaLTsgoxJg0TzUyDcG2Q==

`pragma protect key_keyowner="Atrenta", key_keyname="ATR-SG-RSA-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=384)
`pragma protect key_block
hKe8IASictRpxK+UNDyBjdExv+cunUPc6ZpI+7czTzAehV4HfB+YDHOd05j6V2WSrIfjaa5Yc1RS
G3r38XeIaYh1ZL1ZSXdIVLclvWkAD0ZTUVklwYY6ca20tDHHAciXUrro3jg9kGe8H2Gojjw+VQZC
vGGdV4/DF3pjMdpz4nyJJWNfnYLPmx19+G3AsjJsk77LkeQJ3ac7KA942yZdeDmv4Gv409a95Tsb
ybgnN5fxmPfJ1KacG4k/Zu07i7vPA7/85FRrgptHJL0ytlZgmOydqGwz345i+KR6+tR6P3ZfO0s6
zos96acnjsr2RnP6pIJ30EKJj+IMY98YqW+6wBHZ1tOwA0LCIHrVhIyGe0B5IXV4RAxNY/K/8cZ4
j/W2apPE52Pk/hvYFtfyEVf1mS/lGq/t2LznNsZMt82q93Jb8hxwC6Zd8lrmm2hfqYfOAmlZmf6O
EfYHOP1GurKAmfr07eaBzMSZGJa/fC0AncpmpYD7OL9jcP2lP5UBi+qa

`pragma protect key_keyowner="Cadence Design Systems.", key_keyname="CDS_RSA_KEY_VER_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
HO+y/HjEaXV9is2kIeddm5ja325WYl9z3UGUIfNECIbhm1CsOvhNxo06AGFh3AtmMj1fkyl7FpO4
5p6qJPGuMnf7KaoL2lbPdT1FmXinUUneD7TyneDl5s/cvecL9iNEtBuembSpR8uFQlqW3j5MnIU0
UISBysTQ8EGO9RDHkRKXJVBUPunFpCoxViEHDwuLeOfZnsSUNCm1TQkVN6lCJVpqMXGrell2v+/D
+BJWT6gUeDiXDTY/zYKkdaf1QckERhcVJjNORVmQDjxTeDa6GJ1AmksSzrK2M3vTp9axAcWS5ak3
FP7Oo1kxa1CXdzBltgltp8wxugADWHbPbfb6Kw==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-PREC-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
a1dQzLZM79vU/abNh7t4jZSdgVh2ZSVmUMzaSAa2woxY7leYi3O9WWCwv4v6D8FmGucixVs8tXMb
tVd3k6G3nebzC7JM2PRhl2trf/mHZ7s9D1ifSc3jsxoFypdzQmn65msoYFk5dXjIVP0sNbM+iKdB
1n3Q5YpSwtDbDk1U33GJ+twOhjyH+MMpuGocaz4htKzBWpRy7Ihh0raESf+CCcr4OVAijzZNUBjA
ZkyS3+0ifnzC4cyC7798KO+BVgqXCzaJGGUuXYKgEGkeo11l53hCTFCH4tIjkAf0EmfoKtcv+FqQ
LC9vXHUvaFvLXESO0bZag8J1U6/46yNbxPKFUA==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
aqXESHRqYpWjVr2vibZe8998ZykuwxeM3rDSkLLY9pKjHaFN9QerDVHta3yY1FjMAACm+Bsl6reh
fp6NxTJ8lK4ECSUGrs6eibLXWOTEbHPTaOY+1tHqh7WilvaObQb2qk+ZeibCyZcRhqSEQcEuJB3v
Ke+DqjK1UJEMi4v6/wFJK/2FDwRBuQAIq4DjGvjLueLCSrpU22wZPbmJKNhEnray1aq2zA4eNXyZ
R7FYf9w2AMuRFWqBsQQLecd75K0NP7W0iG00LrImCw1b8vOHkAp3vtV8SIhi9s0GkqsnvthNKk0i
TOETThXOmQzlfoYayiq9cvolKlD2DEDEjFhZYw==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 4128)
`pragma protect data_block
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
xNoELLq9EBWjPseXrhjqj5jxc3Idn/Uz
`pragma protect end_protected
`pragma protect begin_protected
`pragma protect version = 1
`pragma protect encrypt_agent = "XILINX"
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2025.2"
`pragma protect key_keyowner="Synopsys", key_keyname="SNPS-VCS-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
kHy+Y47DINMZBhGNJbO0iBu5fVXE7Bat9jgQLXk3ApvDPiebCpuM+E5t4isjIrxk2pED5TFqGGjD
mw0Zl0QfJTPovzyVpseGM40QVknZr+EDIrYMj7MVpgkj2ATuN1iy+Nvz6YtW2/re2ZVUKd6KZ9d8
ZtkYbqnhbmtJvfKBuWs=

`pragma protect key_keyowner="Aldec", key_keyname="ALDEC15_001", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
oLBB7WjlXxTNC/15uVtlqQWkjFXnw2HhPVZvddpi3xRaQMsDccDqLfppjYQKjAIcwmx7UL8nX9jY
IuK3hz1RJf4dbfla93PDLCBX0aBk1An/KOdlF5Y2TESp6lKREaIJfFXCI97OHpK8TjQwYuZoQV99
GsFHmrMDivoRCnKLjoigNPr7kEh5GqRxEv0UVBK8WHXxTGiQ1CyZlbP20JQAlu+UoIyMH8ApnVoz
DVwsg03AShhecQZUG5iRxEWHDVHs5fb3KKizCDD3/EfafrHbHtMnAqPgH2nN1s+BFXtP7TF5/hFD
qU1Ymhv29UtMA60XTB8yHMh1NgXgIXuHufwL5w==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VELOCE-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
GEDYfV71I6d6lkWSPwWnwRMFU08ya6DZkuVnXtOutPMhJChntd1/vc9kECfYi2KBvIBB0KY9mK0F
VVb7ncucTInd+CA0EOHy4byn8cmzcH5ZZ51CtQ7HTAaQB3qezzk7OVsf32GI4pmISA9nMv9Ei1/N
Op2zFMirBwUmtO4zOXE=

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
J2XHxL/aNfHVxeXSGgWDhegnTdxNShyVq/iRBtxw3hm6pL7DKSyIHRbUPprtmrPtX2nXp7yTakn4
BCxiPJBw+X46vD4bsAXhGnCruqz3KEdSiN4+FDm7mJv/I4sWq5OTTfqlwQUek+Anzt6HVF6ckXBb
y5MccqJ5DVzQqWOzY2wwG5+TlfQNx2e2JM2deG7oLmYp3DELNQ3RryYN7nuBCCnWwHc4KWsc1906
UzkhU7SsF8ytKjcYN6AMxPy4bVVCvUiWR5YFpfw5l2kiBh49qYby9jxAoxBMwFYMC+ccRsEQ03lu
UnQcBduhh6L/VMKwKw2qCM0TCvJIkVGHPHR/kQ==

`pragma protect key_keyowner="Real Intent", key_keyname="RI-RSA-KEY-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
fS9WCZa9K50yTZTU6ExyBapRGcZ0+zmberI1FYlt/fgkAL7pNM2/Go4tFAaupyQPgNn22v1mgjJV
CPKy62gJu1efpHSSdAwUcDPojjg0YkFXp3DDReKmcBNxpzbRGtVTTm3IZMDr4EHOUe3Pb6CAGNJR
cxo5je2OB9ZUaCESQRtOrpc2zfvgYffOqApZFokARfrSLkRUC2IzACR2WgKQWmzUqVvOm9XmZTDj
H5i/etuHde70aAvE6YUXgdGXnFJ9FR6gXZNdzlVhVyMBiNZwuSATaqZsVrgubBVUpP1gxrNpwGkV
GDFWHKcVdIUHe7BMy9IM1ng0XMymvhkVELF9sQ==

`pragma protect key_keyowner="Xilinx", key_keyname="xilinxt_2025.1-2029.x", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
Ml7FaGUhDI/BqFBOFzOS6wgTc7xx7F6mWr1x5/CWragDKjkxHDbnJVKM/Ydf+IB8pSXvXZklVaaQ
q3kxNA17gYDRWk0FmI9tWH1fiRNGiBXnKQeYpM4HfEbT8NB1//lJha92YwoKmWh6Y3RWx8JhIsCi
+4X1I54kJ4D1xB6KFvJ4D7xycdimb/o66RhypZ+WMbYahY0/xydPHW3mk0zh6mZ83yM8L9Xjdkjw
bWtG1WslwgKBzlBrfiHcncf9zMmfvnveJVr+Wv/kBYvy5NGpgqdBdiawQtfUbHJwzBdFK3wxNG2E
xmHQ5xv7aQ2Nyw8nNkxkT3m4vU2C7TZ6qRyjjw==

`pragma protect key_keyowner="Metrics Technologies Inc.", key_keyname="DSim", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
ELO0ctDLZ0o98clSrqFoG1nFfVGMDJ3FREqOInAEP7ODoIivkTOcRLPCHmSCxeiAf7B+QgXjJuuM
faX6xG5bccwKm9a1pAchSX/uUHgdUeHJH44Zn9Jg/JAyEnq1vpmj2oL0Lq62HcqcBfAhAtbBs8zy
QAVQOl3nJXmk0xYVtXsUEVed9dGAdJum3ysmH7s+YgmKrTgSDPOba4CHeu3h5QcqsTya2jV96rE4
+o1LyVig1eweAr5FlV8aexfmhQgkqeR7uPVfMuYq//zp59F6b9AaRLxJ1fO2iM6NiIj7BXr4wPRO
64PoDvI9VzJkyQbbwBqs8gF6eFpQyW9mHrw4pA==

`pragma protect key_keyowner="Atrenta", key_keyname="ATR-SG-RSA-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=384)
`pragma protect key_block
cPihq6JpepZTejaIN4Cird0q6KMxN96pxR9FpKYeg77sMgppvqi2iMYVMGL4QqW4xYjHhFWOX4rv
IcfbuSEQOaeIEA208PxDDa1RrQyIuFjq56SwtmTZK9c3jNBQYqnHSki2OQ1DXTLL3VUtIyi7kVHO
AlekEP8VaWmKQ0s5ywnst0V+b2iNwQMnin0oFY+z51vVg+olzOxEUJlxFWO7QTtdIZS7PuTvSv2O
p4WLhDmEheW7uPlh4H3VzvQJPqPTEqDArPU9t3nSIpdxBq/ZNx5QDqSPD0gbFIQCdmsKjJwKXAd7
jvlB25+m2TdkZMAIbYyoBJzKF4Wm11Ahde2iMp1E6f5A+bzSZN89umBbvS525wGBpzFKJRyHYK/R
IbuMOP0NVM4mM2csrfERqG2lyTkxs0p5RaUmguXT1XzhSIk0On8TtbcxkmQOgaaNImM0+WEqo0vs
YAwh+bb7iNwtJdtYXjYn50wyodKtl2I3s4B8pQY0EsYsaISHiC5y6P4R

`pragma protect key_keyowner="Cadence Design Systems.", key_keyname="CDS_RSA_KEY_VER_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
m3x5WuABRT/NmnZ2viwwkr3V40yMnUOKtg3OI3r9/YQ2HTRCvD1ljzo0Wv9JF3DUSG1QgzT98R3c
tg0essbW899h1QMI/ytrpWA3AFGmKKUjHm6wP8MFp9hPjb8niaVAagToGm8M+GJ/IriyvIIH/HQf
59wnTZsXfG+YoX8UoH0ypVGELCGHEbVHj5QA8scWWDSxt80Wql6+brc90u6QtjoX0seTGtx3VM6K
7J5amowIujwCVkTO5jEhVWcBAtO44GJdkBzoAcVokIXoJp367RP3sN0NIyXCNe1g7gUI5oMeTNX8
s5diylN/nTYboy5B4LStwAHIWtMExnjNY/hFnw==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
TfOoUYxi/XxlfrXW2akpmf1EH4g8XYaU6GynvHek7xPy8RiV4aGIQ773tGHMP65O3RYycKUlYXg1
Fa6/SN0yKIYNEKhYBJmbFHbMU4SpIxnaZWTZa9mBF62WaybG3U6dlRlh2Gfkuidp/zLYfAynknof
Ngj0UTBnzoWW3JLbT3XT0eYY5/pnJJq/m08boxB3bC+F44Q8XvOR1Hi1tpKOF3jm54pQ28KXvjK+
SZWdX84vYwetgrpQBbxEUIfmy4nISyWwSwtMIRIcWgJMUY0R11HDkKc68vUcIxiO9s343ArSdXjQ
tyyEkkeeLuytSyMNC7TG95B18++RFYqo7YIM7g==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-PREC-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
gelvD9OuDLeuKDiEVGVyMb6/8XPutjmyrxdteHV3WsIUSh54NoD2y/q2HQkLEGlRnp4Gqw4DoKN7
pjf9IdBLYZHDR8ZEE+wORlm8apGgDlupWV+qNlgrco4rnUXT0AXX8dJpPxkRZUpZRE0IzoHgWAyc
+Cp/MBX+UQJZSf8+QSZ7xA4ZoON0HofM1Cy6Yjt8nrZD0Bn/J2YutQiu4B+liv/48wr+DWB8puBN
8YPrIGY67jvbXPyWMclsTHeXpRIFVffd/xBKmLCyb5M6xvLsoyXxCcWBu2ZfCuzRF5mJdN5jabiv
j42PmKBoWi6SNs3QQp0KWw01Ost4beeWb1T0NA==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 752)
`pragma protect data_block
2sHGmlcrGzkx4jWlbujk2ADGFMu+Xojq+wwRqWLw4Knlsg3D54pJc67AMGAd2/LWdIbpIR6zy6eg
e9Q190dbofKZVt6bFY3Ut5flgtaXCsxIlZuwcQRnNHiwtyqcTzE6m/wRbP9UolzDYYtqS2uUJkRt
wJtpebjqzac19gg9pt7n2BOUQOSpQ8hwX++WjQxsVeCYkqDAW0oDphWLPORkl2FQ6ZVKV/yrGIP1
1v2Edgacj+klE+3M2cO36KGPMLVwGasCNfC8H9EKp/2OTofauoPrJimTdSZcDWdRBX3jFIaUcPmp
bwQmyMZLQqR4pnGMVrTFTy/mvSKr36iGPBpip6TsMsgE54+/jVlMaWvnAC35h4pGPTAbqoaX/Uoz
UdczCcTCgpmrI/N4eN9jZtFx8dejvGcnz8QLGIP7M4wIV4NxXq3KBW2TWZmRZC39CH0iVUqvrZNu
Z64RDagekPfg307TdKixYA925IcNEP8rGuQre63OfDVF8BudlM+/xykhefVdtzDq+a3+rhh4Jj03
qpS6Srp4IQxXcq80gCU+/ZXcgX5PFD3DaHfoUFSPRhuXPWnGZoeDUifPM8pXqLNVrcoDgs9+/GMB
egXbUP5Ac0DSz0CWMLtwoBlEjo7IM9tmCpLj8KjFUa5GzQ+4AoryIHUEzwQSD/osMbZVQOs7ximY
xnQ6VReVDUqbyNXV/QNgt8M/MWtnheQfTaC0jCoiNI3VAbGD45Oj2gjeB+oz29Ps7rD5Pf+Jj1uV
io6VTqAGk+U6xLPgHDXEzjHoIU5qFuwlmPPu2MlIIv7gFjLLM7Uhb62INYZkuBwWo4igweHROkEZ
Pv1WRGWaM6ZthKGSo78XTBUJn98n4WAZ7f0LIr8acB4j/MHLjKbMSQ0tmSbmIQ9gbhGBYpKIBPrt
5iinBZTjEv9fkL0g3kocPa7WcJ36TMXTjC6HsrfWUzgiQ9zShbpqbiwI9SGMkixGo7Txd1Q9N3Ze
5ASw1aJqqRPrE2E=
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
