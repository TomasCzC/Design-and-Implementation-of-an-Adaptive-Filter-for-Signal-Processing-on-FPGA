# Design-and-Implementation-of-an-Adaptive-Filter-for-Signal-Processing-on-FPGA
## Project Overview
This project implements an **adaptive LMS (Least Mean Square) filter** on a **Xilinx Artix-7 FPGA (Nexys A7-50T)**. The system includes:

- LMS filter implemented in **fixed-point VHDL**
- FFT block for spectral analysis
- UDP communication module for sending data to a PC
- Python GUI for **visualization and analysis** of input, filtered, and spectral data

The project demonstrates **adaptive noise cancellation**, real-time signal processing on FPGA, and interactive analysis on PC.

## Features
- Adaptive LMS filtering of input signals
- Real-time FFT analysis for spectral visualization
- Ethernet-based UDP communication for PC integration
- Python GUI for interactive visualization, data logging, and analysis

## Technologies
- VHDL (for FPGA implementation)
- Python (for GUI and simulations)
- Xilinx Vivado (for FPGA synthesis and implementation)
- UDP communication protocol
