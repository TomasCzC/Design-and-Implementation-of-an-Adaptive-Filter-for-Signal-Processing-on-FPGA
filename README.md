# Design and Implementation of an Adaptive Filter for Signal Processing on FPGA

**Author:** Tomáš Běčák  
**Bachelor Thesis – VUT FEKT, Department of Radio Electronics (DREL)**  
**Academic year:** 2025/2026  
**Programming language:** Python 3.11  
**License:** MIT  

This repository contains a **software-based adaptive filter simulator** developed as a **reference and verification platform** for a bachelor thesis focused on adaptive signal processing on FPGA.

> [!IMPORTANT]
> The application was tested exclusively on **Windows 11**.
> Other operating systems are not officially supported or tested.

---

## 📌 Thesis Context

**Thesis title (CZ):**  
*Návrh a implementace adaptivního filtru pro zpracování signálu na FPGA*

The purpose of this project is **not** to replace the FPGA implementation, but to:

- verify adaptive algorithms in floating-point arithmetic,
- study convergence and numerical stability,
- evaluate algorithm suitability before fixed-point FPGA design,
- serve as a **golden reference model** for later hardware verification.

---

## 📑 Table of Contents
1. [Project Overview](#1-project-overview)
2. [Supported Adaptive Algorithms](#2-supported-adaptive-algorithms)
3. [Signal Types and Datasets](#3-signal-types-and-datasets)
4. [Installation](#4-installation)
5. [Running the Application](#5-running-the-application)
6. [How to Use the Application](#6-how-to-use-the-application)
7. [Visualization and Metrics](#7-visualization-and-metrics)
8. [Working with External Datasets](#8-working-with-external-datasets)
9. [Generating Figures for the Thesis](#9-generating-figures-for-the-thesis)
10. [AI Usage Declaration](#10-ai-usage-declaration)
11. [License](#11-license)
12. [Planned Extensions](#12-planned-extensions)

---

## 1. Project Overview

The application provides a **graphical user interface (GUI)** for experimenting with adaptive filters using:

- synthetic signals with known reference,
- biomedical signals (ECG),
- radio-frequency datasets (I/Q signals).

The simulator supports:
- time-domain visualization,
- frequency-domain (FFT) analysis,
- adaptive algorithm comparison,
- automatic numerical safety mechanisms.

---

## 2. Supported Adaptive Algorithms

Adaptive algorithms are implemented using the **padasip** library.

| Category | Algorithms |
|--------|-----------|
| LMS-based | LMS, NLMS, SSLMS |
| Recursive | RLS |
| Projection | AP (Affine Projection) |
| Robust / nonlinear | Llncosh, GMCC |
| Normalized gradient | GNGD |

Each algorithm supports:
- parameter presets,
- manual tuning,
- runtime stability validation.

---

## 3. Signal Types and Datasets

### 3.1 Synthetic Signals
Synthetic signals are generated internally and consist of:
- a clean sinusoidal reference signal,
- optional additive Gaussian noise,
- user-configurable sampling frequency and duration.

These signals are mainly intended for:
- algorithm comparison,
- convergence analysis,
- educational demonstrations.

---

### 3.2 ECG Signals (Biomedical)

> [!NOTE]
> ECG datasets are not included directly in this repository to avoid license restrictions.

Recommended public sources:
- MIT-BIH Arrhythmia Database  
  https://physionet.org/content/mitdb/
- Other PhysioNet ECG collections  
  https://physionet.org/

Downloaded datasets can be loaded via the GUI using WFDB or CSV format.

---

### 3.3 Radio / RF Signals (Experimental)

> [!WARNING]
> Radio-frequency (I/Q) signal support is experimental and intended mainly for future extensions.

The application supports loading user-provided HDF5 datasets containing complex I/Q samples.
No RF datasets are distributed with this repository.

---

## 4. Installation

This section describes how to obtain and install the application.
No prior experience with Git is required.

---

### 4.1 System Requirements

- Windows 10 or Windows 11
- Python 3.11 (recommended: Python 3.11.9)
- Internet connection (for installing dependencies)

---

### 4.2 Obtaining the Source Code

The source code can be obtained in two ways.

#### Option A – Download as ZIP (Recommended)

1. Open the project repository:  
   https://github.com/TomasCzC/Design-and-Implementation-of-an-Adaptive-Filter-for-Signal-Processing-on-FPGA

2. Click **Code → Download ZIP**

3. Extract the ZIP archive to a local directory.

---

#### Option B – Clone Using Git (Optional)

If Git is installed, the repository can be cloned using:

```bash
git clone https://github.com/TomasCzC/Design-and-Implementation-of-an-Adaptive-Filter-for-Signal-Processing-on-FPGA.git
```

---

### 4.3 Creating a Python Virtual Environment

```bash
python -m venv .venv
```

---

### 4.4 Activating the Virtual Environment (Windows PowerShell)

```bash
.\.venv\Scripts\Activate.ps1
```

If PowerShell script execution is blocked, allow it temporarily for the current session:

```bash
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope Process
```

---

### 4.5 Installing Python Dependencies

```bash
pip install -r requirements.txt
```

---

## 5 Running the Application

After successful installation and environment setup, the application can be launched.

---

### 5.1 Starting the Application (Recommended)

```bash
python -m src.app
```

---

### 5.2 Startup Behavior

> [!NOTE]
> On startup, no signal is selected automatically.
> A signal must be generated or loaded before running the adaptive filter.

After startup:
- the graphical user interface (GUI) is displayed,
- default algorithm parameters are loaded,
- the application is ready for user interaction.

---

### 5.3 Closing the application

The application can be safely closed using the standard window close button.
No files are modified and no data are saved automatically unless explicitly requested by the user

---

## 6. How to Use the Application

After launching the application, the user interacts with the simulator through a graphical user interface (GUI).
The typical workflow consists of the following steps.

---

### 6.1 Signal Source Selection

The simulator supports multiple signal sources:

#### Synthetic Signal
- Internally generated sinusoidal signal with optional additive noise
- Fully controllable parameters:
  - sampling frequency
  - signal frequency
  - duration
  - noise mean and variance
  - random seed
- Intended mainly for:
  - algorithm testing
  - convergence analysis
  - comparison of LMS-based methods

#### ECG Dataset
- Real biomedical signal
- Loaded from external files (WFDB or CSV)
- Used for:
  - noise suppression experiments
  - evaluation on real-world data
  - validation of adaptive filtering theory

#### Radio / RF Dataset (Experimental)
- Complex I/Q signals stored in HDF5 format
- Intended primarily for future extensions
- No datasets are included in this repository due to licensing constraints

---

### 6.2 Processing Mode Selection

The application supports multiple adaptive filtering scenarios:

#### System Identification
- The adaptive filter models an unknown system
- Output signal `y[n]` is the quantity of interest
- Error signal is used only as a convergence metric

#### Active Noise Cancellation (ANC)
- The adaptive filter estimates the noise component
- Error signal `e[n]` represents the cleaned (useful) signal
- Typical use case: ECG denoising

#### Relative / RCSE Mode
- Experimental mode for comparative filtering
- Used mainly for algorithm evaluation

---

### 6.3 Adaptive Algorithm Selection

The user can select one of the supported adaptive algorithms:
- LMS
- NLMS
- RLS
- AP
- SSLMS
- Llncosh
- GMCC
- GNGD

Each algorithm can be:
- selected via dedicated GUI buttons,
- configured using predefined parameter presets,
- manually tuned using sliders and input fields.

---

### 6.4 Parameter Configuration

Key configurable parameters include:
- filter order (number of taps),
- step size μ,
- regularization parameter ε,
- algorithm-specific parameters.

The application performs runtime parameter validation to:
- prevent numerical instability,
- avoid divergence,
- enforce known theoretical stability limits.

---

### 6.5 Running the Simulation

After configuring:
1. Signal source
2. Processing mode
3. Adaptive algorithm
4. Parameters

the simulation is started by pressing the **Run** button.

The application then:
- executes the adaptive filtering algorithm,
- updates all plots in real time,
- computes performance metrics.

---

## 7. Visualization and Metrics

### 7.1 Time-Domain Visualization

The GUI displays the following time-domain signals:
- Input signal
- Filter output
- Error signal
- Instantaneous mean square error (MSE)

The MSE plot is displayed using logarithmic scaling to better illustrate convergence behavior.

---

### 7.2 Frequency-Domain Analysis

The frequency-domain visualization includes:
- FFT magnitude of the input signal
- FFT magnitude of the output signal

A dedicated FFT legend panel is used instead of an in-plot legend to improve readability and consistency.

---

### 7.3 Computed Metrics

The following performance metrics are computed automatically:
- Mean Square Error (MSE)
- Excess Mean Square Error (EMSE)
- Minimum cost function value (J_min)
- Misadjustment
- Input Signal-to-Noise Ratio (SNR_in)
- Output Signal-to-Noise Ratio (SNR_out)
- Signal-to-noise ratio improvement (ΔSNR)
- 90% convergence time (N90)

These metrics are displayed numerically in the GUI.

---

## 8. Working with External Datasets

### 8.1 ECG Datasets

ECG datasets are not distributed with this repository to avoid license violations.

Recommended public sources include:
- MIT-BIH Arrhythmia Database  
  https://physionet.org/content/mitdb/
- Other PhysioNet ECG collections  
  https://physionet.org/

Downloaded datasets can be loaded via the GUI using the dataset loading dialog.

---

### 8.2 Radio / RF Datasets

Radio-frequency datasets are expected in HDF5 format containing complex I/Q samples.

Due to licensing and availability issues:
- no RF datasets are included,
- users are expected to provide their own datasets,
- RF support should be considered experimental.

---

## 9. Generating Figures for the Thesis

### 9.1 Recommended Workflow

For figures intended for inclusion in the bachelor thesis:

1. Use the built-in plot export functionality
2. Export plots as PNG images
3. Use high-resolution output (300 DPI or higher)

Screenshots of the GUI should be avoided.

---

### 9.2 Professional Figure Guidelines

To ensure publication-quality figures:
- use a white background,
- maintain consistent color coding (input = blue, output = red),
- include axis labels and units,
- ensure readability when printed.

If necessary, exported CSV data can be re-plotted using external tools (e.g., Python + Matplotlib) to produce vector graphics.

---

## 10. AI Usage Declaration

OpenAI ChatGPT was used exclusively as a programming assistant for:
- refactoring and organizing source code,
- GUI boilerplate generation,
- numerical safety mechanisms.

All algorithm selection, parameter tuning, result interpretation, and thesis writing were performed by the author.

---

## 11. License

This project is licensed under the MIT License.

---

## 12. Planned Extensions

Planned future extensions include:
- fixed-point adaptive filter simulation,
- FPGA-oriented architecture verification,
- VHDL implementation of selected algorithms,
- comparison between floating-point and fixed-point models,
- real-time communication between FPGA and PC.

---