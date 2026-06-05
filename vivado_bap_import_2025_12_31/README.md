# Adaptive FPGA Radar Filter on Genesys 2

<p align="center">
  <b>Design and implementation of an adaptive filter for signal processing on FPGA</b><br>
  <sub>MicroBlaze · AXI · UDP Ethernet · AXI DMA · Q16.16 · LMS · Radar HDF5 · Python visualization</sub>
</p>

<p align="center">
  <img alt="FPGA" src="https://img.shields.io/badge/FPGA-Kintex--7-blue?style=for-the-badge">
  <img alt="Board" src="https://img.shields.io/badge/Board-Digilent%20Genesys%202-purple?style=for-the-badge">
  <img alt="Vivado" src="https://img.shields.io/badge/Vivado-2025.2-orange?style=for-the-badge">
  <img alt="Language" src="https://img.shields.io/badge/HDL-VHDL%20%7C%20Verilog-green?style=for-the-badge">
  <img alt="Python" src="https://img.shields.io/badge/Python-3.11-yellow?style=for-the-badge">
</p>

<p align="center">
  <img alt="Status" src="https://img.shields.io/badge/status-spustitelná%20IP%20verze-success?style=flat-square">
  <img alt="Fixed point" src="https://img.shields.io/badge/fixed--point-Q16.16-informational?style=flat-square">
  <img alt="Protocol" src="https://img.shields.io/badge/protocol-UDP%20over%20Ethernet-informational?style=flat-square">
  <img alt="Algorithm" src="https://img.shields.io/badge/adaptive%20filter-LMS-informational?style=flat-square">
</p>

---

## Stav projektu

**Datováno:** `31. 5. 2026, 19:00`  
**Varianta:** IP-jádrová implementace ve Vivado Block Designu  
**Cílová deska:** Digilent Genesys 2 s FPGA AMD/Xilinx Kintex-7  
**Účel:** bakalářská práce – návrh a implementace adaptivního filtru pro zpracování signálů na FPGA

Tento repozitář obsahuje implementační projekt pro adaptivní zpracování radarových signálů na FPGA. Návrh kombinuje vlastní HDL jádro adaptivního filtru s IP jádry v prostředí Vivado. Nadřazený počítač připravuje radarová data z HDF5 souboru, převádí je do formátu Q16.16 a posílá je do FPGA přes Ethernet. Výsledky jsou následně vyhodnocovány v Pythonu pomocí časových průběhů, MSE, FFT a mapové vizualizace.

---

## Cíl projektu

Cílem projektu je vytvořit systém, který:

- přijme radarová testovací data z PC,
- převede je do fixed-point reprezentace Q16.16,
- předá vzorky do hardwarového adaptivního filtru,
- vypočítá výstup `y[n]` a chybu `e[n]`,
- odešle výsledky zpět do PC,
- vyhodnotí kvalitu filtrace v Pythonu.

---

## Architektura systému

```mermaid
flowchart LR
    A[PC / Python] --> B[HDF5 radar data]
    B --> C[ROI selection]
    C --> D[Q16.16 conversion]
    D --> E[UDP packet stream]
    E --> F[Genesys 2 Ethernet PHY]
    F --> G[AXI Ethernet / DMA]
    G --> H[MicroBlaze + lwIP]
    H --> I[AXI GPIO / register bridge]
    I --> J[VHDL adaptive LMS filter]
    J --> K[y[n], e[n]]
    K --> H
    H --> L[UDP response]
    L --> M[Python evaluation]
    M --> N[MSE / FFT / plots / radar map]
```

---

## Použitá IP jádra a subsystémy

| Blok | Úloha v systému |
|---|---|
| **MicroBlaze** | řídicí procesor pro obsluhu komunikace a předávání dat |
| **AXI Interconnect / SmartConnect** | propojení AXI periferií |
| **AXI Ethernet / 1G Ethernet Subsystem** | ethernetová komunikační vrstva |
| **AXI DMA** | blokové přenosy dat mezi Ethernetem a pamětí |
| **MIG / DDR3** | paměťový subsystém desky Genesys 2 |
| **AXI GPIO** | registry pro propojení MicroBlaze ↔ VHDL filtr |
| **AXI UARTLite** | diagnostický výstup a ladění firmwaru |
| **Clocking Wizard** | generování systémových hodin |
| **Processor System Reset** | synchronizace resetů |
| **VHDL LMS filter core** | vlastní výpočetní část adaptivního filtru |
| **OLED / LED status** | lokální stavová diagnostika |

---

## Fixed-point formát Q16.16

Vzorky se přenášejí jako 32bitová znaménková čísla ve formátu **signed Q16.16**.

| Reálná hodnota | Q16.16 hodnota |
|---:|---:|
| `1.0` | `65536` |
| `0.5` | `32768` |
| `-0.5` | `-32768` |
| `0.0` | `0` |

Převod:

```text
x_q16 = round(x · 2^16)
x     = x_q16 / 2^16
```

---

## UDP aplikační payload

Datový formát je binární, aby se minimalizovala režie parsování a přenosu.

### PC → FPGA

| Položka | Velikost | Popis |
|---|---:|---|
| `MAGIC` | 4 B | identifikátor platného paketu |
| `SEQ` | 4 B | sekvenční číslo paketu |
| `COUNT` | 2 B | počet vzorků |
| `FLAGS` | 2 B | řídicí příznaky |
| `x[n]` | 4 B / vzorek | vstupní vzorky Q16.16 |
| `d[n]` | 4 B / vzorek | referenční vzorky Q16.16 |

### FPGA → PC

| Položka | Velikost | Popis |
|---|---:|---|
| `MAGIC` | 4 B | identifikátor odpovědi |
| `SEQ` | 4 B | sekvenční číslo |
| `COUNT` | 2 B | počet výsledků |
| `STATUS` | 2 B | stavové příznaky |
| `y[n]` | 4 B / vzorek | výstup filtru Q16.16 |
| `e[n]` | 4 B / vzorek | chyba filtru Q16.16 |

---

## Datový tok v praxi

```text
HDF5 radarová data
    ↓
Python: výběr radarového profilu
    ↓
Python: normalizace a vytvoření x[n], d[n]
    ↓
Python: převod do signed Q16.16
    ↓
UDP / Ethernet
    ↓
MicroBlaze + AXI DMA + AXI GPIO
    ↓
VHDL LMS filtr
    ↓
výpočet y[n], e[n]
    ↓
UDP odpověď
    ↓
Python: CSV, MSE, FFT, grafy, mapa
```

---

## Ukázky výsledků

Doporučené umístění obrázků v repozitáři:

```text
docs/img/01_radar_map_with_roi.png
docs/img/04_lms_signals_normalized.png
docs/img/06_mse.png
docs/img/07_fft_comparison.png
docs/img/08_lms_result_dbz.png
docs/img/09_map_filtered_projection.png
docs/img/10_roi_difference_zoom.png
```

### Radarová mapa a vybraná oblast

<p align="center">
  <img src="docs/img/01_radar_map_with_roi.png" width="850" alt="Radar map with selected ROI">
</p>

### Časové průběhy LMS filtru

<p align="center">
  <img src="docs/img/04_lms_signals_normalized.png" width="850" alt="LMS input output signals">
</p>

### Vývoj střední kvadratické chyby

<p align="center">
  <img src="docs/img/06_mse.png" width="850" alt="MSE curve">
</p>

### Spektrální porovnání

<p align="center">
  <img src="docs/img/07_fft_comparison.png" width="850" alt="FFT comparison">
</p>

### Výsledek v jednotkách dBZ

<p align="center">
  <img src="docs/img/08_lms_result_dbz.png" width="850" alt="LMS result in dBZ">
</p>

### Projekce filtrovaného profilu do radarové mapy

<p align="center">
  <img src="docs/img/09_map_filtered_projection.png" width="850" alt="Filtered map projection">
</p>

---

## ⏱️ Clocking

Projekt používá `clk_wiz_0` jako centrální zdroj hodin.

| Výstup | Frekvence | Účel |
|---|---:|---|
| `clk_out1` | 125 MHz | Ethernet / systémová logika |
| `clk_out2` | 25 MHz | výpočetní část / filtr |
| `clk_out3` | 200 MHz | IDELAYCTRL / podpůrná rychlá doména |
| `clk_out4` | 125 MHz, 90° | RGMII TX clock |

> RGMII vyžaduje korektní časování TX clocku vůči datům. Proto je použit samostatný výstup s fázovým posunem.

---

## 🧠 Adaptivní filtr

Výpočetní jádro je realizováno ve VHDL a pracuje s pevnou řádovou čárkou Q16.16. Základní LMS vztahy:

```text
y[n] = Σ w_i[n] · x[n-i]
e[n] = d[n] - y[n]
w_i[n+1] = w_i[n] + μ · e[n] · x[n-i]
```

Výhody zvolené realizace:

- jednoduchá hardwarová struktura,
- vhodné mapování na DSP bloky FPGA,
- oddělení výpočetního jádra od komunikační vrstvy,
- možnost testovat filtr pomocí stejných vektorů v Pythonu i na FPGA.

---

## 🖥️ Python nástroje

Python část slouží k přípravě dat a vyhodnocení výsledků.

Typické skripty:

| Skript | Úloha |
|---|---|
| `datah5py.py` | načtení HDF5 dat, výběr ROI, převod do Q16.16 |
| `send_lms_vectors_to_fpga_udp.py` | odeslání LMS vektorů do FPGA přes UDP |
| `send_fpga_and_generate_10_lms_plots.py` | odeslání dat a vygenerování kompletní sady grafů |
| `analyze_lms_radar.py` | vyhodnocení výsledků, MSE, FFT, mapové grafy |

Instalace závislostí:

```powershell
python -m pip install numpy pandas matplotlib h5py
```

Volitelné pro mapové podklady:

```powershell
python -m pip install contextily
```

---

## Spuštění Python testu

Příklad spuštění:

```powershell
python python/send_lms_vectors_to_fpga_udp.py --ip 192.168.1.128 --port 1234 --n 128
```

Očekávané parametry sítě:

```text
FPGA IP:   192.168.1.128
UDP port:  1234
PC IP:     192.168.1.10/24
```

---

## Spuštění projektu ve Vivado

Doporučený postup:

```tcl
open_project BAP.xpr

update_compile_order -fileset sources_1
validate_bd_design
generate_target all [get_files *.bd]
make_wrapper -files [get_files *.bd] -top
update_compile_order -fileset sources_1

reset_run synth_1
launch_runs synth_1 -jobs 8

reset_run impl_1
launch_runs impl_1 -to_step write_bitstream -jobs 4
```

Po vygenerování bitstreamu:

```tcl
open_hw_manager
connect_hw_server
open_hw_target
program_hw_devices [lindex [get_hw_devices] 0]
```

---

## Ověření

Ověření systému probíhá po vrstvách:

- kontrola HDF5 dat a výběru ROI,
- kontrola Q16.16 reprezentace,
- kontrola UDP komunikace,
- kontrola zápisu vzorků do vstupních registrů,
- kontrola výstupů `y[n]` a `e[n]`,
- porovnání výsledků s Python referencí,
- vyhodnocení MSE a FFT.

Příklad výstupu UDP testu:

```text
sent:    128
ok:      128
timeout: 0
```

---

## OLED / LED diagnostika

OLED displej slouží jako lokální stavový výstup. Hlavní numerické výsledky jsou zpracovávány na PC.

| Zkratka | Význam |
|---|---|
| `IN` | vstupní vzorek dorazil do filtru |
| `OUT` | filtr vydal výsledek |
| `B` | filtr je ve stavu busy |
| `MET` | platnost metrik / výsledků |
| `FRZ` | freeze režim |

Poznámka: stavové signály typu `IN`, `OUT` nebo `MET` mohou být v HDL pouze jednotaktové impulsy. Pro čitelné zobrazení na OLED je vhodné je prodloužit pomocí čítače.

---

## Doporučená struktura repozitáře

```text
.
├── BAP.gen/sources_1    
├── BAP.hw
├── BAP.ip_user_files
├── BAP.srcs
├── init
├── manual_vitis_udp
└── README.md
```

---

## Co je v projektu ověřováno

- načtení a zpracování reálných radarových HDF5 dat,
- převod dat do Q16.16,
- UDP přenos mezi PC a FPGA,
- předání vzorků do výpočetního řetězce,
- výpočet a vyhodnocení LMS filtru,
- MSE a FFT analýza,
- převod výsledku zpět do jednotek dBZ,
- mapová projekce filtrovaného profilu.

---

## Možnosti rozšíření

- doplnění ILA sond pro detailní ladění datové cesty,
- automatické porovnání FPGA výstupu s Python referencí,
- rozšíření z LMS také na NLMS a RLS v hardwaru,
- přechod z registrového rozhraní na plně streamovanou AXI-Stream architekturu,
- optimalizace latence přes AXI DMA,
- zpracování delších radarových profilů,
- rozšíření na 2D radarová data.

---

## Klíčové technologie

<p align="center">
  <img alt="MicroBlaze" src="https://img.shields.io/badge/MicroBlaze-soft--core-blue">
  <img alt="AXI" src="https://img.shields.io/badge/AXI-Interconnect%20%7C%20DMA-red">
  <img alt="Ethernet" src="https://img.shields.io/badge/Ethernet-UDP%20%7C%20RGMII-green">
  <img alt="DSP" src="https://img.shields.io/badge/DSP-Q16.16%20LMS-yellow">
  <img alt="Radar" src="https://img.shields.io/badge/Data-HDF5%20Radar-lightgrey">
</p>

---

## Shrnutí

Tento projekt představuje IP-jádrovou implementační variantu systému pro adaptivní filtraci signálů na FPGA. Hlavní výpočet je realizován ve VHDL, zatímco komunikaci, řízení a blokové přenosy zajišťuje embedded systém postavený nad MicroBlaze a AXI infrastrukturou. Na straně PC probíhá příprava radarových HDF5 dat, převod do Q16.16 a následné vyhodnocení výsledků pomocí Pythonu.

Projekt je navržen tak, aby odděloval matematické jádro filtru od transportní vrstvy. Díky tomu lze samostatně ověřovat jak komunikační cestu, tak numerické chování adaptivního filtru.