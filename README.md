# Design and Implementation of an Adaptive Filter for Signal Processing on FPGA
**Author:** Tomáš Běčák  
**Semestral/Bachelor Thesis – VUT FEKT DREL (2025/2026)**  
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

# 1. Introduction
This project implements a **numerically safe adaptive filter simulator** with real-time visualization.  
It is used as the software verification platform for the bachelor thesis:

> *„Návrh a implementace adaptivního filtru pro zpracování signálu na FPGA“*  
> FEKT VUT Brno, 2025.

The tool allows experimentation with a wide range of adaptive algorithms, including visualization of:

- input and filtered signals  
- error signal  
- MSE curve  
- FFT spectra  
- SNR improvement  
- convergence behaviour  

---

# 2. Project Goals
- Provide a modular simulation environment for adaptive filters  
- Allow interactive parameter tuning and algorithm comparison  
- Offer real-time visualization of error, convergence and spectral properties  
- Support safe execution even for unstable parameters (clamping, divergence detection)  
- Serve as a software verification layer before fixed-point FPGA implementation  

---

# 3. Supported Algorithms
The simulator supports the following adaptive filters via the padasip library:

| Group | Algorithms |
|-------|------------|
| LMS family | LMS, NLMS, SSLMS |
| Recursive | RLS |
| Projection-based | AP (Affine Projection) |
| Robust nonlinear | Llncosh, GMCC |
| Gradient-normalized | GNGD |

The GUI allows:
- algorithm selection
- presets
- detailed parameter tuning
- runtime safety constraints (e.g., μ < 1/order for AP)

---

# 4. System Architecture
The project is split into three main layers:

1. **Application Layer (app.py)**  
   - Entry point of the program  
   - Initializes the GUI  
   - Routes algorithm choices, parameters and GUI events  
   - Ensures safe execution flow

2. **Filtering Core (src/filters/)**  
   Contains all logic related to adaptive filtering, metrics and numeric safety:

   - `filter_runner.py` – unified interface to all adaptive algorithms  
   - `signal_generation.py` – synthetic signals for testing  
   - `metrics.py` – computing MSE, EMSE, J_min, misadjustment, SNR  
   - `fft_utils.py` – FFT magnitude computation  
   - `safety.py` – clamping, overflow protection, NaN/Inf handling  

   This layer abstracts padasip algorithms and ensures numerical stability.

3. **Graphical User Interface (src/gui/)**  
   - `main_window.py` – main control window  
   - `param_tuner.py` – advanced parameter editing dialog  
   - `canvases.py` – Matplotlib plots (time, error, MSE, FFT)

The modular structure allows replacing individual components without affecting others.

---

# 4. System Architecture
```
adaptive-filters/
│
├── src/
│ ├── app.py # Entry point, starts GUI
│ ├── config.py # Global presets, parameter limits
│ │
│ ├── filters/
│ │ ├── filter_runner.py # Unified wrapper for adaptive algorithms
│ │ ├── signal_generation.py
│ │ ├── metrics.py # MSE, EMSE, J_min, SNR, N90
│ │ ├── fft_utils.py
│ │ ├── safety.py # Numeric protections (clamping, NaN/Inf, overflow)
│ │ └── init.py
│ │
│ ├── gui/
│ ├── main_window.py # Main PyQt5 window
│ ├── param_tuner.py # Advanced parameter tuning dialog
│ ├── canvases.py # Matplotlib canvases (4-panel + FFT)
│ └── init.py
│
├── docs/images/ # Screenshots (user-added)
└── requirements.txt
```

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
