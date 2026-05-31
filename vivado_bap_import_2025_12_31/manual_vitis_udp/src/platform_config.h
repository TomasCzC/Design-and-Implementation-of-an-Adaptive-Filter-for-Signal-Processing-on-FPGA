#ifndef PLATFORM_CONFIG_H
#define PLATFORM_CONFIG_H

#include <stdint.h>

/*
 * Manual MicroBlaze UDP/LMS firmware configuration.
 * Addresses must be checked against Vivado Address Editor or generated xparameters.h.
 */

#define FPGA_IP0 192
#define FPGA_IP1 168
#define FPGA_IP2 1
#define FPGA_IP3 50

#define NETMASK0 255
#define NETMASK1 255
#define NETMASK2 255
#define NETMASK3 0

#define GATEWAY0 192
#define GATEWAY1 168
#define GATEWAY2 1
#define GATEWAY3 1

#define UDP_RX_PORT 50000

/* Placeholder AXI GPIO base addresses. Replace with real values from xparameters.h. */
#define X_SAMPLE_BASEADDR     0x40000000U
#define D_SAMPLE_BASEADDR     0x40010000U
#define CONTROL_BASEADDR      0x40020000U
#define Y_RESULT_BASEADDR     0x40030000U
#define E_RESULT_BASEADDR     0x40040000U

#ifndef XPAR_AXI_ETHERNET_0_BASEADDR
#define XPAR_AXI_ETHERNET_0_BASEADDR 0x40E00000U
#endif

#define REG_OFFSET             0x00U
#define CTRL_VALID_MASK        0x00000001U
#define CTRL_RESET_MASK        0x00000002U

#define MAGIC_IN               0x46504741U  /* "FPGA" */
#define MAGIC_OUT              0x4650474FU  /* "FPGO" */

#define MAX_SAMPLES_PER_PACKET 64
#define TX_BUFFER_SIZE         1500

#endif
