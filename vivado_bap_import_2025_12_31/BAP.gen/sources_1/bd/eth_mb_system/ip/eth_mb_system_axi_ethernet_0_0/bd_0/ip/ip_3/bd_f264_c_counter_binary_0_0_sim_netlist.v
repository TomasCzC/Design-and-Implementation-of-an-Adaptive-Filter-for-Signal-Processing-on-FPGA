// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2025.2 (win64) Build 6299465 Fri Nov 14 19:35:11 GMT 2025
// Date        : Fri May 29 09:57:35 2026
// Host        : TOMAS-PC running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               c:/FPGA/BAP/BAP.gen/sources_1/bd/eth_mb_system/ip/eth_mb_system_axi_ethernet_0_0/bd_0/ip/ip_3/bd_f264_c_counter_binary_0_0_sim_netlist.v
// Design      : bd_f264_c_counter_binary_0_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7k325tffg900-2
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "bd_f264_c_counter_binary_0_0,c_counter_binary_v12_0_22,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "c_counter_binary_v12_0_22,Vivado 2025.2" *) 
(* NotValidForBitStream *)
module bd_f264_c_counter_binary_0_0
   (CLK,
    SCLR,
    THRESH0,
    Q);
  (* x_interface_info = "xilinx.com:signal:clock:1.0 clk_intf CLK" *) (* x_interface_mode = "slave clk_intf" *) (* x_interface_parameter = "XIL_INTERFACENAME clk_intf, ASSOCIATED_BUSIF q_intf:thresh0_intf:l_intf:load_intf:up_intf:sinit_intf:sset_intf, ASSOCIATED_RESET SCLR, ASSOCIATED_CLKEN CE, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN eth_mb_system_Clk, INSERT_VIP 0" *) input CLK;
  (* x_interface_info = "xilinx.com:signal:reset:1.0 sclr_intf RST" *) (* x_interface_mode = "slave sclr_intf" *) (* x_interface_parameter = "XIL_INTERFACENAME sclr_intf, POLARITY ACTIVE_HIGH, INSERT_VIP 0" *) input SCLR;
  (* x_interface_info = "xilinx.com:signal:data:1.0 thresh0_intf DATA" *) (* x_interface_mode = "master thresh0_intf" *) (* x_interface_parameter = "XIL_INTERFACENAME thresh0_intf, LAYERED_METADATA undef" *) output THRESH0;
  (* x_interface_info = "xilinx.com:signal:data:1.0 q_intf DATA" *) (* x_interface_mode = "master q_intf" *) (* x_interface_parameter = "XIL_INTERFACENAME q_intf, LAYERED_METADATA xilinx.com:interface:datatypes:1.0 {DATA {datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value data} bitwidth {attribs {resolve_type generated dependency bitwidth format long minimum {} maximum {}} value 24} bitoffset {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0} integer {signed {attribs {resolve_type immediate dependency {} format bool minimum {} maximum {}} value false}}}} DATA_WIDTH 24}" *) output [23:0]Q;

  wire CLK;
  wire [23:0]Q;
  wire SCLR;
  wire THRESH0;

  (* C_AINIT_VAL = "0" *) 
  (* C_CE_OVERRIDES_SYNC = "0" *) 
  (* C_FB_LATENCY = "0" *) 
  (* C_HAS_CE = "0" *) 
  (* C_HAS_SCLR = "1" *) 
  (* C_HAS_SINIT = "0" *) 
  (* C_HAS_SSET = "0" *) 
  (* C_IMPLEMENTATION = "0" *) 
  (* C_SCLR_OVERRIDES_SSET = "1" *) 
  (* C_SINIT_VAL = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_WIDTH = "24" *) 
  (* C_XDEVICEFAMILY = "kintex7" *) 
  (* c_count_by = "1" *) 
  (* c_count_mode = "0" *) 
  (* c_count_to = "1100000000000000000000" *) 
  (* c_has_load = "0" *) 
  (* c_has_thresh0 = "1" *) 
  (* c_latency = "1" *) 
  (* c_load_low = "0" *) 
  (* c_restrict_count = "1" *) 
  (* c_thresh0_value = "1100000000000000000000" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  (* is_du_within_envelope = "true" *) 
  bd_f264_c_counter_binary_0_0_c_counter_binary_v12_0_22 U0
       (.CE(1'b1),
        .CLK(CLK),
        .L({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .LOAD(1'b0),
        .Q(Q),
        .SCLR(SCLR),
        .SINIT(1'b0),
        .SSET(1'b0),
        .THRESH0(THRESH0),
        .UP(1'b1));
endmodule
`pragma protect begin_protected
`pragma protect version = 1
`pragma protect encrypt_agent = "XILINX"
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2025.2"
`pragma protect key_keyowner="Synopsys", key_keyname="SNPS-VCS-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
RBTstJ7XWxZjQjwGcU/JJ2RAGa5J326RJh7NxA5qgBfK8BeXJA8bc+WOsvdknG8/riv7QAgHCnpv
7p09aXC2G7icYav/fCTOhzyvJZ1HWj3IGddakdkXukJqFtmZGxR24k14s0BkSIPogeAfNyaHKePA
r2D3JzayR7arvFzOmjk=

`pragma protect key_keyowner="Aldec", key_keyname="ALDEC15_001", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
Y7nsQqW9jRG/Ue1k55uCDPMbrsfZ0FDCdbInxNxFZ2qJhs0eVmjuSFiOrx2L8Ppd1Db4WerjLrUL
/iwyDc1UXIidgvRE/MKTHWyywfLOtUV7mBiFvKnSmjLLV1JI+wvvHfZpT1pG4dVKUQ4JjjooL8+F
CtCw2W5CaNK7GJ49445TfQInznm91k9rGaSiMBkfiqF9GF7491ShVSMjntMj9WpVpaD7px52cIFj
sE/ncmfiBaB1LClBL7mcG84IZvgyIuYO6x8rHP3ynVAhTZ6V1tQLQaoBvhLd+AMSR4lfmJfE4Wdp
DNJ9mvI4vGVFl6t0vVkac37JxdYKkcgnygEJTQ==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VELOCE-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
Vd8aib4ocNr7cl0xSwF63dKh44QCVdZr3BSRdYiod7MHgBmVMG71W6L0XJAsunnj8RlqylbNzuzj
MnpBkN+GopNfpF5qqgMfv0RCnuqnpb0Odat04JqFpXqHs7MChKYMiCgwfIO3d1tXgJeYa84KjG1V
nNjxsnrBYlaAkUVii78=

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
ANlFU/8fd6EknBXiroECf69h9cF5DTbM3V1TQV1mxRmxWYsbe6eoUF55OsWlmj93ySuMZIDEcLOq
s2KHP7T40A9qfJf77P3L9AR62AKFt/6JujXquNDMl6Cw+lgNmvhsBpbirEZKiy1Wi8rT30Hf70pD
Y9SVh6Q9QVKaquH0ETustnEPFSJaWFMn4D39aBjMBuzxNaw5lwIOSJYxOdqrtO8ehAapdUn+gGqd
6pSgPXxyi4lk/YYp53LMJ10LiHON9fzzWGz5TQ3N56E97Fdt7OB1EZuuoFhd31YidRNfkHiFy5nf
4w4lIxGVIqjotV6EgFmhPIi6uEjbl7+qYUKzEg==

`pragma protect key_keyowner="Real Intent", key_keyname="RI-RSA-KEY-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
ipVsCss9z/m2osfru3/H0vmygcHYzfd+o8Hf1Vkzz5dVaO0libemiiZALSdKT4ZlW9JmexafIicl
tQIBcuQGIHD6EORT/Hs5f8qV/JzKcmVLfmbp1a4DVOIw9LiHeBYn4FC2kcqugvDUNUW8OoTNkZgu
zIcasKPrreubU9tLrEhh8JnV2i3DZmzs5dh24yg16MjNncMHbIzzCLRoej1uVksKuKxVeiBbcbMy
zvnpJ0BBQiwmjhC3ch9ILVRQTUrYXM5ph034H15Gr7xaP2iviEdkouYSLjml/MLVu5dn4W6CHVT4
xU8aushvCJ7tFbhTk8Z3+eISN41ItvUteAMW8g==

`pragma protect key_keyowner="Xilinx", key_keyname="xilinxt_2025.1-2029.x", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
djPXjFANy4PV94UZvyALTuKASFkkNI1pN6NVy51W/G82pM+x0GE8eHMmIrvM+QEzW2TFMYB9Dg41
huQCivdNy19rhr7IQkJ8EdT26yJpp1/JQLMOxuV0ExLvzBc5+KgkcGGnQHi8OzkrJxSJ8s+aduIE
cqPETnCWwCwpg9jrMXHQfdG1lechwExg7q/FBeCc2aa3y95y2vb9NQgV/S1XyeZi0vb5x3YqTJCy
amDeqrtKyCjYbo3/uu8WudcY3tF7mVk+Q4Eyy7At1JSFNQ46szdIOgZnfdZIufGJdYSzRVjFIEnQ
Gni0uUxQpiaXucXBzTBQ+OwZpl4F5JKHKj8VZg==

`pragma protect key_keyowner="Metrics Technologies Inc.", key_keyname="DSim", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
WH7GziurDhUnenCg89cHfpFX8Jcxd+rWEPO/1/FCZItpiQ8gdJL3VcY/hPTS6f0nJGwGh//ljWC7
e7JYozerXnZ3/SeL2g4dDdO1PbsNpFp3vIW3Rt60muxtkcGMrQA/W45g/heHztPuq1KBOlfwqwlj
mohwFcuFV3TsYcRpFIVN8WXH6alITwAX/alkf00l0AEdabMBUPPONAXgmGglvePrQE2cti2F/iDZ
uZghRKFiJILy1zf3NAaLFoSd677m9NlDe9t3nJnPFn7upedW4dLIe6dywS2NQuX9mi8ew68urtQL
w6hOX8cGzZGP9BBsxhrUNnPSyFNy6aGKh5pv8Q==

`pragma protect key_keyowner="Atrenta", key_keyname="ATR-SG-RSA-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=384)
`pragma protect key_block
FVDqjRs9iZJWCTbX/pW565JM41qoQ9wn6l4s51L4T/zQsIvUAEHqYYYGnmJf81hCdQ5953xq0HUh
gatOmd3EyfPKFvHnwyCdW+QGbtigkSc2O3f44PTpzp09VRfEVhLIa/3FcMyPwD+3ZzUvMG+Mrlgc
zUuTtOYF0U7vmi29KLJfxO9Qg/7jqbxYadj3CDFpavYFVUuSERgj84+IyX4TMa9HK4V74vfrTcse
N3Cx2hGPpvvb6W/twbYkFK0aeikVT1JRA35izGFjcLMdKy+eQBVSR49wimCcDbe82riHRhodFTM9
lk7RvCbCktXU+8hjpjZWPIzByBLeqLVtdkRgl3iQb+kmmCiJGjc/ipHfQV1dcbvwoJQzj12ohrn4
9sInz+dNnCAMUK2VZuDkjhJl3iyocscyfkIKicZDeJKxBHAHoqZsi3DXVYXtbv7JthD6XHUFGSaI
0S1NxYGwGEdXpbJlkLxcDtk1gJx3k8xXtoDCBjXt5tjSRtgWV/qkyPmp

`pragma protect key_keyowner="Cadence Design Systems.", key_keyname="CDS_RSA_KEY_VER_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
W/9CoopYBhSc0VJur0ZkfBasc7PqUWj5h8OyxAFdhG5S8p1/zIOPtqnzupthgCFiVZZ0mJ6mPo08
yhAbUShntZWeFNPStaIbB/9xlXn6xWhK2UUxhS3DxpZAG0Ur1jiL1ctxoPYKx46vTRYBHZSzF71Z
IN++zvuC6j27ccU3SyvPIAqC95gfw49eeGimTtEDh5m/BnVTyQ3ydd2vfZFiIp+JTfWKczg9fPdZ
bUsWHRk74SAICMg3xqzHioz2b3MIXFd5ApTUXLdBos3DXu5wCiXrmvtJbXqdZx3Xgv0KgkMmCRjp
FXi6pKifZjNO0Zu1c4IPP/dxTRxZ3i4zDrPTQg==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
VmFr7ml3aTDhuAUltvySdW+AOvXGZwGrAOwSAPiLsY2Wh+hbNXyuPlrq5yQ+4h3D3gnwkOGNEzpI
05pupfvWO5lLJdKGPQykorw/xi0avCiH51IpHLJtCnSOc1qE6161TBs+UHMUL7IOrG+uxrMJ6lG3
AxXRxUBg/1PqlpVi3idXIkWY4j12WJJjVbChhv7SCjE+SSaoW/d1WQlf4s79WBmb0WL1Pw13Hqzd
eh136M++u8fBcz8//+cChjMfpBQ/TeiE1TWXM+tPgHJyl2JNV/c3yk7D+VTIbAzNLltbCULCVLYr
WFMn8JvedBVGocxoIukg9s+anFuOys0zFzxXhg==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-PREC-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
gpRm1tF66XoNeGB3TB7tL9wN0Vpiv9KAdNjce+TzohDQBpJvwplFymIlVItkzxz3LZwolSChxnL/
YDix+hT2tSVPv1Mz0BeURiCcCfix6dCwyezkEtLLdCFXKohjTJNWqnT8rSPBUUygK4udh/Wscf7D
qs8/A6KWA98PtglmTX4UhmYi2+4fc1GYEX4CDzDFK2MzMNmOLF9L6RSPa1NcxExLyAQgMPb9hQ5J
NsBFRxyTMN6Ekbo55kenWG6b6LF2A0Iw7jMPouIeXN83ySf6fyxlL9r6VatqkC69BKAjdyj50Fvr
APvoU3mPhM5kosLIfNng2VJu118Zp1bOe4RkMg==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 2416)
`pragma protect data_block
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
Seh5vrD7JczX0DnxR30MI8sroFO9ZQ==
`pragma protect end_protected
`pragma protect begin_protected
`pragma protect version = 1
`pragma protect encrypt_agent = "XILINX"
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2025.2"
`pragma protect key_keyowner="Synopsys", key_keyname="SNPS-VCS-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
iAcC0jwWy9Z5+wl+B8MhHqxxL5TfadxgWGZ+9slm8BFFTgz/icCG22xcVWRmDuK3N9Rb/B5NiGwN
e/xgYClcjFKLFKF6obpmTy3RQlN7DScdrXr2QPScDw/WCtjYdj9MXrrsTWVQwdcVB9Y8aCZ9hPfz
DJKtmoIuwh46MnjDL78=

`pragma protect key_keyowner="Aldec", key_keyname="ALDEC15_001", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
U/zku1ffpc6imSyt/Wbh/wmt3ZQgYvnE2OQTi42Jd8LcGOrhT9PAdtwSQdTSCH1dxjktZRV+QtvX
8A4bc4cWoFA/p1DWMlh6rWbKmGKWlYaZWym65dURxZuhDRjCpUhGkTx09hzOAo4rS/y5qBVT0XM+
chpLC4mb8yrj9h9eIo0+QwmXPTyVq9UwMd8Uw7pzoUr1HZEoR73gGH3BCtAKbRQcU0RH03UzLnf7
qNxZVR3943pSRYhj4ZU3ACas36w9K8itP5nYl7hsMlDumjQrrXyzDC9maknE3klhemcvOpkd59zw
cw/o4zuOPBecIZRMu2V7hDGgqHe4jLQHnlbpig==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VELOCE-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
SWFvi0bYUA0VvwnOjVGnOuCVpr45WDSNZC6FHRlU2Pb6y7bUQB4QXLRpCrMe9fVqN/aig/5T/xu2
qyygh05r+nkKin8SM+PyK9x7oVaFGtQe2XZ1Yt1pHtev9TRVuDTX344eBL1SzvU6VlmiM8y3i/yc
mO7Wkl5Zkq7T+cTNuCk=

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
E1brfDHDtCUmBjWNysgUzttlnzXf+4/bkYl5Jm5ar5ZmwHNiefxalW+NIno0w0UgPyY1g8FwagIf
OTUvGsmmvU5SQUnE3xfIjHV4X6MRb4wDHxQQrWW/PzC1ilb+efMt8vNanP7YSsnW44o3L4LbnoWR
toWSG2PdT8djxmp2lAIwLAZM7HPSNbv1AjNlZQiS/ogXl9pXdCKzCc6lrk8daEjoFGCInCVSSamq
/NvzxtTj2Lxi99fW/ZYnu6qbM7mn9RzAo1s/4ePEOMn77xYEdG2q93oL6WjdmK3ArXFoo0uq09VE
ZCpBgpDg+/NYnz+k/MeL8pl0avq3E1SX/7OFbQ==

`pragma protect key_keyowner="Real Intent", key_keyname="RI-RSA-KEY-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
QUq9iWMx9C09gSO7bXme3TQAT+KpWBDIgwuc5mquAxoXBxbjrXkAOyUlFPDvAR8zUigyn48IFmVM
R1ZXi89FZ/93iIMKDEzJsMwNO20nnmtgBhV7wdmZYED778+HpTDaOd48EEZFa13zrADED27mGYPQ
K7yigaVTlUFFr4LOdtvf4os7kjEmAl5h6/eTZYs9d6+ec/BJcAsfvRMqmY/fiPN1UszYmMy14wg/
/QG4nKULNjCxDHD18hFkLHixX0kiaC/KXUJZHxCJG+wNP1g7zwbL73MklY+QgJuzeT1jUBOr7Lz8
Q3+dk4nPKP6Z6uRU3TSVCW4kzGF/wAlkyhcJgw==

`pragma protect key_keyowner="Xilinx", key_keyname="xilinxt_2025.1-2029.x", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
KR91xvxUjHsIQTi6U9bSVmI7HXoSYi4F+/eG3Fx9n+MbrXO3Z0W5QX2Jsh503RAANZJ3jzcoQz8v
kZ6cc7DolfEItw3LQPZ7IllnHRl/mM9pdjaXUMmHXpm9SRepU+5DDmaVSlGI6ctxxuU5Z1QorU7S
JQf5p8ub+IfjMCa/cS4+xo76OOvbW0ddoLtGS43DYJq5tCXsiZFNF540pTZeqwuLkTjn13yPIxxn
zR9EpMicO506i84arUwjcV1ox750MgDJCa01vAFg33ZXr88tziMxFid5Fe6qO6xbAir+13+6CUO1
7IRSgtROityJcgEFBV/fVaax+NCLv6TZxtwyJw==

`pragma protect key_keyowner="Metrics Technologies Inc.", key_keyname="DSim", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
E3dWRjbWg0PDvbIA3yDMBfgzFLFLB4qRDkWJ7V0l/03Ki/NR4OKM2fTjDrLuZFI12IXFFTF+I+Zv
Zw4B8GGzhipssnWs5DSTGjkWe12/kifre/tY812o1q1FXFv9RrBmBYZrBqcPz1kbbhmfYE7Y1Taq
e8yz1FRCjMagQBkCD1zMWjdWBH+3x+RUrjp7OQOuSbwgl1v7UiTl9vdSrzm/aSIbwTT2tmgEABi5
Sdn47hIlyOQ1A9x6RdTw98rq2pQSKIgxj45/IRkT+sn6zkRRQH9UlZESNYNsi6j5mGxWFPwV/b6V
3e6wLofc4TTgJvHClOH1UDi0WlkTLmu8E7cGPg==

`pragma protect key_keyowner="Atrenta", key_keyname="ATR-SG-RSA-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=384)
`pragma protect key_block
ptQEntk2x7+Sf12mvNf1M4bwjBbWFpn2H2nhu45YXH4flC5Odk/MFv8wE0eXI73i/5lE2adRAawy
9Qx94hmQl4+g+9lEgLxvBJk34bePr/0WoUQY9p8Xd/vuOwjJXfzcy2LWwtadlxVGrGFSxkRuL9GW
EAzu92F+K4kagkji1XFzF/3VvOtewrkHF9xStIVAcIm8WClqFGPLQJhjrPvYZdCKP89sNwZLJWSU
yVG3Ajs58ZDGHX9wUsWpEtbQ49GfOuFJnzuBj3jE5fgTi8NGWmrmfhnWu/9wd7sbTLNIC1Ucdfln
Y/AFxtyWCOTrMD5SSRB7EhdyyjbTJMQ1EJWBKgv8TqELPQm2W97zh85j7IYkMZu27T62r/qyucC6
tKcQo8CcNVak9JL9ExK9WwccDSrCCVDnHP/F4qTbIWZgTQEHsUEjU77n0rgUEAbj/yzQjYkSGBZ2
BAi/4CaLcePuTIpZaSs7aWaGyxSa5YpUQdtnrd3t4vZaG1PagLLtpgaz

`pragma protect key_keyowner="Cadence Design Systems.", key_keyname="CDS_RSA_KEY_VER_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
hYEN7fufkwYhPajcK3XG6QEkCkax//hsK8UridEWhrru5vrLFKuh9saq486oIXVtuNSBATbtQWM0
//V1rspp1F1YO8fClxg2LQ4dOh1lC2dgWcAiagLUrL5gsKw0OKIyRn+jArLBMH5/LgeDMCN/X+zQ
kN+B3g6bDkotuK75mvLjgn5SkfuHUAfXPWkydI2lQtJW/waiIe5O6jNsm+mx0Rv7590wXcWy96fs
1bYIQFY/osRx0LYzTB7I+YNu6UzDCPEZyEY/bUvUoNAB0BE3ZVwAZW4wjCuTffptQ01KOSVJbIZ1
HNvUm2nr5OtDbCukrf9WO53B+POoCLRu+1rFwA==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
nZRDmSuplPRp+nSH093UkX36t0J50lUM89z5TQhEEeyDrgGSNUCTzgIkUg5nORT3IBT6dlmV4cth
DlemVZEoQqRZvClVJ2V68X8gY7QrordhXb8iEFuy0Z8qrSDn44Osc3QhXFfxMeic6g4Pcs+4mC7a
rk8djdWqEuagMnFE4atFEuNn2kRUcr7D32RqXvgGRpdYE1Z0QROp57Byikd8ubR2fBLSj5DTE3Qh
cz1tVqKY549SXyIICxJ1aofHpkHa0wnbdmQplykNKvCtbAefEhQcDIufbMjn2rk2aMopzH5lP4wq
hx53Ry5/WinyZ6nSamAYTAXby87gUUB5mV8w/w==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-PREC-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
N3P1AaatxnvHBvBt79NHHEwck4dlI5+VqsiRplzpymTzSe3l4Q4xxXzWQJHzu8zEEzAVdXBh6rPs
CMT4OBE6wxotpmQ5g5xzKhE89KG1egIZhpqDuwILmEGJakXONjKMwoOqRNEnD4HIapHmUD16DW+8
LcRX/B0ItP1MBZw5Q4DLI8SQoXo7hCZB8moOl2SoUK8u0kbtrL2/nUaeHPZG8lKHjDK2jWE7y91v
95iaAwaOvg7JTpOt5Kqy5isEWWe+nfi8HI+H3nOtIJk7nxacWYeZpVT+f7IEPTEq2NlkmdQtuRKi
/6+lYWvg4nxrOY0b+AsBI43zlbp5PW/ZWAzKSw==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 12688)
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
