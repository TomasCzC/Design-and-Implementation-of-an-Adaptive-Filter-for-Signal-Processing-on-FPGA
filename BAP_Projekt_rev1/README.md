# Návrh a implementace adaptivního filtru pro zpracování signálů na FPGA

<p align="center">
  <strong>Design and Implementation of an Adaptive Filter for Signal Processing on FPGA</strong>
</p>

<p align="center">
  Revizní repozitář elektronické přílohy bakalářské práce<br>
  Vysoké učení technické v Brně · Fakulta elektrotechniky a komunikačních technologií · Ústav radioelektroniky
</p>

<p align="center">
  <a href="https://www.vut.cz/"><img src="https://img.shields.io/badge/University-BUT%20Brno-blue" alt="University"></a>
  <a href="https://www.fekt.vut.cz/"><img src="https://img.shields.io/badge/Faculty-FEEC%20BUT-blue" alt="Faculty"></a>
  <img src="https://img.shields.io/badge/Board-Genesys%202%20AMD%20Kintex%E2%84%A2%207%20FPGA%20Development%20Board-informational" alt="Board">
  <img src="https://img.shields.io/badge/FPGA-XC7K325T--2FFG900C-informational" alt="FPGA">
  <img src="https://img.shields.io/badge/HDL-VHDL-informational" alt="HDL">
  <img src="https://img.shields.io/badge/Firmware-MicroBlaze%20%2B%20lwIP-informational" alt="Firmware">
  <img src="https://img.shields.io/badge/Transport-UDP-informational" alt="UDP">
  <img src="https://img.shields.io/badge/Fixed--Point-Q16.16-informational" alt="Fixed Point">
</p>

<p align="center">
  <a href="./LICENSE"><img src="https://img.shields.io/badge/License-See%20LICENSE-lightgrey" alt="License"></a>
  <img src="https://img.shields.io/badge/Repository%20Type-Appendix%20Revision-yellow" alt="Repository Type">
  <img src="https://img.shields.io/badge/Original%20Submission-Not%20replaced-critical" alt="Original Submission">
  <img src="https://img.shields.io/badge/Reproducibility-Under%20verification-yellow" alt="Reproducibility">
</p>

<p align="center">
  <a href="#1-charakter-repozitáře">Charakter repozitáře</a> |
  <a href="#2-popis-projektu">Popis projektu</a> |
  <a href="#3-základní-údaje">Základní údaje</a> |
  <a href="#4-stav-revize">Stav revize</a> |
  <a href="#7-reprodukce-projektu">Reprodukce</a> |
  <a href="#13-převzaté-a-inspirované-části">Zdroje převzatých částí</a>
</p>

---

## 1. Charakter repozitáře

Tento repozitář představuje **revizní a reprodukovatelnou verzi elektronické přílohy** k bakalářské práci **„Návrh a implementace adaptivního filtru pro zpracování signálů na FPGA“**.

Repozitář slouží k technickému doložení, opravě a zpřehlednění implementační části projektu po zjištění nedostatků v původní elektronické příloze. Jeho účelem je zajistit, aby bylo možné projekt znovu otevřít, sestavit, spustit a ověřit bez chybějících zdrojových souborů nebo nejasných vazeb mezi částmi návrhu.

Tento repozitář **nenahrazuje historický stav elektronické přílohy odevzdané v řádném termínu**. Původní odevzdaná příloha zůstává samostatným stavem odevzdání. Tento repozitář dokumentuje následnou revizi, jejímž cílem je:

* opravit neúplné nebo nefunkční vazby původního Vivado projektu,
* doplnit chybějící zdrojové a testovací soubory,
* sjednotit strukturu FPGA, firmware a Python části,
* doplnit dokumentaci potřebnou k reprodukci projektu,
* jasně oddělit vlastní části od částí převzatých nebo inspirovaných,
* doložit funkčnost návrhu pomocí testů, měření a výstupních reportů.

Revize je vedena transparentně tak, aby bylo zřejmé, které části odpovídají původnímu návrhu a které části byly doplněny, opraveny nebo reorganizovány až v rámci následné technické revize.

---

## 2. Popis projektu

Projekt řeší návrh a implementaci adaptivního filtru pro zpracování číslicových signálů na platformě FPGA. Cílovou vývojovou deskou je **Digilent Genesys 2 AMD Kintex™ 7 FPGA Development Board** osazená obvodem **AMD/Xilinx Kintex-7 XC7K325T-2FFG900C**.

Výpočetní část tvoří adaptivní FIR filtr s algoritmem LMS implementovaný ve VHDL. Signálové hodnoty jsou reprezentovány ve formátu **signed fixed-point Q16.16**. Komunikační část systému využívá procesor **MicroBlaze**, subsystém **AXI Ethernet**, přenos přes **AXI DMA**, síťový stack **lwIP** a transportní protokol **UDP**.

TCP není v tomto projektu použit. lwIP zde slouží jako embedded síťový stack, zatímco aplikační přenos signálových bloků je realizován nad UDP.

Revizní repozitář je strukturován tak, aby obsahoval kompletní technické podklady pro opětovnou reprodukci projektu:

* FPGA zdrojové soubory,
* Vivado projekt nebo Tcl skripty pro jeho rekonstrukci,
* Vitis firmware pro MicroBlaze,
* Python aplikaci pro UDP komunikaci a vyhodnocení,
* testovací data,
* simulační a měřicí výstupy,
* dokumentaci datového toku,
* dokumentaci převzatých a inspirovaných částí.

---

## 3. Základní údaje

| Položka                     | Hodnota                                                                       |
| --------------------------- | ----------------------------------------------------------------------------- |
| Autor                       | Tomáš Běčák                                                                   |
| Instituce                   | Vysoké učení technické v Brně                                                 |
| Fakulta                     | Fakulta elektrotechniky a komunikačních technologií                           |
| Ústav                       | Ústav radioelektroniky                                                        |
| Typ práce                   | Bakalářská práce                                                              |
| Název práce                 | Návrh a implementace adaptivního filtru pro zpracování signálů na FPGA        |
| Anglický název              | Design and Implementation of an Adaptive Filter for Signal Processing on FPGA |
| Vedoucí práce               | doc. Ing. Tomáš Frýza, Ph.D.                                                  |
| Charakter repozitáře        | Revize elektronické přílohy                                                   |
| Vztah k původnímu odevzdání | Není historickým stavem přílohy při řádném odevzdání                          |
| Účel repozitáře             | Reprodukovatelná technická revize implementační části                         |
| Cílová vývojová deska       | Digilent Genesys 2 AMD Kintex™ 7 FPGA Development Board                       |
| FPGA obvod                  | AMD/Xilinx Kintex-7 XC7K325T-2FFG900C                                         |
| Rodina FPGA                 | Kintex-7                                                                      |
| Pouzdro                     | FFG900                                                                        |
| Rychlostní stupeň           | -2                                                                            |
| Teplotní rozsah             | Commercial                                                                    |
| Procesorová část            | MicroBlaze soft-core processor                                                |
| HDL                         | VHDL                                                                          |
| Firmware                    | C, Vitis, lwIP                                                                |
| PC aplikace                 | Python                                                                        |
| Síťová komunikace           | Gigabit Ethernet, lwIP, UDP                                                   |
| Přenos dat ve FPGA systému  | AXI Ethernet Subsystem, AXI DMA                                               |
| Výpočetní jádro             | adaptivní FIR filtr s algoritmem LMS                                          |
| Číselná reprezentace        | signed fixed-point Q16.16                                                     |
| Diagnostika                 | OLED displej, UART/debug log, Python log                                      |
| Testovací data              | syntetické signály, radarové profily ODIM HDF5                                |
| Stav repozitáře             | revize směrem k reprodukovatelné implementaci                                 |

---

## 4. Stav revize

Tato část slouží jako průběžný kontrolní seznam revize původního přílohového projektu. Položky jsou ponechány nezaškrtnuté, dokud není daná část znovu ověřena v čistém prostředí nebo přímo na cílovém hardwaru.

Checklist nepopisuje stav původní elektronické přílohy při řádném odevzdání. Popisuje stav této revizní verze repozitáře.

### 4.1 Rekonstrukce původní přílohy

* [ ] Původní struktura elektronické přílohy byla archivována nebo zdokumentována.
* [ ] Byly identifikovány chybějící zdrojové soubory původního Vivado projektu.
* [ ] Byly identifikovány neplatné absolutní nebo lokální cesty ve Vivado projektu.
* [ ] Byly dohledány nebo znovu vytvořeny chybějící HDL zdrojové soubory.
* [ ] Byly dohledány nebo znovu vytvořeny chybějící Python skripty.
* [ ] Byly dohledány nebo znovu vytvořeny chybějící firmware soubory.
* [ ] Byly odděleny původní části od částí doplněných v rámci revize.
* [ ] Byla doplněna poznámka, že tento repozitář není identický s přílohou odevzdanou v řádném termínu.

### 4.2 Hardwarový návrh ve Vivadu

* [ ] Vivado projekt lze vytvořit z Tcl skriptu bez ručních zásahů.
* [ ] Všechny HDL zdrojové soubory jsou součástí repozitáře.
* [ ] Všechny XDC soubory pro desku Genesys 2 jsou součástí repozitáře.
* [ ] Block design lze otevřít a validovat bez chyb.
* [ ] Návrh úspěšně projde syntézou.
* [ ] Návrh úspěšně projde implementací.
* [ ] Časová analýza neobsahuje kritické porušení časování.
* [ ] Bitstream lze vygenerovat bez chyb.
* [ ] Hardwarovou platformu lze exportovat do souboru XSA.
* [ ] Exportovaný XSA soubor odpovídá použitému Vitis workspace.

### 4.3 Cílová platforma

* [ ] Projekt je nastaven pro desku Digilent Genesys 2 AMD Kintex™ 7 FPGA Development Board.
* [ ] Cílový FPGA obvod je nastaven jako AMD/Xilinx Kintex-7 XC7K325T-2FFG900C.
* [ ] Pinové přiřazení odpovídá oficiálnímu rozhraní desky Genesys 2.
* [ ] Hodinové signály odpovídají použitému návrhu.
* [ ] Ethernet PHY je správně připojen přes RGMII rozhraní.
* [ ] OLED rozhraní odpovídá zapojení na desce Genesys 2.
* [ ] Resetovací a debug signály jsou správně přiřazeny.

### 4.4 VHDL LMS filtr

* [ ] LMS jádro má jednoznačně definované vstupy a výstupy.
* [ ] Fixed-point formát Q16.16 je jednotně použit v HDL i firmware.
* [ ] Násobení a škálování po násobení odpovídá Q16.16 reprezentaci.
* [ ] Reset jádra nastaví vnitřní stav do definovaného stavu.
* [ ] Výstup `y(n)` je porovnán s referenčním Python modelem.
* [ ] Chybový signál `e(n)` je porovnán s referenčním Python modelem.
* [ ] Aktualizace vah je porovnána s referenčním modelem.
* [ ] HDL testbench obsahuje reprezentativní testovací vektory.
* [ ] Výstupy simulace jsou uloženy v dokumentační části repozitáře.

### 4.5 Firmware pro MicroBlaze

* [ ] Firmware lze sestavit ve Vitis bez chyb.
* [ ] Firmware inicializuje platformu a síťový stack lwIP.
* [ ] Firmware nastaví IP adresu FPGA.
* [ ] Firmware otevře UDP socket na zvoleném portu.
* [ ] Firmware přijímá aplikační UDP pakety.
* [ ] Firmware kontroluje `MAGIC`, `SEQ`, `COUNT` a `FLAGS`.
* [ ] Firmware provádí převod endianity.
* [ ] Firmware předává vzorky do LMS jádra.
* [ ] Firmware čte výsledky z LMS jádra.
* [ ] Firmware odesílá UDP odpověď zpět do PC.
* [ ] Firmware zapisuje diagnostický stav na OLED displej.
* [ ] Firmware poskytuje debug výstup přes UART.

### 4.6 PC aplikace v Pythonu

* [ ] Python prostředí lze vytvořit podle `requirements.txt`.
* [ ] Aplikace načte syntetická testovací data.
* [ ] Aplikace načte radarová data ve formátu ODIM HDF5.
* [ ] Aplikace provede normalizaci vstupních dat.
* [ ] Aplikace provede převod do Q16.16.
* [ ] Aplikace vytvoří binární UDP payload.
* [ ] Aplikace odešle UDP paket do FPGA.
* [ ] Aplikace přijme UDP odpověď z FPGA.
* [ ] Aplikace provede převod výsledků z Q16.16.
* [ ] Aplikace porovná FPGA výstup s Python referencí.
* [ ] Aplikace uloží výsledky do CSV.
* [ ] Aplikace vygeneruje grafy časových průběhů a spekter.

### 4.7 Síťová komunikace

* [ ] PC a FPGA jsou ve stejné síťové podsíti.
* [ ] IP adresa FPGA je dokumentována.
* [ ] UDP port je dokumentován.
* [ ] Přenos lze ověřit z Python logu.
* [ ] Přenos lze ověřit ve Wiresharku.
* [ ] Sekvenční čísla paketů se zvyšují korektně.
* [ ] Počet vzorků v odpovědi odpovídá vstupnímu paketu.
* [ ] Ztracený nebo chybný paket je detekován na aplikační vrstvě.
* [ ] Výstupní UDP payload odpovídá dokumentované struktuře.

### 4.8 Dokumentace a reprodukovatelnost

* [ ] README obsahuje aktuální strukturu revizního repozitáře.
* [ ] README jasně uvádí, že jde o revizi původní elektronické přílohy.
* [ ] README jasně uvádí, že repozitář není historickým stavem při řádném odevzdání.
* [ ] README obsahuje přesný postup rekonstrukce Vivado projektu.
* [ ] README obsahuje postup sestavení firmware.
* [ ] README obsahuje postup spuštění Python aplikace.
* [ ] README obsahuje popis UDP payloadu.
* [ ] README obsahuje popis fixed-point formátu Q16.16.
* [ ] README obsahuje vymezení vlastních a převzatých částí.
* [ ] README obsahuje zdroje k Digilent Genesys 2.
* [ ] README obsahuje zdroje k inspiraci z Nexys Video.
* [ ] README obsahuje zdroje k OLED části převzaté z Digilentu.
* [ ] README obsahuje zdroje k AMD/Xilinx IP jádrům.
* [ ] README obsahuje popis omezení implementace.
* [ ] README obsahuje možnosti dalšího rozšíření.

### 4.9 GitHub integrace

* [ ] Repozitář obsahuje `.gitignore`.
* [ ] Repozitář obsahuje `LICENSE`.
* [ ] Repozitář obsahuje `CITATION.cff`.
* [ ] Repozitář obsahuje issue template.
* [ ] Repozitář obsahuje pull request template.
* [ ] Repozitář obsahuje workflow pro kontrolu Python testů.
* [ ] Repozitář obsahuje workflow pro kontrolu Markdown dokumentace.
* [ ] Repozitář obsahuje tag stabilní revize.
* [ ] Repozitář obsahuje release s archivem reprodukovatelné verze.
