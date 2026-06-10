# Návrh a implementace adaptivního filtru pro zpracování signálu na FPGA

<p align="center">
  <strong>Semestrální práce – softwarový model adaptivních filtrů</strong>
</p>

<p align="center">
  Vysoké učení technické v Brně · Fakulta elektrotechniky a komunikačních technologií · Ústav radioelektroniky
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Language-Python%203.11-informational" alt="Python">
  <img src="https://img.shields.io/badge/GUI-PyQt5-informational" alt="PyQt5">
  <img src="https://img.shields.io/badge/DSP-padasip-informational" alt="padasip">
  <img src="https://img.shields.io/badge/Signals-CSV%20%7C%20WFDB%20%7C%20HDF5-informational" alt="Signal formats">
  <img src="https://img.shields.io/badge/Algorithms-LMS%20%7C%20NLMS%20%7C%20RLS-informational" alt="Algorithms">
  <img src="https://img.shields.io/badge/Status-SP%20software%20model-yellow" alt="Status">
</p>

---

## 1. Charakter repozitáře

Tento adresář obsahuje softwarovou část semestrální práce **„Návrh a implementace adaptivního filtru pro zpracování signálu na FPGA“**.

Semestrální práce je zaměřena především na teoretické zpracování adaptivních filtrů, návrh struktury budoucího systému a softwarové ověření vybraných algoritmů. Tato část projektu proto nepředstavuje kompletní FPGA implementaci. Slouží jako referenční simulační prostředí pro ověření vlastností adaptivních algoritmů před jejich navazující hardwarovou realizací.

Implementace je napsána v jazyce Python a obsahuje grafické uživatelské rozhraní pro generování, načítání, filtraci a vyhodnocení signálů. Program umožňuje testovat adaptivní algoritmy na syntetickém harmonickém signálu, elektrokardiografických signálech a datech uložených ve formátu HDF5.

---

## 2. Vztah k semestrální práci

V rámci semestrální práce jsou řešeny zejména tyto části zadání:

* rešerše adaptivních filtrů a jejich algoritmů,
* softwarová simulace vybraných adaptivních algoritmů,
* ověření chování filtrů na testovacích vektorech,
* návrh dalšího směru k implementaci na FPGA,
* příprava experimentálního základu pro navazující bakalářskou práci.

Projekt je tedy koncipován jako **softwarový předstupeň FPGA implementace**. Hlavním výstupem není bitstream pro FPGA, ale ověřené simulační prostředí, které umožňuje porovnat algoritmy LMS, NLMS, RLS a další varianty adaptivních filtrů na shodných vstupních datech.

---

## 3. Základní údaje

| Položka             | Hodnota                                                                       |
| ------------------- | ----------------------------------------------------------------------------- |
| Autor               | Tomáš Běčák                                                                   |
| Instituce           | Vysoké učení technické v Brně                                                 |
| Fakulta             | Fakulta elektrotechniky a komunikačních technologií                           |
| Ústav               | Ústav radioelektroniky                                                        |
| Typ práce           | Semestrální práce                                                             |
| Název práce         | Návrh a implementace adaptivního filtru pro zpracování signálu na FPGA        |
| Anglický název      | Design and Implementation of an Adaptive Filter for Signal Processing on FPGA |
| Vedoucí práce       | doc. Ing. Tomáš Frýza, Ph.D.                                                  |
| Programovací jazyk  | Python 3.11                                                                   |
| Grafické rozhraní   | PyQt5                                                                         |
| Výpočetní knihovna  | padasip                                                                       |
| Vizualizace         | PyQtGraph, Matplotlib                                                         |
| Podporovaná data    | syntetický signál, CSV, WFDB, HDF5                                            |
| Hlavní algoritmy    | LMS, NLMS, RLS                                                                |
| Doplňkové algoritmy | AP, SSLMS, Llncosh, GMCC, GNGD                                                |
| Výstup projektu     | softwarový model a simulační aplikace                                         |
| Návaznost           | příprava pro implementaci na FPGA                                             |

---

## 4. Struktura adresáře `src`

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

| Cesta           | Význam                                          |
| --------------- | ----------------------------------------------- |
| `src/app.py`    | vstupní bod aplikace                            |
| `src/config.py` | výchozí parametry algoritmů, limity a předvolby |
| `src/filters/`  | výpočetní část, adaptivní filtry, metriky a FFT |
| `src/gui/`      | grafické uživatelské rozhraní                   |
| `src/signals/`  | načítání signálů z CSV, WFDB a HDF5             |
| `src/assets/`   | podpůrné soubory grafického rozhraní            |

---

## 5. Spuštění aplikace

### 5.1 Instalace závislostí

Doporučený postup je vytvořit samostatné virtuální prostředí.

```bash
python -m venv .venv
```

Aktivace ve Windows:

```bash
.venv\Scripts\activate
```

Aktivace v Linuxu nebo macOS:

```bash
source .venv/bin/activate
```

Instalace knihoven:

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

### 5.2 Spuštění z kořene repozitáře

Aplikace se spouští z kořenového adresáře repozitáře:

```bash
python -m src.app
```

Alternativně lze použít:

```bash
python src/app.py
```

Doporučená varianta je spuštění přes modul `src.app`, protože zachovává korektní importy balíčku `src`.

---

## 6. Popis aplikace

Aplikace poskytuje grafické rozhraní pro experimentální ověření adaptivních filtrů. Uživatel může zvolit typ vstupního signálu, parametry filtru a adaptační algoritmus. Program následně provede filtraci, zobrazí časové průběhy, chybový signál, průběh MSE a spektrální charakteristiky.

Základní datový tok aplikace:

```text
načtení nebo generování signálu
        ↓
vytvoření vstupního vektoru zpožděných vzorků
        ↓
spuštění zvoleného adaptivního algoritmu
        ↓
výpočet výstupu y(n), chyby e(n) a vah w(n)
        ↓
výpočet metrik
        ↓
zobrazení výsledků v GUI
```

Aplikace je navržena tak, aby bylo možné porovnávat různé algoritmy na stejných datech a s opakovatelným nastavením parametrů.

---

## 7. Podporované algoritmy

Konfigurace algoritmů je uložena v souboru `src/config.py`.

| Algoritmus | Popis                                             |
| ---------- | ------------------------------------------------- |
| LMS        | Least Mean Squares                                |
| NLMS       | Normalized Least Mean Squares                     |
| RLS        | Recursive Least Squares                           |
| AP         | Affine Projection                                 |
| SSLMS      | Sign-Sign LMS / Signed LMS varianta               |
| Llncosh    | adaptivní algoritmus s nelineární chybovou funkcí |
| GMCC       | Generalized Maximum Correntropy Criterion         |
| GNGD       | Generalized Normalized Gradient Descent           |

Hlavní algoritmy semestrální práce jsou LMS, NLMS a RLS. Ostatní algoritmy jsou doplňkové a slouží k rozšíření experimentální části aplikace.

---

## 8. Výchozí parametry algoritmů

Výchozí hodnoty parametrů jsou uvedeny v `src/config.py`.

| Algoritmus | Výchozí parametry                          |
| ---------- | ------------------------------------------ |
| LMS        | `mu = 0.01`                                |
| NLMS       | `mu = 0.8`, `eps = 1e-3`                   |
| RLS        | `mu = 0.99`, `eps = 0.1`                   |
| AP         | `mu = 0.05`, `order = 3`, `ifc = 1e-3`     |
| SSLMS      | `mu = 0.01`                                |
| Llncosh    | `mu = 0.01`, `lambd = 0.1`                 |
| GMCC       | `mu = 0.01`, `lambd = 0.05`, `alpha = 2.0` |
| GNGD       | `mu = 0.01`, `eps = 0.1`, `ro = 1e-4`      |

Součástí konfigurace jsou také limity parametrů. Ty zabraňují zadání hodnot, které by u vybraných algoritmů vedly k numericky nevhodnému nebo nestabilnímu chování.

---

## 9. Vstupní signály

Aplikace podporuje několik typů vstupních signálů.

### 9.1 Syntetický harmonický signál

Syntetický signál je generován jako sinusový průběh s volitelným aditivním šumem.

Parametry:

| Parametr     | Význam                                       |
| ------------ | -------------------------------------------- |
| `fs`         | vzorkovací frekvence                         |
| `f0`         | frekvence sinusového signálu                 |
| `T`          | délka signálu                                |
| `noise_mean` | střední hodnota šumu                         |
| `noise_std`  | směrodatná odchylka šumu                     |
| `seed`       | počáteční hodnota generátoru náhodných čísel |

Pokud jsou parametry šumu nulové, je vstupní signál vytvořen jako přesná kopie referenčního signálu. Tím lze ověřit chování algoritmu v ideálních podmínkách.

### 9.2 CSV signál

CSV loader podporuje tyto základní formáty:

| Formát CSV         | Interpretace                            |
| ------------------ | --------------------------------------- |
| jeden sloupec      | amplituda signálu                       |
| dva sloupce        | čas, amplituda                          |
| tři a více sloupců | složky I/Q nebo rozšířený datový záznam |

U dvousloupcového formátu se vzorkovací frekvence odhaduje z rozdílu sousedních časových značek.

### 9.3 EKG signál

EKG signály jsou načítány pomocí knihovny WFDB. Loader pracuje se záznamy ve formátu používaném databázemi typu PhysioNet.

Načítá se první signálový kanál a vzorkovací frekvence uložená v záznamu.

### 9.4 Rádiový signál ve formátu HDF5

Rádiová data jsou načítána ze souboru HDF5. Loader očekává dataset s polem `X` obsahujícím I/Q složky a polem `Y` obsahujícím třídní příslušnost vzorku.

Z I/Q složek je vytvořena amplituda:

```text
x = sqrt(I^2 + Q^2)
```

Tento výstup je dále použit jako jednorozměrný vstupní signál pro adaptivní filtraci.

---

## 10. Vyhodnocované veličiny

Aplikace počítá několik metrik popisujících kvalitu adaptace.

| Metrika         | Význam                                             |
| --------------- | -------------------------------------------------- |
| `MSE`           | střední kvadratická chyba v ustálené části signálu |
| `EMSE`          | přebytečná střední kvadratická chyba               |
| `J_min`         | odhad minimální dosažitelné chyby                  |
| `Misadjustment` | relativní nesoulad vůči minimální chybě            |
| `SNR_in`        | odstup signálu od šumu na vstupu                   |
| `SNR_out`       | odstup signálu od šumu na výstupu                  |
| `ΔSNR`          | změna SNR po filtraci                              |
| `n90`           | orientační index dosažení ustáleného stavu         |

Výpočet metrik je prováděn nad časově zarovnanými vektory vstupu, reference, výstupu a chybového signálu.

---

## 11. Spektrální analýza

Pro frekvenční vyhodnocení je použita rychlá Fourierova transformace. Funkce pro výpočet spektra je umístěna v `src/filters/fft_utils.py`.

Výstupem jsou:

* frekvenční osa,
* amplitudové spektrum signálu.

FFT slouží k porovnání spektrálních složek před a po filtraci, zejména při testování potlačení harmonického nebo úzkopásmového rušení.

---

## 12. Grafické uživatelské rozhraní

GUI je implementováno pomocí PyQt5. Hlavní okno aplikace je definováno v `src/gui/main_window.py` a související rozložení je uloženo v `src/gui/main_window.ui`.

Grafické rozhraní zajišťuje:

* výběr vstupního signálu,
* nastavení parametrů filtru,
* výběr adaptačního algoritmu,
* spuštění výpočtu,
* zobrazení časových průběhů,
* zobrazení průběhu chyby,
* zobrazení spektra,
* náhled načteného signálu.

Vstupní bod celé aplikace je `src/app.py`.

---

## 13. Stav implementace

Tento checklist je určen pro průběžné vedení revize semestrálního softwarového modelu.

### 13.1 Aplikační základ

* [ ] Aplikace se spustí příkazem `python -m src.app`.
* [ ] Importy balíčku `src` fungují z kořenového adresáře repozitáře.
* [ ] Virtuální prostředí lze vytvořit podle `requirements.txt`.
* [ ] GUI se otevře bez importních chyb.
* [ ] Hlavní okno aplikace je propojeno se souborem `main_window.ui`.

### 13.2 Adaptivní algoritmy

* [ ] LMS lze spustit na syntetickém signálu.
* [ ] NLMS lze spustit na syntetickém signálu.
* [ ] RLS lze spustit na syntetickém signálu.
* [ ] AP lze spustit na syntetickém signálu.
* [ ] SSLMS lze spustit na syntetickém signálu.
* [ ] Llncosh lze spustit na syntetickém signálu.
* [ ] GMCC lze spustit na syntetickém signálu.
* [ ] GNGD lze spustit na syntetickém signálu.
* [ ] Limity parametrů zabraňují zjevnému numerickému rozběhu algoritmů.
* [ ] Výsledky algoritmů jsou porovnatelné na stejném vstupním signálu.

### 13.3 Vstupní data

* [ ] Syntetický sinusový signál lze generovat s volitelným šumem.
* [ ] CSV signál lze načíst v jednosloupcovém formátu.
* [ ] CSV signál lze načíst ve formátu čas + amplituda.
* [ ] EKG signál lze načíst pomocí WFDB.
* [ ] HDF5 rádiový dataset lze načíst pomocí `h5py`.
* [ ] Pro každý typ vstupu je dokumentována očekávaná struktura dat.

### 13.4 Vyhodnocení

* [ ] Aplikace počítá MSE.
* [ ] Aplikace počítá EMSE.
* [ ] Aplikace počítá misadjustment.
* [ ] Aplikace počítá vstupní a výstupní SNR.
* [ ] Aplikace počítá změnu SNR.
* [ ] Aplikace zobrazuje časové průběhy.
* [ ] Aplikace zobrazuje chybový signál.
* [ ] Aplikace zobrazuje spektrum pomocí FFT.
* [ ] Výsledky lze exportovat nebo zdokumentovat pro semestrální práci.

---

## 14. Omezení této části projektu

Tato část projektu má několik záměrných omezení:

* neobsahuje kompletní FPGA implementaci,
* neobsahuje VHDL/Verilog jádro filtru,
* neřeší reálný Ethernet přenos do FPGA,
* nepoužívá fixed-point aritmetiku pro hardwarovou syntézu,
* slouží jako softwarový referenční model,
* výsledky jsou určeny hlavně pro porovnání algoritmů a přípravu navazující FPGA části.

Tato omezení odpovídají rozsahu semestrální práce, která řeší především teoretickou přípravu, návrh architektury a simulační ověření algoritmů.

---

## 15. Návaznost na bakalářskou práci

Výstupy této semestrální práce slouží jako podklad pro navazující bakalářskou práci.

Přímá návaznost:

| Semestrální práce              | Navazující bakalářská práce       |
| ------------------------------ | --------------------------------- |
| Python model LMS/NLMS/RLS      | výběr algoritmu vhodného pro FPGA |
| MSE a SNR metriky              | kvantitativní ověření filtrace    |
| generování testovacích signálů | příprava testovacích vektorů      |
| FFT analýza v Pythonu          | spektrální vyhodnocení výsledků   |
| načítání EKG/HDF5/CSV dat      | práce s reálnými daty             |
| GUI pro experimenty            | PC aplikace pro komunikaci s FPGA |

Pro hardwarovou implementaci je jako výchozí kandidát uvažován algoritmus LMS, protože má nízkou výpočetní složitost a lze jej přímo realizovat pomocí operací násobení a akumulace.

---

## 16. Doporučené použití při dokumentaci výsledků

Při přípravě semestrální práce je vhodné z aplikace doložit:

* konfiguraci vstupního signálu,
* zvolený algoritmus a jeho parametry,
* časový průběh vstupu, reference a výstupu,
* průběh chybového signálu,
* průběh MSE,
* spektrální porovnání,
* tabulku metrik pro LMS, NLMS a RLS.

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

* padasip: adaptive signal processing algorithms
  https://github.com/matousc89/padasip

* NumPy: numerical computing
  https://numpy.org/

* SciPy: scientific computing
  https://scipy.org/

* PyQt5: Python bindings for Qt
  https://pypi.org/project/PyQt5/

* PyQtGraph: scientific graphics and GUI plotting
  https://www.pyqtgraph.org/

* WFDB Python package
  https://wfdb.readthedocs.io/

* h5py: HDF5 for Python
  https://www.h5py.org/

### 17.3 Odborná literatura

* HAYKIN, Simon. **Adaptive Filter Theory**. Pearson.
* WIDROW, Bernard; STEARNS, Samuel D. **Adaptive Signal Processing**. Prentice-Hall.
* PROAKIS, John G.; MANOLAKIS, Dimitris G. **Digital Signal Processing: Principles, Algorithms, and Applications**. Pearson.

---

## 18. Shrnutí

Adresář `src` obsahuje softwarový simulační nástroj pro porovnání adaptivních filtrů. Aplikace je určena pro semestrální část práce a slouží jako referenční prostředí před navazující implementací na FPGA.

Hlavní výstup této části je:

```text
testovací signál
    → adaptivní filtr
    → chybový signál
    → metriky kvality
    → časové a frekvenční vyhodnocení
```

Projekt tím vytváří základ pro další fázi, ve které je možné vybraný algoritmus převést do fixed-point reprezentace a realizovat jako hardwarový blok na FPGA.
