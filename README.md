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
- [9. Theory Background](#9-theory-background)
- [10. Example Outputs](#10-example-outputs)
- [11. AI Usage Declaration](#11-ai-usage-declaration)
- [12. License](#12-license)
- [13. Planned Extensions](#13-planned-extensions)

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
- Create a **modular**, **readable**, and **testable** adaptive filter framework.
- Provide a **PyQt5 GUI** for interactive experimentation.
- Implement **numerically stable execution** (safe mode).
- Enable **software verification** of adaptive filter behaviour before FPGA implementation.
- Offer **metrics** relevant for academic evaluation (MSE, EMSE, misadjustment, SNR).

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

Each algorithm includes parameter presets and stability constraints.

---

