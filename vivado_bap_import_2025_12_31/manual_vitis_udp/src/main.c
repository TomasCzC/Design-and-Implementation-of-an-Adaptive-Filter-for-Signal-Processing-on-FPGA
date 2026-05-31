#include <stdint.h>
#include <string.h>

#include "platform_config.h"
#include "udp_protocol.h"
#include "filter_regs.h"

#include "xil_printf.h"
#include "xparameters.h"

#include "lwip/init.h"
#include "lwip/udp.h"
#include "lwip/pbuf.h"
#include "lwip/ip_addr.h"
#include "netif/xadapter.h"

/*
 * Manual MicroBlaze UDP LMS firmware.
 *
 * Function:
 *  - receive UDP packet with x(n), d(n) samples in signed Q16.16
 *  - write samples to AXI GPIO registers connected to the LMS filter
 *  - read y(n), e(n)
 *  - return UDP packet with y(n), e(n)
 */

static struct netif server_netif;
static struct udp_pcb *udp_server_pcb;
static uint8_t tx_buffer[TX_BUFFER_SIZE];

static void udp_rx_callback(void *arg,
                            struct udp_pcb *pcb,
                            struct pbuf *p,
                            const ip_addr_t *addr,
                            u16_t port)
{
    (void)arg;

    if (p == NULL) {
        return;
    }

    if (p->len < 12U) {
        pbuf_free(p);
        return;
    }

    const uint8_t *rx = (const uint8_t *)p->payload;

    uint32_t magic = read_be32(&rx[0]);
    if (magic != MAGIC_IN) {
        pbuf_free(p);
        return;
    }

    uint32_t seq   = read_be32(&rx[4]);
    uint16_t count = read_be16(&rx[8]);
    uint16_t flags = read_be16(&rx[10]);

    if (count > MAX_SAMPLES_PER_PACKET) {
        count = MAX_SAMPLES_PER_PACKET;
    }

    uint32_t expected_len = 12U + ((uint32_t)count * 8U);
    if (p->len < expected_len) {
        pbuf_free(p);
        return;
    }

    uint32_t rx_off = 12U;
    uint32_t tx_off = 0U;

    write_be32(&tx_buffer[tx_off], MAGIC_OUT);
    tx_off += 4U;

    write_be32(&tx_buffer[tx_off], seq);
    tx_off += 4U;

    write_be16(&tx_buffer[tx_off], count);
    tx_off += 2U;

    write_be16(&tx_buffer[tx_off], flags);
    tx_off += 2U;

    for (uint16_t i = 0; i < count; i++) {
        int32_t x_q16 = (int32_t)read_be32(&rx[rx_off]);
        rx_off += 4U;

        int32_t d_q16 = (int32_t)read_be32(&rx[rx_off]);
        rx_off += 4U;

        filter_write_sample(x_q16, d_q16);

        /*
         * If the VHDL LMS core exposes a done/valid_out flag,
         * polling should be inserted here.
         */
        int32_t y_q16 = filter_read_y();
        int32_t e_q16 = filter_read_e();

        write_be32(&tx_buffer[tx_off], (uint32_t)y_q16);
        tx_off += 4U;

        write_be32(&tx_buffer[tx_off], (uint32_t)e_q16);
        tx_off += 4U;
    }

    struct pbuf *q = pbuf_alloc(PBUF_TRANSPORT, (u16_t)tx_off, PBUF_RAM);
    if (q != NULL) {
        memcpy(q->payload, tx_buffer, tx_off);
        udp_sendto(pcb, q, addr, port);
        pbuf_free(q);
    }

    pbuf_free(p);
}

int main(void)
{
    xil_printf("MicroBlaze UDP LMS firmware start\r\n");

    ip_addr_t ipaddr;
    ip_addr_t netmask;
    ip_addr_t gateway;

    IP4_ADDR(&ipaddr,  FPGA_IP0,  FPGA_IP1,  FPGA_IP2,  FPGA_IP3);
    IP4_ADDR(&netmask, NETMASK0,  NETMASK1,  NETMASK2,  NETMASK3);
    IP4_ADDR(&gateway, GATEWAY0,  GATEWAY1,  GATEWAY2,  GATEWAY3);

    lwip_init();

    unsigned char mac_addr[] = {
        0x00, 0x0A, 0x35, 0x01, 0x02, 0x03
    };

    if (!xemac_add(&server_netif,
                   &ipaddr,
                   &netmask,
                   &gateway,
                   mac_addr,
                   XPAR_AXI_ETHERNET_0_BASEADDR)) {
        xil_printf("ERROR: xemac_add failed\r\n");
        return -1;
    }

    netif_set_default(&server_netif);
    netif_set_up(&server_netif);

    udp_server_pcb = udp_new();
    if (udp_server_pcb == NULL) {
        xil_printf("ERROR: udp_new failed\r\n");
        return -1;
    }

    if (udp_bind(udp_server_pcb, IP_ADDR_ANY, UDP_RX_PORT) != ERR_OK) {
        xil_printf("ERROR: udp_bind failed\r\n");
        return -1;
    }

    udp_recv(udp_server_pcb, udp_rx_callback, NULL);

    xil_printf("UDP server ready on 192.168.1.50:%d\r\n", UDP_RX_PORT);

    while (1) {
        xemacif_input(&server_netif);
    }

    return 0;
}
