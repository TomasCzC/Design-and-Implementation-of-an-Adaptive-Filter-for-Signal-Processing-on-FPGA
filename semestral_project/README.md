# Adaptive Filter for Signal Processing on FPGA

<p align="center">
  <strong>Semestral Project – Software Model of Adaptive Filters</strong><br>
  <strong>Semestrální práce – softwarový model adaptivních filtrů</strong>
</p>

<p align="center">
  Brno University of Technology · Faculty of Electrical Engineering and Communication · Department of Radio Electronics<br>
  Vysoké učení technické v Brně · Fakulta elektrotechniky a komunikačních technologií · Ústav radioelektroniky
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Language-Python%203.11-informational" alt="Python">
  <img src="https://img.shields.io/badge/GUI-PyQt5-informational" alt="PyQt5">
  <img src="https://img.shields.io/badge/DSP-padasip-informational" alt="padasip">
  <img src="https://img.shields.io/badge/Signals-CSV%20%7C%20WFDB%20%7C%20HDF5-informational" alt="Signal formats">
  <img src="https://img.shields.io/badge/Algorithms-LMS%20%7C%20NLMS%20%7C%20RLS-informational" alt="Algorithms">
  <img src="https://img.shields.io/badge/Status-Semestral%20project-yellow" alt="Status">
</p>

---

## Language / Jazyk

- [English version](#english-version)
- [Česká verze](#česká-verze)

---

# English Version

## 1. Project Description

This directory contains the software part of the semestral project **“Design and Implementation of an Adaptive Filter for Signal Processing on FPGA”**.

The semestral project focuses on the theoretical background of adaptive filtering, the design of the future system architecture, and the software verification of selected adaptive filtering algorithms. This part of the project does not represent a complete FPGA implementation. Instead, it serves as a reference simulation environment for testing and comparing adaptive algorithms before their later hardware implementation.

The application is implemented in Python and provides a graphical user interface for signal generation, signal loading, adaptive filtering, visualization, and evaluation of results. It allows experiments with synthetic harmonic signals, electrocardiographic signals, CSV data, and radio signal datasets stored in HDF5 format.

The main purpose of this part is to create a reliable software model that can be used as a reference for the following bachelor thesis, where the selected algorithm is intended to be implemented on an FPGA platform.

---

## 2. Relation to the Semestral Project

The semestral project covers mainly the following tasks:

- research of adaptive filters and adaptive algorithms,
- software simulation of selected adaptive algorithms,
- verification of filter behavior on test signals,
- comparison of LMS, NLMS, RLS, and related algorithms,
- preparation of a software reference model for later FPGA implementation,
- definition of the next steps toward the bachelor thesis.

This project is therefore a **software-oriented preliminary stage of the FPGA implementation**. The main output is not an FPGA bitstream, but a simulation application that makes it possible to test, compare, and evaluate adaptive filtering algorithms under repeatable conditions.

---

## 3. Basic Information

| Item | Value |
| --- | --- |
| Author | Tomáš Běčák |
| Institution | Brno University of Technology |
| Faculty | Faculty of Electrical Engineering and Communication |
| Department | Department of Radio Electronics |
| Work type | Semestral project |
| Czech title | Návrh a implementace adaptivního filtru pro zpracování signálu na FPGA |
| English title | Design and Implementation of an Adaptive Filter for Signal Processing on FPGA |
| Supervisor | doc. Ing. Tomáš Frýza, Ph.D. |
| Programming language | Python 3.11 |
| Graphical interface | PyQt5 |
| Adaptive filtering library | padasip |
| Visualization | PyQtGraph, Matplotlib |
| Supported data | synthetic signal, CSV, WFDB, HDF5 |
| Main algorithms | LMS, NLMS, RLS |
| Additional algorithms | AP, SSLMS, Llncosh, GMCC, GNGD |
| Project output | software model and simulation application |
| Follow-up work | preparation for FPGA implementation |

---

## 4. Directory Structure

The `src` directory is organized according to the functional parts of the application.

```text
src/
├── assets/
├── filters/
│   ├── __init__.py
│   ├── fft_utils.py
│   ├── filter_runner.py
│   ├── metrics.py
│   ├── safety.py
│   └── signal_generation.py
├── gui/
│   ├── __init__.py
│   ├── canvases.py
│   ├── dataset_controller.py
│   ├── load_signal_dialog.py
│   ├── loading_dialog.py
│   ├── main_window.py
│   ├── main_window.ui
│   ├── param_tuner.py
│   └── preview_window.py
├── signals/
│   ├── __init__.py
│   ├── csv_loader.py
│   ├── ecg_loader.py
│   ├── radio_loader.py
│   └── signal_meta.py
├── __init__.py
├── app.py
└── config.py
```

| Path | Description |
| --- | --- |
| `src/app.py` | main application entry point |
| `src/config.py` | default algorithm parameters, limits, and presets |
| `src/filters/` | adaptive filtering, FFT, metrics, and signal generation |
| `src/gui/` | graphical user interface |
| `src/signals/` | loading of CSV, WFDB, and HDF5 signals |
| `src/assets/` | supporting GUI files and assets |

---

## 5. Running the Application

### 5.1 Installing Dependencies

It is recommended to use a separate virtual environment.

```bash
python -m venv .venv
```

Activate the environment on Windows:

```bash
.venv\Scripts\activate
```

Activate the environment on Linux or macOS:

```bash
source .venv/bin/activate
```

Install the required packages:

```bash
pip install -r requirements.txt
```

The `requirements.txt` file contains mainly:

```text
numpy
scipy
pyqt5
pyqtgraph
padasip
wfdb
h5py
```

### 5.2 Starting the Application

The application should be started from the root directory of the repository:

```bash
python -m src.app
```

Alternatively, it can be started directly:

```bash
python src/app.py
```

The recommended method is `python -m src.app`, because it preserves correct package imports inside the `src` package.

---

## 6. Application Overview

The application provides a graphical environment for experimental verification of adaptive filters. The user can select an input signal, choose an adaptive algorithm, set filter parameters, run the filtering process, and evaluate the results.

The application displays:

- input and reference signals,
- filter output,
- error signal,
- MSE behavior,
- spectral characteristics,
- calculated quality metrics.

The basic processing flow is:

```text
signal loading or generation
        ↓
creation of delayed input vectors
        ↓
execution of the selected adaptive algorithm
        ↓
calculation of y(n), e(n), and w(n)
        ↓
metric calculation
        ↓
visualization of results in the GUI
```

The application is designed to make different algorithms comparable on the same input data and with repeatable parameter settings.

---

## 7. Supported Algorithms

Algorithm configuration is stored in `src/config.py`.

| Algorithm | Description |
| --- | --- |
| LMS | Least Mean Squares |
| NLMS | Normalized Least Mean Squares |
| RLS | Recursive Least Squares |
| AP | Affine Projection |
| SSLMS | Sign-Sign LMS / signed LMS variant |
| Llncosh | adaptive algorithm using a nonlinear error function |
| GMCC | Generalized Maximum Correntropy Criterion |
| GNGD | Generalized Normalized Gradient Descent |

The main algorithms of the semestral project are LMS, NLMS, and RLS. The remaining algorithms are included as extensions for broader experimental comparison.

---

## 8. Default Algorithm Parameters

Default parameter values are defined in `src/config.py`.

| Algorithm | Default parameters |
| --- | --- |
| LMS | `mu = 0.01` |
| NLMS | `mu = 0.8`, `eps = 1e-3` |
| RLS | `mu = 0.99`, `eps = 0.1` |
| AP | `mu = 0.05`, `order = 3`, `ifc = 1e-3` |
| SSLMS | `mu = 0.01` |
| Llncosh | `mu = 0.01`, `lambd = 0.1` |
| GMCC | `mu = 0.01`, `lambd = 0.05`, `alpha = 2.0` |
| GNGD | `mu = 0.01`, `eps = 0.1`, `ro = 1e-4` |

The configuration also contains parameter limits. These limits help prevent values that could lead to numerically unstable or unsuitable algorithm behavior.

---

## 9. Input Signals

The application supports several types of input signals.

### 9.1 Synthetic Harmonic Signal

The synthetic signal is generated as a sinusoidal waveform with optional additive noise.

| Parameter | Description |
| --- | --- |
| `fs` | sampling frequency |
| `f0` | sine wave frequency |
| `T` | signal duration |
| `noise_mean` | mean value of noise |
| `noise_std` | standard deviation of noise |
| `seed` | random generator seed |

If the noise parameters are set to zero, the input signal is generated as an exact copy of the reference signal. This makes it possible to test the algorithms under ideal conditions.

### 9.2 CSV Signal

The CSV loader supports the following basic formats:

| CSV format | Interpretation |
| --- | --- |
| one column | signal amplitude |
| two columns | time and amplitude |
| three or more columns | I/Q components or extended data record |

For the two-column format, the sampling frequency is estimated from the difference between neighboring time samples.

### 9.3 ECG Signal

ECG signals are loaded using the WFDB library. The loader is intended for records stored in a format commonly used by PhysioNet-style databases.

The first signal channel and the sampling frequency stored in the record are used.

### 9.4 Radio Signal in HDF5 Format

Radio signal data are loaded from an HDF5 file. The loader expects a dataset field `X` containing I/Q components and a field `Y` containing sample class labels.

The amplitude is calculated from the I/Q components:

```text
x = sqrt(I^2 + Q^2)
```

The resulting one-dimensional signal is then used as input for adaptive filtering.

---

## 10. Evaluated Quantities

The application calculates several metrics describing the quality of adaptation.

| Metric | Description |
| --- | --- |
| `MSE` | mean squared error in the steady-state part of the signal |
| `EMSE` | excess mean squared error |
| `J_min` | estimate of the minimum achievable error |
| `Misadjustment` | relative deviation from the minimum error |
| `SNR_in` | input signal-to-noise ratio |
| `SNR_out` | output signal-to-noise ratio |
| `ΔSNR` | SNR change after filtering |
| `n90` | approximate index of convergence to steady state |

The metrics are calculated from time-aligned vectors of the input signal, reference signal, output signal, and error signal.

---

## 11. Spectral Analysis

Frequency-domain evaluation is performed using the Fast Fourier Transform. The spectrum calculation is implemented in `src/filters/fft_utils.py`.

The output consists of:

- frequency axis,
- amplitude spectrum of the signal.

FFT analysis is used to compare spectral components before and after filtering, especially when testing suppression of harmonic or narrowband interference.

---

## 12. Graphical User Interface

The graphical user interface is implemented using PyQt5. The main application window is defined in `src/gui/main_window.py`, and the related layout is stored in `src/gui/main_window.ui`.

The GUI provides:

- input signal selection,
- filter parameter settings,
- adaptive algorithm selection,
- filtering execution,
- time-domain visualization,
- error signal visualization,
- spectral visualization,
- preview of loaded signals.

The main entry point of the application is `src/app.py`.

---

## 13. Implementation Status

This checklist is intended for tracking the revision of the semestral software model.

### 13.1 Application Base

- [ ] The application starts using `python -m src.app`.
- [ ] Package imports work correctly from the repository root.
- [ ] The virtual environment can be created using `requirements.txt`.
- [ ] The GUI opens without import errors.
- [ ] The main window is connected with `main_window.ui`.

### 13.2 Adaptive Algorithms

- [ ] LMS can be executed on a synthetic signal.
- [ ] NLMS can be executed on a synthetic signal.
- [ ] RLS can be executed on a synthetic signal.
- [ ] AP can be executed on a synthetic signal.
- [ ] SSLMS can be executed on a synthetic signal.
- [ ] Llncosh can be executed on a synthetic signal.
- [ ] GMCC can be executed on a synthetic signal.
- [ ] GNGD can be executed on a synthetic signal.
- [ ] Parameter limits prevent obvious numerical divergence.
- [ ] Algorithm results are comparable on the same input signal.

### 13.3 Input Data

- [ ] A synthetic sine signal can be generated with optional noise.
- [ ] A one-column CSV signal can be loaded.
- [ ] A CSV signal in time-amplitude format can be loaded.
- [ ] An ECG signal can be loaded using WFDB.
- [ ] An HDF5 radio dataset can be loaded using `h5py`.
- [ ] The expected data structure is documented for each input type.

### 13.4 Evaluation

- [ ] The application calculates MSE.
- [ ] The application calculates EMSE.
- [ ] The application calculates misadjustment.
- [ ] The application calculates input and output SNR.
- [ ] The application calculates SNR improvement.
- [ ] The application displays time-domain waveforms.
- [ ] The application displays the error signal.
- [ ] The application displays the spectrum using FFT.
- [ ] Results can be exported or documented for the semestral project.

---

## 14. Limitations of This Project Part

This part of the project has several intentional limitations:

- it does not contain a complete FPGA implementation,
- it does not contain a VHDL or Verilog filter core,
- it does not implement real Ethernet transfer to an FPGA board,
- it does not use fixed-point arithmetic intended for hardware synthesis,
- it serves mainly as a software reference model,
- the results are intended primarily for algorithm comparison and preparation of the following FPGA-oriented work.

These limitations correspond to the scope of the semestral project, which focuses mainly on theoretical preparation, system design, and simulation-based verification.

---

## 15. Connection to the Bachelor Thesis

The outputs of this semestral project serve as a basis for the following bachelor thesis.

| Semestral project | Bachelor thesis |
| --- | --- |
| Python model of LMS/NLMS/RLS | selection of an algorithm suitable for FPGA |
| MSE and SNR metrics | quantitative verification of filtering |
| test signal generation | preparation of test vectors |
| FFT analysis in Python | spectral evaluation of results |
| loading of ECG/HDF5/CSV data | work with real data |
| GUI for experiments | PC-side application for FPGA communication |

For the hardware implementation, the LMS algorithm is considered the primary candidate because of its low computational complexity and direct implementation using multiplication and accumulation operations.

---

## 16. Recommended Use for Result Documentation

When preparing the semestral project documentation, it is recommended to include:

- input signal configuration,
- selected algorithm and its parameters,
- time-domain plot of the input, reference, and output signals,
- error signal behavior,
- MSE behavior,
- spectral comparison,
- metric table for LMS, NLMS, and RLS.

Recommended minimum set of outputs:

```text
doc/sp_results/lms_sine_time.png
doc/sp_results/lms_sine_mse.png
doc/sp_results/lms_sine_fft.png
doc/sp_results/nlms_sine_time.png
doc/sp_results/rls_sine_time.png
doc/sp_results/algorithm_comparison.csv
```

---

## 17. Citation and References

### 17.1 Semestral Project

BĚČÁK, Tomáš. **Návrh a implementace adaptivního filtru pro zpracování signálu na FPGA**. Semestral project. Brno: Brno University of Technology, Faculty of Electrical Engineering and Communication, Department of Radio Electronics, 2025/2026.

### 17.2 Used Software Libraries

- padasip: adaptive signal processing algorithms  
  https://github.com/matousc89/padasip

- NumPy: numerical computing  
  https://numpy.org/

- SciPy: scientific computing  
  https://scipy.org/

- PyQt5: Python bindings for Qt  
  https://pypi.org/project/PyQt5/

- PyQtGraph: scientific graphics and GUI plotting  
  https://www.pyqtgraph.org/

- WFDB Python package  
  https://wfdb.readthedocs.io/

- h5py: HDF5 for Python  
  https://www.h5py.org/

### 17.3 Technical Literature

- HAYKIN, Simon. **Adaptive Filter Theory**. Pearson.
- WIDROW, Bernard; STEARNS, Samuel D. **Adaptive Signal Processing**. Prentice-Hall.
- PROAKIS, John G.; MANOLAKIS, Dimitris G. **Digital Signal Processing: Principles, Algorithms, and Applications**. Pearson.

---

## 18. Summary

The `src` directory contains a software simulation tool for comparing adaptive filters. The application is intended for the semestral part of the project and serves as a reference environment before the following FPGA implementation.

The main processing chain is:

```text
test signal
    → adaptive filter
    → error signal
    → quality metrics
    → time-domain and frequency-domain evaluation
```

This project creates the foundation for the next phase, where the selected adaptive algorithm can be converted to fixed-point representation and implemented as a hardware block on FPGA.

---

# Česká verze

## 1. Popis projektu

Tento adresář obsahuje softwarovou část semestrální práce **„Návrh a implementace adaptivního filtru pro zpracování signálu na FPGA“**.

Semestrální práce je zaměřena na teoretické zpracování adaptivních filtrů, návrh budoucí architektury systému a softwarové ověření vybraných adaptivních filtračních algoritmů. Tato část projektu nepředstavuje kompletní implementaci na FPGA. Slouží jako referenční simulační prostředí pro testování a porovnávání adaptivních algoritmů před jejich pozdější hardwarovou realizací.

Aplikace je implementována v jazyce Python a obsahuje grafické uživatelské rozhraní pro generování signálů, načítání dat, adaptivní filtraci, vizualizaci a vyhodnocení výsledků. Umožňuje experimentovat se syntetickým harmonickým signálem, elektrokardiografickými signály, daty ve formátu CSV a rádiovými datasety uloženými ve formátu HDF5.

Hlavním účelem této části je vytvořit spolehlivý softwarový model, který může sloužit jako reference pro navazující bakalářskou práci, ve které je vybraný algoritmus určen k implementaci na platformě FPGA.

---

## 2. Vztah k semestrální práci

V rámci semestrální práce jsou řešeny především tyto úlohy:

- rešerše adaptivních filtrů a adaptivních algoritmů,
- softwarová simulace vybraných adaptivních algoritmů,
- ověření chování filtrů na testovacích signálech,
- porovnání algoritmů LMS, NLMS, RLS a příbuzných metod,
- příprava softwarového referenčního modelu pro pozdější implementaci na FPGA,
- definice dalšího postupu směrem k bakalářské práci.

Projekt je proto koncipován jako **softwarový předstupeň FPGA implementace**. Hlavním výstupem není bitstream pro FPGA, ale simulační aplikace, která umožňuje testovat, porovnávat a vyhodnocovat adaptivní filtrační algoritmy za opakovatelných podmínek.

---

## 3. Základní údaje

| Položka | Hodnota |
| --- | --- |
| Autor | Tomáš Běčák |
| Instituce | Vysoké učení technické v Brně |
| Fakulta | Fakulta elektrotechniky a komunikačních technologií |
| Ústav | Ústav radioelektroniky |
| Typ práce | Semestrální práce |
| Český název | Návrh a implementace adaptivního filtru pro zpracování signálu na FPGA |
| Anglický název | Design and Implementation of an Adaptive Filter for Signal Processing on FPGA |
| Vedoucí práce | doc. Ing. Tomáš Frýza, Ph.D. |
| Programovací jazyk | Python 3.11 |
| Grafické rozhraní | PyQt5 |
| Knihovna pro adaptivní filtraci | padasip |
| Vizualizace | PyQtGraph, Matplotlib |
| Podporovaná data | syntetický signál, CSV, WFDB, HDF5 |
| Hlavní algoritmy | LMS, NLMS, RLS |
| Doplňkové algoritmy | AP, SSLMS, Llncosh, GMCC, GNGD |
| Výstup projektu | softwarový model a simulační aplikace |
| Návaznost | příprava pro implementaci na FPGA |

---

## 4. Struktura adresáře

Adresář `src` je rozdělen podle funkčních částí aplikace.

```text
src/
├── assets/
├── filters/
│   ├── __init__.py
│   ├── fft_utils.py
│   ├── filter_runner.py
│   ├── metrics.py
│   ├── safety.py
│   └── signal_generation.py
├── gui/
│   ├── __init__.py
│   ├── canvases.py
│   ├── dataset_controller.py
│   ├── load_signal_dialog.py
│   ├── loading_dialog.py
│   ├── main_window.py
│   ├── main_window.ui
│   ├── param_tuner.py
│   └── preview_window.py
├── signals/
│   ├── __init__.py
│   ├── csv_loader.py
│   ├── ecg_loader.py
│   ├── radio_loader.py
│   └── signal_meta.py
├── __init__.py
├── app.py
└── config.py
```

| Cesta | Význam |
| --- | --- |
| `src/app.py` | vstupní bod aplikace |
| `src/config.py` | výchozí parametry algoritmů, limity a předvolby |
| `src/filters/` | adaptivní filtrace, FFT, metriky a generování signálů |
| `src/gui/` | grafické uživatelské rozhraní |
| `src/signals/` | načítání signálů z CSV, WFDB a HDF5 |
| `src/assets/` | podpůrné soubory a grafické prvky aplikace |

---

## 5. Spuštění aplikace

### 5.1 Instalace závislostí

Doporučený postup je vytvořit samostatné virtuální prostředí.

```bash
python -m venv .venv
```

Aktivace prostředí ve Windows:

```bash
.venv\Scripts\activate
```

Aktivace prostředí v Linuxu nebo macOS:

```bash
source .venv/bin/activate
```

Instalace požadovaných knihoven:

```bash
pip install -r requirements.txt
```

Soubor `requirements.txt` obsahuje zejména:

```text
numpy
scipy
pyqt5
pyqtgraph
padasip
wfdb
h5py
```

### 5.2 Spuštění aplikace

Aplikace se spouští z kořenového adresáře repozitáře:

```bash
python -m src.app
```

Alternativně lze použít přímé spuštění:

```bash
python src/app.py
```

Doporučená varianta je `python -m src.app`, protože zachovává správné importy uvnitř balíčku `src`.

---

## 6. Popis aplikace

Aplikace poskytuje grafické prostředí pro experimentální ověření adaptivních filtrů. Uživatel může zvolit vstupní signál, vybrat adaptační algoritmus, nastavit parametry filtru, spustit filtraci a následně vyhodnotit výsledky.

Aplikace zobrazuje:

- vstupní a referenční signál,
- výstup filtru,
- chybový signál,
- průběh MSE,
- spektrální charakteristiky,
- vypočtené metriky kvality.

Základní datový tok aplikace:

```text
načtení nebo generování signálu
        ↓
vytvoření vstupních vektorů ze zpožděných vzorků
        ↓
spuštění zvoleného adaptivního algoritmu
        ↓
výpočet y(n), e(n) a w(n)
        ↓
výpočet metrik
        ↓
zobrazení výsledků v GUI
```

Aplikace je navržena tak, aby bylo možné porovnávat různé algoritmy na stejných vstupních datech a s opakovatelným nastavením parametrů.

---

## 7. Podporované algoritmy

Konfigurace algoritmů je uložena v souboru `src/config.py`.

| Algoritmus | Popis |
| --- | --- |
| LMS | Least Mean Squares |
| NLMS | Normalized Least Mean Squares |
| RLS | Recursive Least Squares |
| AP | Affine Projection |
| SSLMS | Sign-Sign LMS / varianta signed LMS |
| Llncosh | adaptivní algoritmus s nelineární chybovou funkcí |
| GMCC | Generalized Maximum Correntropy Criterion |
| GNGD | Generalized Normalized Gradient Descent |

Hlavními algoritmy semestrální práce jsou LMS, NLMS a RLS. Ostatní algoritmy jsou zařazeny jako rozšíření pro širší experimentální porovnání.

---

## 8. Výchozí parametry algoritmů

Výchozí hodnoty parametrů jsou definovány v `src/config.py`.

| Algoritmus | Výchozí parametry |
| --- | --- |
| LMS | `mu = 0.01` |
| NLMS | `mu = 0.8`, `eps = 1e-3` |
| RLS | `mu = 0.99`, `eps = 0.1` |
| AP | `mu = 0.05`, `order = 3`, `ifc = 1e-3` |
| SSLMS | `mu = 0.01` |
| Llncosh | `mu = 0.01`, `lambd = 0.1` |
| GMCC | `mu = 0.01`, `lambd = 0.05`, `alpha = 2.0` |
| GNGD | `mu = 0.01`, `eps = 0.1`, `ro = 1e-4` |

Součástí konfigurace jsou také limity parametrů. Ty pomáhají zabránit hodnotám, které by mohly vést k numericky nestabilnímu nebo nevhodnému chování algoritmů.

---

## 9. Vstupní signály

Aplikace podporuje několik typů vstupních signálů.

### 9.1 Syntetický harmonický signál

Syntetický signál je generován jako sinusový průběh s volitelným aditivním šumem.

| Parametr | Význam |
| --- | --- |
| `fs` | vzorkovací frekvence |
| `f0` | frekvence sinusového signálu |
| `T` | délka signálu |
| `noise_mean` | střední hodnota šumu |
| `noise_std` | směrodatná odchylka šumu |
| `seed` | počáteční hodnota generátoru náhodných čísel |

Pokud jsou parametry šumu nulové, je vstupní signál vytvořen jako přesná kopie referenčního signálu. To umožňuje ověřit chování algoritmů v ideálních podmínkách.

### 9.2 CSV signál

CSV loader podporuje tyto základní formáty:

| Formát CSV | Interpretace |
| --- | --- |
| jeden sloupec | amplituda signálu |
| dva sloupce | čas a amplituda |
| tři a více sloupců | I/Q složky nebo rozšířený datový záznam |

U dvousloupcového formátu se vzorkovací frekvence odhaduje z rozdílu sousedních časových značek.

### 9.3 EKG signál

EKG signály jsou načítány pomocí knihovny WFDB. Loader je určen pro záznamy ve formátu běžně používaném databázemi typu PhysioNet.

Používá se první signálový kanál a vzorkovací frekvence uložená v záznamu.

### 9.4 Rádiový signál ve formátu HDF5

Rádiová data jsou načítána ze souboru HDF5. Loader očekává dataset s polem `X`, které obsahuje I/Q složky, a polem `Y`, které obsahuje třídní příslušnost vzorku.

Z I/Q složek je vypočtena amplituda:

```text
x = sqrt(I^2 + Q^2)
```

Výsledný jednorozměrný signál je následně použit jako vstup pro adaptivní filtraci.

---

## 10. Vyhodnocované veličiny

Aplikace počítá několik metrik popisujících kvalitu adaptace.

| Metrika | Význam |
| --- | --- |
| `MSE` | střední kvadratická chyba v ustálené části signálu |
| `EMSE` | přebytečná střední kvadratická chyba |
| `J_min` | odhad minimální dosažitelné chyby |
| `Misadjustment` | relativní odchylka vůči minimální chybě |
| `SNR_in` | odstup signálu od šumu na vstupu |
| `SNR_out` | odstup signálu od šumu na výstupu |
| `ΔSNR` | změna SNR po filtraci |
| `n90` | orientační index dosažení ustáleného stavu |

Výpočet metrik je prováděn nad časově zarovnanými vektory vstupu, reference, výstupu a chybového signálu.

---

## 11. Spektrální analýza

Pro frekvenční vyhodnocení je použita rychlá Fourierova transformace. Výpočet spektra je implementován v souboru `src/filters/fft_utils.py`.

Výstupem jsou:

- frekvenční osa,
- amplitudové spektrum signálu.

FFT analýza slouží k porovnání spektrálních složek před a po filtraci, zejména při testování potlačení harmonického nebo úzkopásmového rušení.

---

## 12. Grafické uživatelské rozhraní

Grafické uživatelské rozhraní je implementováno pomocí PyQt5. Hlavní okno aplikace je definováno v `src/gui/main_window.py` a související rozložení je uloženo v `src/gui/main_window.ui`.

GUI zajišťuje:

- výběr vstupního signálu,
- nastavení parametrů filtru,
- výběr adaptačního algoritmu,
- spuštění výpočtu,
- zobrazení časových průběhů,
- zobrazení chybového signálu,
- zobrazení spektra,
- náhled načteného signálu.

Vstupní bod celé aplikace je `src/app.py`.

---

## 13. Stav implementace

Tento checklist je určen pro průběžné vedení revize semestrálního softwarového modelu.

### 13.1 Aplikační základ

- [ ] Aplikace se spustí příkazem `python -m src.app`.
- [ ] Importy balíčku fungují z kořenového adresáře repozitáře.
- [ ] Virtuální prostředí lze vytvořit podle `requirements.txt`.
- [ ] GUI se otevře bez importních chyb.
- [ ] Hlavní okno aplikace je propojeno se souborem `main_window.ui`.

### 13.2 Adaptivní algoritmy

- [ ] LMS lze spustit na syntetickém signálu.
- [ ] NLMS lze spustit na syntetickém signálu.
- [ ] RLS lze spustit na syntetickém signálu.
- [ ] AP lze spustit na syntetickém signálu.
- [ ] SSLMS lze spustit na syntetickém signálu.
- [ ] Llncosh lze spustit na syntetickém signálu.
- [ ] GMCC lze spustit na syntetickém signálu.
- [ ] GNGD lze spustit na syntetickém signálu.
- [ ] Limity parametrů zabraňují zjevnému numerickému rozběhu algoritmů.
- [ ] Výsledky algoritmů jsou porovnatelné na stejném vstupním signálu.

### 13.3 Vstupní data

- [ ] Syntetický sinusový signál lze generovat s volitelným šumem.
- [ ] CSV signál lze načíst v jednosloupcovém formátu.
- [ ] CSV signál lze načíst ve formátu čas-amplituda.
- [ ] EKG signál lze načíst pomocí WFDB.
- [ ] HDF5 rádiový dataset lze načíst pomocí `h5py`.
- [ ] Pro každý typ vstupu je dokumentována očekávaná struktura dat.

### 13.4 Vyhodnocení

- [ ] Aplikace počítá MSE.
- [ ] Aplikace počítá EMSE.
- [ ] Aplikace počítá misadjustment.
- [ ] Aplikace počítá vstupní a výstupní SNR.
- [ ] Aplikace počítá změnu SNR.
- [ ] Aplikace zobrazuje časové průběhy.
- [ ] Aplikace zobrazuje chybový signál.
- [ ] Aplikace zobrazuje spektrum pomocí FFT.
- [ ] Výsledky lze exportovat nebo zdokumentovat pro semestrální práci.

---

## 14. Omezení této části projektu

Tato část projektu má několik záměrných omezení:

- neobsahuje kompletní FPGA implementaci,
- neobsahuje VHDL/Verilog jádro filtru,
- neřeší reálný Ethernet přenos do FPGA,
- nepoužívá fixed-point aritmetiku určenou pro hardwarovou syntézu,
- slouží hlavně jako softwarový referenční model,
- výsledky jsou určeny především pro porovnání algoritmů a přípravu navazující FPGA části.

Tato omezení odpovídají rozsahu semestrální práce, která se zaměřuje hlavně na teoretickou přípravu, návrh systému a simulační ověření.

---

## 15. Návaznost na bakalářskou práci

Výstupy této semestrální práce slouží jako podklad pro navazující bakalářskou práci.

| Semestrální práce | Navazující bakalářská práce |
| --- | --- |
| Python model LMS/NLMS/RLS | výběr algoritmu vhodného pro FPGA |
| MSE a SNR metriky | kvantitativní ověření filtrace |
| generování testovacích signálů | příprava testovacích vektorů |
| FFT analýza v Pythonu | spektrální vyhodnocení výsledků |
| načítání EKG/HDF5/CSV dat | práce s reálnými daty |
| GUI pro experimenty | PC aplikace pro komunikaci s FPGA |

Pro hardwarovou implementaci je jako výchozí kandidát uvažován algoritmus LMS, protože má nízkou výpočetní složitost a lze jej přímo realizovat pomocí operací násobení a akumulace.

---

## 16. Doporučené použití při dokumentaci výsledků

Při přípravě semestrální práce je vhodné z aplikace doložit:

- konfiguraci vstupního signálu,
- zvolený algoritmus a jeho parametry,
- časový průběh vstupu, reference a výstupu,
- průběh chybového signálu,
- průběh MSE,
- spektrální porovnání,
- tabulku metrik pro LMS, NLMS a RLS.

Doporučená minimální sada výstupů:

```text
doc/sp_results/lms_sine_time.png
doc/sp_results/lms_sine_mse.png
doc/sp_results/lms_sine_fft.png
doc/sp_results/nlms_sine_time.png
doc/sp_results/rls_sine_time.png
doc/sp_results/algorithm_comparison.csv
```

---

## 17. Citace a použité zdroje

### 17.1 Semestrální práce

BĚČÁK, Tomáš. **Návrh a implementace adaptivního filtru pro zpracování signálu na FPGA**. Semestrální práce. Brno: Vysoké učení technické v Brně, Fakulta elektrotechniky a komunikačních technologií, Ústav radioelektroniky, 2025/2026.

### 17.2 Použité softwarové knihovny

- padasip: adaptive signal processing algorithms  
  https://github.com/matousc89/padasip

- NumPy: numerical computing  
  https://numpy.org/

- SciPy: scientific computing  
  https://scipy.org/

- PyQt5: Python bindings for Qt  
  https://pypi.org/project/PyQt5/

- PyQtGraph: scientific graphics and GUI plotting  
  https://www.pyqtgraph.org/

- WFDB Python package  
  https://wfdb.readthedocs.io/

- h5py: HDF5 for Python  
  https://www.h5py.org/

### 17.3 Odborná literatura

- HAYKIN, Simon. **Adaptive Filter Theory**. Pearson.
- WIDROW, Bernard; STEARNS, Samuel D. **Adaptive Signal Processing**. Prentice-Hall.
- PROAKIS, John G.; MANOLAKIS, Dimitris G. **Digital Signal Processing: Principles, Algorithms, and Applications**. Pearson.

---

## 18. Shrnutí

Adresář `src` obsahuje softwarový simulační nástroj pro porovnávání adaptivních filtrů. Aplikace je určena pro semestrální část práce a slouží jako referenční prostředí před navazující implementací na FPGA.

Hlavní zpracovatelský řetězec je:

```text
testovací signál
    → adaptivní filtr
    → chybový signál
    → metriky kvality
    → časové a frekvenční vyhodnocení
```

Projekt tím vytváří základ pro další fázi, ve které je možné vybraný adaptivní algoritmus převést do fixed-point reprezentace a realizovat jako hardwarový blok na FPGA.
