# Adaptive Filter for Signal Processing on FPGA

This repository contains materials related to a semestral project and bachelor thesis focused on adaptive filtering, digital signal processing, and FPGA-based implementation.

Tento repozitář obsahuje materiály související se semestrálním projektem a bakalářskou prací zaměřenou na adaptivní filtraci, digitální zpracování signálů a implementaci na FPGA.

---

## Branch Notice / Poznámka k větvi

This branch was created after the submission of the bachelor thesis as additional technical material for the thesis defense.

The text of the bachelor thesis and the originally submitted electronic attachment were not modified after submission. The purpose of this branch is to demonstrate the functionality of the design, improve the reproducibility of the project, and prepare validation outputs for the defense.

Tato větev vznikla po odevzdání bakalářské práce jako doplňkový technický podklad k obhajobě.

Text bakalářské práce ani původně odevzdaná elektronická příloha nebyly po odevzdání měněny. Cílem této větve je doložit funkčnost návrhu, opravit reprodukovatelnost projektu a připravit validační výstupy pro obhajobu.

---

## English Version

## Project Description

The goal of this project is to study, model, implement, and verify adaptive filtering techniques for signal processing applications, with a long-term focus on FPGA-based implementation.

The work is divided into two main parts:

```text
.
├── semestral_project/
└── bachelor_thesis/
```

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

---

## Česká verze

## Popis projektu

Cílem tohoto projektu je nastudovat, modelovat, implementovat a ověřit techniky adaptivní filtrace pro aplikace zpracování signálů, s dlouhodobým zaměřením na implementaci na FPGA.

Práce je rozdělena do dvou hlavních částí:

```text
.
├── semestral_project/
└── bachelor_thesis/
```

Projekt začíná softwarově orientovaným semestrálním projektem, ve kterém jsou adaptivní filtrační algoritmy studovány, simulovány a porovnávány pomocí jazyka Python. Tato část tvoří teoretický a algoritmický základ pro navazující hardwarově orientovanou práci.

Bakalářská práce na tento základ navazuje a rozšiřuje projekt směrem k implementaci adaptivního filtru na FPGA. Cílový systém je založen na vestavném procesoru MicroBlaze, ethernetové komunikaci, přenosu dat pomocí UDP a HDL implementaci adaptivního filtračního jádra LMS.

Repozitář je udržován jako technicky a reprodukovatelně orientovaný projekt. Obsahuje materiály potřebné k popisu teorie, dokumentaci implementace, ověření jednotlivých funkčních bloků a prezentaci aktuálního technického stavu práce.

## Struktura repozitáře

### `semestral_project/`

Adresář `semestral_project` obsahuje práci vytvořenou během zimního semestru.

Tato část projektu se zaměřuje především na teoretické pozadí, softwarové modelování, simulace a porovnání adaptivních filtračních algoritmů. Implementace je založena na jazyce Python a slouží jako referenční model pro pozdější hardwarově orientovanou práci.

Hlavní témata této části:

- teorie adaptivní filtrace,
- algoritmy LMS, NLMS a RLS,
- simulační model v Pythonu,
- zpracování syntetických a reálných signálů,
- vyhodnocení pomocí chybových metrik a metrik kvality signálu,
- příprava pro budoucí implementaci na FPGA.

Tato část představuje počáteční a úspěšně dokončenou fázi projektu.

### `bachelor_thesis/`

Adresář `bachelor_thesis` obsahuje pokračování práce směrem k implementaci na FPGA.

Tato část se zaměřuje na návrh a implementaci adaptivního filtru pro zpracování signálů na platformě FPGA. Cílová architektura je založena na vestavném systému s procesorem MicroBlaze, ethernetové komunikaci, přenosu dat pomocí UDP a HDL implementaci filtračního jádra LMS.

Hlavní témata této části:

- architektura FPGA systému,
- adaptivní filtrační jádro LMS,
- pevná řádová čárka ve formátu Q16.16,
- ethernetová komunikace pomocí lwIP a UDP,
- integrace firmwaru pro MicroBlaze,
- referenční model v Pythonu a komunikace na straně PC,
- ověření a reprodukovatelnost implementace.

Část bakalářské práce je udržována jako technicky a reprodukovatelně orientovaná revize implementace. Cílem je zdokumentovat architekturu systému, ověřit jednotlivé funkční bloky a poskytnout jasné technické podklady pro obhajobu práce.

## Stav projektu

| Část | Stav | Popis |
| --- | --- | --- |
| Semestrální projekt | Dokončeno | Softwarový model, simulace a porovnání algoritmů |
| Bakalářská práce | V revizi | Implementace na FPGA, dokumentace, ověření a příprava k obhajobě |

## Technický rozsah

Celý projekt kombinuje softwarové modelování a hardwarově orientovanou implementaci adaptivních filtračních algoritmů.

Hlavní technické oblasti jsou:

- digitální zpracování signálů,
- adaptivní FIR filtrace,
- algoritmus LMS,
- simulace v Pythonu,
- aritmetika s pevnou řádovou čárkou,
- implementace na FPGA,
- vestavný systém MicroBlaze,
- přenos dat přes AXI,
- ethernetová a UDP komunikace,
- ověření numerických výsledků.

## Poznámky k revizi bakalářské práce

Adresář `bachelor_thesis/` nepředstavuje pouze statický archiv původně odevzdaných souborů. Slouží k organizaci aktuálního technického stavu projektu, včetně oprav, doplňující dokumentace, výstupů ověření a zlepšení reprodukovatelnosti.

Účelem této revize není zakrývat omezení původní verze, ale zpřehlednit implementaci a učinit ji transparentní, reprodukovatelnou a technicky ověřitelnou.

## Doporučená struktura adresářů

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

## Hlavní cíl

Dlouhodobým cílem projektu je navrhnout, implementovat a ověřit adaptivní filtrační systém vhodný pro zpracování signálů na FPGA.

Semestrální projekt poskytuje algoritmický a simulační základ. Bakalářská práce tento základ rozšiřuje směrem k hardwarové implementaci a systémovému ověření.
