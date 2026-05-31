# Emergency UART late pin fix
reset_property LOC [get_ports -quiet {usb_uart_rxd usb_uart_txd}]
reset_property PACKAGE_PIN [get_ports -quiet {usb_uart_rxd usb_uart_txd}]
reset_property IOSTANDARD [get_ports -quiet {usb_uart_rxd usb_uart_txd}]
set_property PACKAGE_PIN Y20 [get_ports usb_uart_rxd]
set_property PACKAGE_PIN Y23 [get_ports usb_uart_txd]
set_property IOSTANDARD LVCMOS33 [get_ports {usb_uart_rxd usb_uart_txd}]
