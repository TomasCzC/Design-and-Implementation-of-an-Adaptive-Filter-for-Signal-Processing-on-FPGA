# Adaptive Filter for Signal Processing on FPGA

This repository contains materials related to a semestral project and bachelor thesis focused on adaptive filtering, digital signal processing, and FPGA-based implementation.

The work is divided into two main parts:

```text
.
├── semestral_project/
└── bachelor_thesis/
```

## Project Description

The goal of this project is to study, model, implement, and verify adaptive filtering techniques for signal processing applications, with a long-term focus on FPGA-based implementation.

The project starts with a software-oriented semestral project, where adaptive filtering algorithms are studied, simulated, and compared using Python. This part provides the theoretical and algorithmic foundation for the following hardware-oriented work.

The bachelor thesis continues this work by moving toward an FPGA implementation of an adaptive filter. The target system is based on a MicroBlaze embedded processor, Ethernet communication, UDP data transfer, and an HDL implementation of the LMS adaptive filtering core.

The repository is maintained as a technical and reproducibility-oriented project. It contains materials needed to describe the theory, document the implementation, verify individual functional blocks, and present the current technical state of the work.

## Repository Structure

### `semestral_project/`

The `semestral_project` directory contains the work developed during the winter semester.

This part of the project focuses mainly on the theoretical background, software modelling, simulation, and comparison of adaptive filtering algorithms. The implementation is based on Python and is used as a reference model for later hardware-oriented work.

Main topics covered in this part:

- adaptive filtering theory,
- LMS, NLMS, and RLS algorithms,
- Python-based simulation model,
- synthetic and real signal processing,
- evaluation using error and signal quality metrics,
- preparation for future FPGA implementation.

This part represents the initial and successfully completed stage of the project.

### `bachelor_thesis/`

The `bachelor_thesis` directory contains the continuation of the work toward FPGA-based implementation.

This part focuses on the design and implementation of an adaptive filter for signal processing on an FPGA platform. The target architecture is based on a MicroBlaze-based embedded system, Ethernet communication, UDP data transfer, and an HDL implementation of the LMS filtering core.

Main topics covered in this part:

- FPGA system architecture,
- LMS adaptive filter core,
- fixed-point Q16.16 representation,
- Ethernet communication using lwIP and UDP,
- MicroBlaze firmware integration,
- Python reference model and PC-side communication,
- verification and reproducibility of the implementation.

The bachelor thesis part is maintained as a technical and reproducibility-oriented revision of the implementation. The goal is to document the system architecture, verify individual functional blocks, and provide clear evidence for the defense of the work.

## Project Status

| Part | Status | Description |
| --- | --- | --- |
| Semestral project | Completed | Software model, simulations, and algorithm comparison |
| Bachelor thesis | Under revision | FPGA implementation, documentation, verification, and defense preparation |

## Technical Scope

The overall project combines software modelling and hardware-oriented implementation of adaptive filtering algorithms.

The main technical areas are:

- digital signal processing,
- adaptive FIR filtering,
- LMS algorithm,
- Python simulation,
- fixed-point arithmetic,
- FPGA implementation,
- MicroBlaze embedded system,
- AXI-based data transfer,
- Ethernet and UDP communication,
- verification of numerical results.

## Notes on the Bachelor Thesis Revision

The `bachelor_thesis/` directory does not represent only a static archive of the originally submitted files. It is used to organize the current technical state of the project, including corrections, additional documentation, verification outputs, and reproducibility improvements.

The purpose of this revision is not to hide limitations of the original submission, but to make the implementation transparent, reproducible, and technically verifiable.

## Suggested Directory Layout

```text
semestral_project/
├── README.md
├── src/
├── presentation/
├── text/
├── simulations/
└── results/

bachelor_thesis/
├── README.md
├── fpga/
├── firmware/
├── python/
├── presentation/
├── text/
├── verification/
├── results/
└── revision/
```

## Main Goal

The long-term goal of the project is to design, implement, and verify an adaptive filtering system suitable for FPGA-based signal processing.

The semestral project provides the algorithmic and simulation foundation. The bachelor thesis extends this foundation toward hardware implementation and system-level verification.
