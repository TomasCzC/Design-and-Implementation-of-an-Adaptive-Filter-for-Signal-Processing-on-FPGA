# Manual Vitis UDP LMS Firmware

This folder contains the source-level replacement for the MicroBlaze/Vitis application.

## Important

A real `.elf` file cannot be created manually. ELF is a binary executable format produced by the MicroBlaze compiler and linker. In the current Windows environment, `mb-gcc.exe` is blocked by the operating system, so this package contains all source files needed for the Vitis application and a placeholder note instead of a fake executable.

## Files

- `src/main.c`  
  MicroBlaze/lwIP UDP server. Receives `x(n)` and `d(n)` samples in signed Q16.16, writes them to AXI GPIO registers connected to the LMS filter, reads `y(n)` and `e(n)`, and sends a UDP response.

- `src/platform_config.h`  
  IP address, UDP port, register addresses and protocol constants.

- `src/udp_protocol.h`  
  Big-Endian read/write helpers.

- `src/filter_regs.h`  
  AXI GPIO register access abstraction.

- `pc/send_udp_q16.py`  
  PC-side Python UDP sender/receiver.

- `Makefile`  
  Manual build recipe for later use when the BSP and `mb-gcc.exe` work.

- `udp_lms_microblaze.elf.NOT_BUILT.txt`  
  Explanation why a real ELF is not included.

- `hw/bap_platform_no_bit.xsa`  
  Hardware platform exported from Vivado.

- `hw/top_level_existing.bit`  
  Existing bitstream exported as a separate file.

## UDP payload

Input packet:

| Field | Size | Description |
|---|---:|---|
| MAGIC | 4 B | ASCII `FPGA` |
| SEQ | 4 B | packet sequence number |
| COUNT | 2 B | number of samples |
| FLAGS | 2 B | processing mode |
| x(n) | 4 B | signed Q16.16 |
| d(n) | 4 B | signed Q16.16 |

Output packet:

| Field | Size | Description |
|---|---:|---|
| MAGIC | 4 B | ASCII `FPGO` |
| SEQ | 4 B | packet sequence number |
| COUNT | 2 B | number of samples |
| FLAGS | 2 B | processing mode |
| y(n) | 4 B | signed Q16.16 |
| e(n) | 4 B | signed Q16.16 |
