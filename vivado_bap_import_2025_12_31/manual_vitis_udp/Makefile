# Manual MicroBlaze build helper.
# Real ELF generation requires a working MicroBlaze GCC, BSP libraries and linker script.

APP = udp_lms_microblaze
SRC = src/main.c
OBJ = main.o

MBGCC ?= C:/AMDDesignTools/2025.2/Vitis/gnu/microblaze/nt/bin/mb-gcc.exe
BSP   ?= C:/FPGA/BAP/vitis_ws/platform/export/platform/sw/standalone_microblaze_0

CFLAGS = -mxl-barrel-shift -mlittle-endian -mxl-pattern-compare \
         -mno-xl-soft-mul -mxl-multiply-high -mno-xl-soft-div \
         -mhard-float -mcpu=v11.0 -DSDT -Os \
         -ffunction-sections -fdata-sections -Wall -Wextra \
         -I$(BSP)/include -Isrc

LDFLAGS = -Wl,--no-relax -Wl,--gc-sections \
          -Wl,--defsym=_STACK_SIZE=0x800 \
          -Wl,--defsym=_HEAP_SIZE=0x800 \
          -Wl,-Map=$(APP).map \
          -Wl,-T -Wl,lscript.ld \
          -L$(BSP)/lib \
          -Wl,--start-group -lxilstandalone -lxiltimer -llwip220 -lgloss -lxil -lgcc -lc -Wl,--end-group

all: $(APP).elf

$(OBJ): $(SRC)
"$(MBGCC)" $(CFLAGS) -c $(SRC) -o $(OBJ)

$(APP).elf: $(OBJ)
"$(MBGCC)" $(CFLAGS) $(OBJ) -o $(APP).elf $(LDFLAGS)

clean:
del /Q *.o *.elf *.map 2>NUL
