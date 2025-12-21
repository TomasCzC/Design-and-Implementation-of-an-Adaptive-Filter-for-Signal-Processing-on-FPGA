# Design and Implementation of an Adaptive Filter for Signal Processing on FPGA
**Author:** Tomáš Běčák  
**Semestral/Bachelor Thesis – VUT FEKT DREL (2025/2026)**
**Programming language: Python 3.11.9**  
**Assistant tool:** OpenAI ChatGPT (used for coding assistance, design/verification done by the author)

---

# 📘 Table of Contents
- [1. Introduction](#1-introduction)
- [2. Project Goals](#2-project-goals)
- [3. Supported Algorithms](#3-supported-algorithms)
- [4. System Architecture](#4-system-architecture)
- [5. Installation](#5-installation)
- [6. Running the Application](#6-running-the-application)
- [7. Features](#7-features)
- [8. User Interface Overview](#8-user-interface-overview)
- [9. Example Outputs](#9-example-outputs)
- [10. AI Usage Declaration](#10-ai-usage-declaration)
- [11. License](#11-license)
- [12. Planned Extensions](#12-planned-extensions)

---

## 1. Introduction

This project implements a **software simulator of adaptive filters** intended as a **verification and experimentation platform** for a bachelor thesis focused on adaptive filtering on FPGA:

> *„Návrh a implementace adaptivního filtru pro zpracování signálu na FPGA“*  
> FEKT VUT Brno, 2025/2026.

The application allows testing adaptive algorithms on:
- **synthetic signals** with known reference,
- **real biomedical signals (ECG)**,
- **RF radio datasets (I/Q signals)**.

The simulator focuses on:
- algorithm behaviour,
- convergence properties,
- numerical stability,
- comparison of adaptive methods prior to FPGA implementation.

---

## 2. Project Objectives

- Create a **modular adaptive filter simulator** in Python  
- Enable **safe experimentation** with adaptive algorithms and parameters  
- Provide **time-domain and frequency-domain visualization**  
- Support **real datasets** (ECG, radio I/Q) in addition to synthetic signals  
- Serve as a **software reference model** before fixed-point FPGA design  

---

## 3. Supported Adaptive Algorithms

Adaptive algorithms are implemented using the **padasip** library.

### Supported filters

| Category | Algorithms |
|--------|-----------|
| LMS-based | LMS, NLMS, SSLMS |
| Recursive | RLS |
| Projection | AP (Affine Projection) |
| Robust / nonlinear | Llncosh, GMCC |
| Normalized gradient | GNGD |

The GUI supports:
- algorithm selection,
- parameter presets,
- manual parameter tuning,
- runtime parameter validation.

---

## 4. Software Architecture
```
DESIGN-AND-IMPLEMENTATION-OF-AN-ADAPTIVE-FILTER-FOR-SIGNAL-PROCESSING-ON-FPGA/
│
├── src/
│ ├── app.py
│ ├── config.py
│ ├── filters/
│ │ ├── signal_generation.py
│ │ ├── filter_runner.py
│ │ ├── metrics.py
│ │ ├── fft_utils.py
│ │ ├── safety.py
│ │ └── init.py
│ ├── signals/
│ │ ├── ecg_loader.py
│ │ ├── csv_loader.py
│ │ ├── radio_loader.py
│ │ ├── signal_meta.py
│ │ └── init.py
│ ├── gui/
│ │ ├── main_window.py
│ │ ├── param_tuner.py
│ │ ├── preview_window.py
│ │ ├── load_signal_dialog.py
│ │ └── init.py
├── docs/
│ └── images/
└── requirements.txt
```

### **Clickable source files**
- [src/app.py](src/app.py)  
- [src/config.py](src/config.py)  

**Filters:**
- [src/filters/filter_runner.py](src/filters/filter_runner.py)  
- [src/filters/signal_generation.py](src/filters/signal_generation.py)  
- [src/filters/metrics.py](src/filters/metrics.py)  
- [src/filters/fft_utils.py](src/filters/fft_utils.py)  
- [src/filters/safety.py](src/filters/safety.py)  

**GUI:**
- [src/gui/main_window.py](src/gui/main_window.py)  
- [src/gui/param_tuner.py](src/gui/param_tuner.py)  
- [src/gui/canvases.py](src/gui/canvases.py)  
- [src/gui/__init__.py](src/gui/__init__.py)

**Other:**
- [requirements.txt](requirements.txt)

---

# 5. Installation
Create a Python virtual environment:

```
$ python -m venv .venv
```
Activate (PowerShell):
```
$ .\.venv\Scripts\Activate.ps1
```
Install required dependencies:
```
$ pip install -r requirements.txt
```

---

# 6. Running the Application
From repository root:
```
$ python -m src.app
```
Or manually:
```
$ cd src
$ python app.py
```

---

# 7. Features

### Adaptive Filtering
- LMS, NLMS, RLS, AP, SSLMS, Llncosh, GMCC, GNGD  
- Real-time μ / ε / order tuning  
- Built-in presets per algorithm

### Visualization
- Input vs clean reference  
- Output signal  
- Error signal  
- MSE(dB) smoothed  
- FFT magnitude

### Metrics
- MSE  
- EMSE  
- J_min  
- Misadjustment  
- SNR_in / SNR_out  
- ΔSNR  
- N90% convergence

### Numerical Safety
- Overflow clamping  
- Safe square/log10  
- NaN/Inf protection  
- Divergence detection  
- Automatic stability enforcement

### GUI Tools
- Parameter tuner dialog  
- Log-scale sliders  
- Preset system  
- Warning pop-ups

---

# 8. User Interface Overview

The GUI layout consists of:

- **Left panel** – algorithm selection, parameter inputs, presets  
- **Right panel** – time-domain plots (input, output, error, MSE)  
- **Bottom panel** – FFT magnitude plot + metrics table  
- **Settings dialog** – μ, eps, order, logarithmic sliders 

---

# 9. Example Outputs
```
![Output vs Reference](docs/images/output_reference.png)
![MSE Curve](docs/images/mse_curve.png)
![FFT](docs/images/fft.png)
```
---

# 10. AI Usage Declaration
OpenAI ChatGPT was used exclusively as a coding assistant for:
- refactoring and organizing application structure
- generating GUI boilerplate
- adding numeric safety mechanisms

---

# 11. License

MIT License.

---

# 12. Planned Extensions
- Fixed-point simulation backend (FPGA parity testing)
- Import of biomedical datasets (ECG/EEG)
- RF I/Q loader (complex64, int16)
- Sphinx-based documentation site
- Real-time UDP communication with FPGA  

---
