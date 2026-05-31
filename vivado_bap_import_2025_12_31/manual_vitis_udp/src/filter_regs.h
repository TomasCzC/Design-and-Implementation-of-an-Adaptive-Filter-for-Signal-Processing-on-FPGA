#ifndef FILTER_REGS_H
#define FILTER_REGS_H

#include <stdint.h>
#include "platform_config.h"
#include "xil_io.h"

static void filter_write_sample(int32_t x_q16, int32_t d_q16)
{
    Xil_Out32(X_SAMPLE_BASEADDR + REG_OFFSET, (uint32_t)x_q16);
    Xil_Out32(D_SAMPLE_BASEADDR + REG_OFFSET, (uint32_t)d_q16);

    Xil_Out32(CONTROL_BASEADDR + REG_OFFSET, CTRL_VALID_MASK);
    Xil_Out32(CONTROL_BASEADDR + REG_OFFSET, 0x00000000U);
}

static int32_t filter_read_y(void)
{
    return (int32_t)Xil_In32(Y_RESULT_BASEADDR + REG_OFFSET);
}

static int32_t filter_read_e(void)
{
    return (int32_t)Xil_In32(E_RESULT_BASEADDR + REG_OFFSET);
}

#endif
