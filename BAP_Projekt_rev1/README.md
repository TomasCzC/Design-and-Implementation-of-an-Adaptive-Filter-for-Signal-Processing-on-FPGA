# FPGA Adaptive LMS Filter with Ethernet Interface

[![Vivado](https://shields.io)](https://xilinx.com)
[![Fakulta](https://shields.io)](https://vut.cz)
[![Platform](https://shields.io)](https://digilent.com)

Tento repozitář obsahuje embedded systém pro adaptivní filtraci číslicových signálů v reálném čase implementovaný v programovatelném hradlovém poli (FPGA) AMD/Xilinx Kintex-7. Projekt tvoří praktické inženýrské jádro bakalářské práce na Ústavu radioelektroniky (ÚREL) Fakulty elektrotechniky a komunikačních technologií Vysokého učení technického v Brně (FEKT VUT).

This repository contains an embedded real-time system for adaptive signal filtering implemented on an AMD/Xilinx Kintex-7 FPGA. This project serves as the core engineering implementation of a bachelor's thesis at the Department of Radio Electronics (DREL), Faculty of Electrical Engineering and Communication, Brno University of Technology (FEEC BUT).

---

## 🇨🇿 ČESKÁ VERZE

### 1. Architektura systému a hardwarové zdroje
Systém je koncipován jako uzavřená komunikační a výpočetní smyčka realizovaná na vývojové desce Digilent Genesys 2:
* **Hardware (FPGA SoC):** Soft-core procesor MicroBlaze (32-bit RISC), řadič AXI DMA, subsystém AXI 1G/2.5G Ethernet, vnější paměť DDR3 SDRAM, řadič paměti MIG 7 Series a hardwarové akcelerátory DSP48E1.
* **Výpočetní jádro:** Autorský VHDL modul 8-tapového adaptivního filtru s algoritmem LMS v plně paralelní RTL architektuře. Operace typu MAC (Multiply-Accumulate) využívají signed fixed-point reprezentaci ve formátu Q16.16 mapovanou na integrované DSP bloky.
* **Komunikační vrstva:** Gigabitový Ethernet s transportním protokolem UDP za využití open-source síťového stacku lwIP. Návrh a časování fyzického rozhraní (RGMII PHY transceiver Realtek RTL8211E-VL pracující na frekvenci 125 MHz s DDR vzorkováním) byly optimalizovány na základě referenčních schémat desky Digilent Nexys Video, která sdílí identickou topologii ethernetového kontroléru.
* **Diagnostické periferie:** Autonomní SPI řadič implementovaný v jazyce Verilog. Zajišťuje nízkoúrovňovou inicializaci a řízení vestavěného stavového OLED displeje desky Genesys 2, který slouží k přímé vizualizaci přidělené IP adresy a chybových stavů nezávisle na diagnostické sériové lince AXI UARTLite.

### 2. Adresářová struktura
* `/fpga` - Hardwarový projekt prostředí Vivado Design Suite, zdrojové kódy VHDL/Verilog, definiční soubory fyzických omezení XDC a simulační testbenche.
* `/firmware` - Zdrojové kódy v jazyce C pro procesor MicroBlaze vyvinuté v prostředí Vitis Unified Software Platform (obsluha lwIP, inicializace DMA a správa registrového rozhraní AXI GPIO).
* `/python` - Uživatelská aplikace pro PC (Python 3.11.9) využívající knihovny NumPy, SciPy a Matplotlib pro parsování HDF5 radarových dat, UDP enkapsulaci, dekódování zpětného ping-pong toku a výpočet SNR/MSE.
* `/data` - Vstupní testovací vektory odvozené z reálných trojrozměrných meteorologických radarových dat ČHMÚ (formát ODIM HDF5, korigovaná radarová odrazivost DBZH).
* `/doc` - Systémová bloková schémata architektury SoC, schémata datových toků a časové diagramy sběrnic AXI4-Lite a AXI-Stream.

### 3. Replikace projektu & Oprava relativních cest
Z důvodu výskytu absolutních vazeb na lokální knihovny v původním exportu pro IS VUT byla v tomto repozitáři kompletně zrekonstruována struktura projektu s využitím striktně relativních cest.

#### Sestavení hardwaru (Vivado)
1. Spusťte Vivado Design Suite (ověřeno na verzi 2022.2).
2. V Tcl konzoli přejděte do kořenového adresáře `/fpga` a obnovte projekt spuštěním:
   ```tcl
   source recreate_project.tcl
   ```
3. Spusťte logickou syntézu (**Run Synthesis**) a fyzickou implementaci (**Run Implementation**).
4. Vygenerujte konfigurační bitstream (**Generate Bitstream**) a nahrajte jej do obvodu Kintex-7 přes Hardware Manager.

#### Spuštění firmwaru (Vitis)
1. Importujte hardwarovou specifikaci XSA vyexportovanou z Vivada do prostředí Vitis.
2. Sestavte vrstvu podpory desky (BSP) zahrnující ovladače pro AXI DMA, AXI GPIO a knihovnu lwIP.
3. Zkompilujte firmware ze složky `/firmware` a nahrajte jej spolu s bitstreamem do desky.

#### Spuštění softwaru (Python GUI)
1. Přejděte do složky `/python`.
2. Nainstalujte požadované závislosti:
   ```bash
   pip install -r requirements.txt
   ```
3. Nakonfigurujte statickou IP adresu síťové karty vašeho PC na stejnou podsíť, jakou indikuje OLED displej na FPGA desce.
4. Spusťte vyhodnocovací skript s testovacím vektorem:
   ```bash
   python main.py --input ../data/radar_profile.csv
   ```

---

## 🇬🇧 ENGLISH VERSION

### 1. System Architecture & Hardware Resources
The system implements a closed-loop signal processing pipeline on the Digilent Genesys 2 development platform:
* **Hardware (FPGA SoC):** MicroBlaze 32-bit RISC soft-core processor, AXI DMA controller, AXI 1G/2.5G Ethernet Subsystem, external DDR3 SDRAM, MIG 7 Series memory controller, and dedicated DSP48E1 slices.
* **Computational Core:** A custom 8-tap adaptive LMS filter VHDL module utilizing a fully parallel RTL architecture. High-speed MAC operations are executed in signed Q16.16 fixed-point arithmetic mapped directly to onboard DSP blocks.
* **Transport Layer:** Gigabit Ethernet utilizing the UDP protocol via the open-source lwIP network stack. The physical layer interface (125 MHz RGMII PHY Realtek RTL8211E-VL transceiver with DDR sampling) was optimized based on Digilent Nexys Video reference schematics due to identical network controller topology.
* **Peripherals:** An auxiliary Verilog-based SPI controller. It handles low-level initialization of the onboard OLED display on the Genesys 2 board, providing local visualization of the assigned IP address and system status flags independently of the AXI UARTLite diagnostic terminal.

### 2. Directory Structure
* `/fpga` - Hardwarové Vivado design project, VHDL/Verilog source files, XDC constraints, and simulation testbenches.
* `/firmware` - MicroBlaze C-code application developed in Vitis platform (lwIP stack handling, DMA interrupts, and AXI GPIO register mapping).
* `/python` - Master PC application (Python 3.11.9) utilizing NumPy, SciPy, and Matplotlib for HDF5 radar data parsing, UDP encapsulation, and SNR/MSE analysis.
* `/data` - Input benchmark vectors derived from real CHMI weather radar matrices (ODIM HDF5 standard, DBZH product).
* `/doc` - System block diagrams, data flow charts, and AXI4-Lite/AXI-Stream timing specifications.

### 3. Project Replication & Relative Path Refactoring
Due to absolute path dependencies present in the original university IS archive, this repository has been fully refactored using strict relative paths to ensure cross-platform reproducibility.

#### Hardware Build (Vivado)
1. Open Vivado Design Suite (verified on version 2022.2).
2. In the Tcl Console, navigate to the `/fpga` folder and reconstruct the project:
   ```tcl
   source recreate_project.tcl
   ```
3. Run **Run Synthesis** and **Run Implementation**.
4. Click **Generate Bitstream** and program the target Kintex-7 chip via Hardware Manager.

#### Software Deployment (Vitis)
1. Import the exported hardware specification file (XSA) into Vitis platform.
2. Generate the Board Support Package (BSP) including AXI DMA, AXI GPIO, and lwIP libraries.
3. Compile the C source files from the `/firmware` directory and flash the executable along with the bitstream.

#### PC Application Execution (Python GUI)
1. Navigate to the `/python` directory.
2. Install dependencies:
   ```bash
   pip install -r requirements.txt
   ```
3. Configure your PC’s network interface card (NIC) static IP address to match the subnet shown on the FPGA's OLED display.
4. Execute the verification script:
   ```bash
   python main.py --input ../data/radar_profile.csv
   ```

---

## Fixed-Point Operational Specification (Q16.16)
* **Word Width:** 32 bits (aligns with native AXI4-Lite registers and MicroBlaze architecture).
* **Integer / Fractional Allocation:** 16-bit signed integer (prevents accumulator overflow during LMS weight updates) / 16-bit fraction.
* **Overflow Protection:** Algorithmic arithmetic right-shifts (16 bits) post-multiplication with saturation hardware macros implemented within DSP48E1 blocks to safeguard numerical stability.
* **Memory Coherence:** Evaluated via software cache invalidation using `Xil_DCacheInvalidateRange()` API calls during AXI DMA scatter-gather transfers to DDR3 memory.

---

## Literatura a zdroje / References
[1] **BĚČÁK, T.** *Návrh a implementace adaptivního filtru pro zpracování signálu na FPGA*. Bakalářská práce. Brno: Vysoké učení technické v Brně, Fakulta elektrotechniky a komunikačních technologií, Ústav radioelektroniky, 2026.  
[2] **AMD/Xilinx.** *MicroBlaze Processor Reference Guide (UG984)*. Online v2022.2.  
