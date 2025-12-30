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
6. [Design Decisions and Constraints](#6-design-decisions-and-constraints)
7. [Relation to Fixed-Point and FPGA Design](#7-relation-to-fixed-point-and-fpga-design)
8. [Reproducibility and Experimental Integrity](#8-reproducibility-and-experimental-integrity)
9. [User Manual and External Documentation](#9-user-manual-and-external-documentation)
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

### Project Structure

The repository is organized as follows:

```bash
Design-and-Implementation-of-an-Adaptive-Filter-for-Signal-Processing-on-FPGA/
├── src/
│ ├── app.py
│ ├── config.py
│ ├── filters/
│ │ ├── signal_generation.py
│ │ ├── filter_runner.py
│ │ ├── metrics.py
│ │ ├── fft_utils.py
│ │ └── safety.py
│ ├── signals/
│ │ ├── ecg_loader.py
│ │ ├── csv_loader.py
│ │ ├── radio_loader.py
│ │ └── signal_meta.py
│ └── gui/
│ ├── main_window.py
│ ├── param_tuner.py
│ ├── preview_window.py
│ └── load_signal_dialog.py
├── docs/
│ └── images/
├── requirements.txt
└── README.md
```

---

### 🔗 Klikací odkazy na klíčové soubory

**Application entry point**
- [`src/app.py`](src/app.py)

**Configuration**
- [`src/config.py`](src/config.py)

**Adaptive filtering core**
- [`src/filters/filter_runner.py`](src/filters/filter_runner.py)
- [`src/filters/signal_generation.py`](src/filters/signal_generation.py)
- [`src/filters/metrics.py`](src/filters/metrics.py)
- [`src/filters/fft_utils.py`](src/filters/fft_utils.py)
- [`src/filters/safety.py`](src/filters/safety.py)

**Signal loaders**
- [`src/signals/ecg_loader.py`](src/signals/ecg_loader.py)
- [`src/signals/csv_loader.py`](src/signals/csv_loader.py)
- [`src/signals/radio_loader.py`](src/signals/radio_loader.py)
- [`src/signals/signal_meta.py`](src/signals/signal_meta.py)

**Graphical User Interface**
- [`src/gui/canvases.py`](src/gui/canvases.py)
- [`src/gui/dataset_controller.py`](src/gui/dataset_controller.py)
- [`src/gui/load_signal_dialog.py`](src/gui/load_signal_dialog.py)
- [`src/gui/main_window.py`](src/gui/main_window.py)
- [`src/gui/main_window.ui`](src/gui/main_window.ui)
- [`src/gui/param_tuner.py`](src/gui/param_tuner.py)
- [`src/gui/preview_window.py`](src/gui/preview_window.py)

> [!NOTE]
> A loading dialog component is present in the codebase but is currently not used.
> It is intended for future extensions involving long-running operations.
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

## 6. Design Decisions and Constraints

The software architecture reflects constraints that are relevant for later FPGA implementation.

Key design decisions visible directly in the codebase include:

- strict separation between signal preparation and adaptive filtering,
- explicit construction of input data matrices (tap-delay lines),
- avoidance of implicit normalization inside the adaptive algorithms,
- centralized enforcement of numerical stability constraints.

> [!NOTE]
> These decisions intentionally trade execution speed for **traceability and correctness**,
> which is essential when comparing floating-point and fixed-point behavior.

The simulator is therefore designed as an **engineering reference**, not as a real-time DSP tool.


---

## 7. Relation to Fixed-Point and FPGA Design

Although this repository implements only floating-point processing, its structure
directly supports a future fixed-point and FPGA-oriented workflow.

From a code perspective:

- `hist_input()` corresponds to a shift-register-based tap structure,
- runtime stability limits reflect known theoretical bounds used in hardware design,
- metric evaluation mirrors quantities typically monitored during FPGA verification.

> [!IMPORTANT]
> The software does **not** attempt to emulate fixed-point arithmetic.
> Its role is to provide a **numerically ideal reference** against which fixed-point
> implementations can be evaluated.

This separation avoids mixing algorithmic behavior with quantization effects.


---

## 8. Reproducibility and Experimental Integrity

All experiments performed using this simulator are designed to be reproducible.

This is ensured by:

- deterministic synthetic signal generation,
- explicit random seed handling,
- absence of hidden preprocessing steps,
- consistent handling of dataset signals across processing modes.

> [!NOTE]
> No internal state is preserved between runs unless explicitly controlled by the user.
> Each simulation represents an independent experiment.

This approach aligns with academic requirements for transparent experimental evaluation.


---

## 9. User Manual and External Documentation

A detailed **user-oriented manual** describing the graphical interface and application workflow
is provided as a **separate PDF document**.

> [!IMPORTANT]
> The PDF manual is **not part of the bachelor thesis assignment**.
> It is provided as a **non-mandatory, extra document** for usability and clarity.

📄 **User Manual (PDF):**  
[`SP_návod.pdf`](src/assets/docs/SP_návod.pdf)

The README intentionally avoids duplicating information from the manual and focuses instead on:
- architectural intent,
- algorithmic structure,
- design rationale relevant to the thesis.

---

## 10. AI Usage Declaration

AI tools were used **exclusively as a programming assistant** for:

- code refactoring,
- GUI boilerplate generation,
- documentation structuring.

The **user manual (PDF)** was generated with AI assistance as a **non-mandatory, extra deliverable** and is not part of the thesis assignment.

All engineering decisions, algorithm selection, parameter studies,
and result interpretation were performed by the author.

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