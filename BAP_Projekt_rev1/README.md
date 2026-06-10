# Návrh a implementace adaptivního filtru pro zpracování signálů na FPGA

<p align="center">
  <strong>Revizní repozitář elektronické přílohy bakalářské práce</strong>
</p>

<p align="center">
  Vysoké učení technické v Brně · Fakulta elektrotechniky a komunikačních technologií · Ústav radioelektroniky
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Board-Digilent%20Genesys%202-informational" alt="Board">
  <img src="https://img.shields.io/badge/FPGA-XC7K325T--2FFG900C-informational" alt="FPGA">
  <img src="https://img.shields.io/badge/HDL-VHDL-informational" alt="HDL">
  <img src="https://img.shields.io/badge/Firmware-MicroBlaze%20%2B%20lwIP-informational" alt="Firmware">
  <img src="https://img.shields.io/badge/Transport-UDP-informational" alt="UDP">
  <img src="https://img.shields.io/badge/Fixed--Point-Q16.16-informational" alt="Fixed Point">
  <img src="https://img.shields.io/badge/Status-Revision%20repository-yellow" alt="Status">
</p>

---

## 1. Charakter repozitáře

Tento repozitář je pracovní a revizní verzí elektronické přílohy k bakalářské práci **„Návrh a implementace adaptivního filtru pro zpracování signálů na FPGA“**.

Repozitář nevystupuje jako historická kopie přílohy odevzdané v řádném termínu. Je určen k rekonstrukci, doplnění a ověření implementační části projektu po zjištění problémů s reprodukovatelností původně odevzdané přílohy.

Hlavním cílem této revize je dát dohromady technický stav projektu tak, aby bylo možné:

* otevřít nebo znovu vytvořit Vivado projekt,
* dohledat všechny použité HDL zdrojové soubory,
* sestavit firmware pro procesor MicroBlaze,
* spustit PC aplikaci v Pythonu,
* ověřit přenos dat přes UDP,
* porovnat výstup FPGA s referenčním výpočtem,
* oddělit vlastní části od částí převzatých nebo inspirovaných z demonstračních projektů.

Tato revize tedy neslouží k přepisování historie odevzdání. Slouží k technickému doložení, že implementační část projektu je možné uvést do reprodukovatelného stavu a ověřit.

## 2. Popis projektu

Projekt řeší adaptivní filtraci číslicového signálu na FPGA. Cílovou platformou je vývojová deska **Digilent Genesys 2** osazená obvodem **AMD/Xilinx Kintex-7 XC7K325T-2FFG900C**.

Výpočetní část je tvořena adaptivním FIR filtrem s algoritmem LMS. Filtr je implementován ve VHDL a pracuje s pevnou řádovou čárkou ve formátu **signed Q16.16**.

Komunikační část používá embedded systém s procesorem **MicroBlaze**, bloky **AXI Ethernet Subsystem** a **AXI DMA**, síťový stack **lwIP** a přenos dat pomocí **UDP**. TCP není v tomto projektu použito.

Aplikační data jsou přenášena jako binární UDP payload. Do FPGA se posílají dvojice vzorků vstupního signálu `x(n)` a referenčního signálu `d(n)`. Výstupem jsou hodnoty `y(n)` a `e(n)`, tedy výstup filtru a chybový signál.

## 3. Základní údaje

| Položka                     | Hodnota                                                                |
| --------------------------- | ---------------------------------------------------------------------- |
| Autor                       | Tomáš Běčák                                                            |
| Instituce                   | Vysoké učení technické v Brně                                          |
| Fakulta                     | Fakulta elektrotechniky a komunikačních technologií                    |
| Ústav                       | Ústav radioelektroniky                                                 |
| Typ práce                   | Bakalářská práce                                                       |
| Název práce                 | Návrh a implementace adaptivního filtru pro zpracování signálů na FPGA |
| Charakter repozitáře        | revize elektronické přílohy                                            |
| Vztah k původnímu odevzdání | nejde o historický stav původně odevzdané přílohy                      |
| Cílová deska                | Digilent Genesys 2                                                     |
| FPGA                        | AMD/Xilinx Kintex-7 XC7K325T-2FFG900C                                  |
| Procesorová část            | MicroBlaze                                                             |
| HDL                         | VHDL                                                                   |
| Firmware                    | C, Vitis, lwIP                                                         |
| PC část                     | Python                                                                 |
| Síťová komunikace           | Gigabit Ethernet, UDP                                                  |
| Vnitřní přenos dat          | AXI Ethernet Subsystem, AXI DMA                                        |
| Výpočetní jádro             | adaptivní FIR filtr s algoritmem LMS                                   |
| Číselná reprezentace        | signed fixed-point Q16.16                                              |
| Diagnostika                 | OLED displej, UART/debug výstup, Python log                            |

## 4. Terminologické poznámky

V dokumentaci je dodržováno následující názvosloví:

| Používaný termín     | Význam                                                        |
| -------------------- | ------------------------------------------------------------- |
| FPGA                 | programovatelné hradlové pole                                 |
| VHDL jádro           | hardwarový blok popsaný ve VHDL                               |
| embedded systém      | část návrhu tvořená MicroBlaze procesorem a periferiemi       |
| firmware             | program běžící na procesoru MicroBlaze                        |
| PC aplikace          | program v Pythonu běžící na nadřazeném počítači               |
| síťový stack         | softwarová síťová vrstva, zde lwIP                            |
| transportní protokol | konkrétní transportní protokol, zde UDP                       |
| UDP payload          | datová část UDP datagramu                                     |
| fixed-point          | reprezentace čísel v pevné řádové čárce                       |
| Q16.16               | 32bitová signed fixed-point reprezentace s 16 zlomkovými bity |
| tap filtru           | jeden koeficient FIR filtru                                   |
| LMS                  | adaptační algoritmus Least Mean Squares                       |
| referenční signál    | požadovaný signál `d(n)`                                      |
| chybový signál       | rozdíl `e(n) = d(n) - y(n)`                                   |

V textu se záměrně nerozlišuje „TCP/IP komunikace“, protože projekt nepoužívá TCP. Přesnější formulace je **Ethernetová komunikace s UDP přenosem nad lwIP**.

## 5. Stav revize

Tato část popisuje stav revizního repozitáře, nikoli stav původní přílohy při řádném odevzdání. Položky jsou ponechány nezaškrtnuté do okamžiku, kdy je daná část ověřena v čistém prostředí nebo přímo na desce Genesys 2.

### 5.1 Rekonstrukce původního přílohového projektu

* [ ] Původní struktura elektronické přílohy byla zdokumentována.
* [ ] Byly určeny chybějící soubory původního Vivado projektu.
* [ ] Byly opraveny neplatné nebo lokální cesty ve Vivado projektu.
* [ ] Byly doplněny HDL zdrojové soubory.
* [ ] Byly doplněny firmware soubory.
* [ ] Byly doplněny Python skripty.
* [ ] Byly odděleny původní části od částí doplněných v revizi.
* [ ] README jasně uvádí, že jde o revizní repozitář.

### 5.2 Vivado projekt

* [ ] Projekt lze znovu vytvořit pomocí Tcl skriptu.
* [ ] Všechny HDL zdroje jsou součástí repozitáře.
* [ ] Všechny XDC soubory jsou součástí repozitáře.
* [ ] Block design lze otevřít a validovat.
* [ ] Návrh projde syntézou.
* [ ] Návrh projde implementací.
* [ ] Lze vygenerovat bitstream.
* [ ] Lze exportovat hardwarovou platformu do XSA.

### 5.3 Cílová platforma

* [ ] Projekt je nastaven pro desku Digilent Genesys 2.
* [ ] Cílový FPGA obvod je nastaven jako XC7K325T-2FFG900C.
* [ ] Pinové přiřazení odpovídá použitému zapojení desky.
* [ ] Hodinové domény jsou popsány.
* [ ] Resetovací signály jsou popsány.
* [ ] Ethernet PHY je připojen přes RGMII.
* [ ] OLED rozhraní odpovídá zapojení na desce.

### 5.4 LMS filtr

* [ ] Rozhraní VHDL jádra je popsáno.
* [ ] Formát Q16.16 je jednotně použit v HDL, firmware i Python části.
* [ ] Násobení a škálování odpovídá fixed-point reprezentaci.
* [ ] Reset uvede filtr do definovaného stavu.
* [ ] Výstup `y(n)` je porovnán s Python referencí.
* [ ] Chyba `e(n)` je porovnána s Python referencí.
* [ ] Aktualizace vah je porovnána s Python referencí.
* [ ] Testbench obsahuje reprezentativní vstupní vektory.

### 5.5 Firmware

* [ ] Firmware lze přeložit ve Vitis.
* [ ] Firmware inicializuje platformu.
* [ ] Firmware inicializuje lwIP.
* [ ] Firmware nastaví IP adresu.
* [ ] Firmware přijímá UDP pakety.
* [ ] Firmware kontroluje hlavičku aplikačního paketu.
* [ ] Firmware předává data do LMS jádra.
* [ ] Firmware čte výstup LMS jádra.
* [ ] Firmware odesílá UDP odpověď.
* [ ] Firmware zapisuje stav na OLED displej.
* [ ] Firmware poskytuje debug výstup přes UART.

### 5.6 Python aplikace

* [ ] Python prostředí lze vytvořit podle `requirements.txt`.
* [ ] Aplikace načte testovací data.
* [ ] Aplikace provede normalizaci dat.
* [ ] Aplikace převede hodnoty do Q16.16.
* [ ] Aplikace vytvoří UDP payload.
* [ ] Aplikace odešle paket do FPGA.
* [ ] Aplikace přijme odpověď z FPGA.
* [ ] Aplikace převede výsledky z Q16.16.
* [ ] Aplikace porovná výsledky s referenčním modelem.
* [ ] Aplikace uloží výsledky do CSV.
* [ ] Aplikace vygeneruje grafy pro kontrolu výsledků.

## 6. Poznámka k převzatým a inspirovaným částem

Ethernetová část návrhu byla architektonicky inspirována oficiálními demonstračními materiály Digilent pro desku Nexys Video. Týká se to především použití procesoru MicroBlaze, ethernetového subsystému v AXI infrastruktuře, práce se stackem lwIP a základní organizace embedded síťové aplikace.

Tato revize není přímou kopií projektu pro Nexys Video. Návrh je upraven pro desku Genesys 2, použitý obvod Kintex-7, pinové přiřazení, hodinové domény a datovou cestu LMS filtru.

OLED část vychází z oficiálních demonstračních zdrojů Digilent pro desku Genesys 2. V projektu je použita jako pomocný diagnostický výstup. OLED displej není součástí výpočetního jádra a neovlivňuje výsledky filtrace.

U převzatých nebo upravených souborů musí být zachovány původní licenční hlavičky a informace o původu.

## 7. Struktura repozitáře

```text
.
├── fpga/
│   ├── rtl/
│   │   ├── lms_filter/
│   │   ├── axi_interface/
│   │   └── oled/
│   ├── constraints/
│   ├── sim/
│   ├── scripts/
│   └── vivado/
├── firmware/
│   ├── include/
│   ├── src/
│   └── vitis/
├── python/
│   ├── main.py
│   ├── requirements.txt
│   ├── src/
│   └── tests/
├── data/
│   ├── input/
│   ├── processed/
│   └── README.md
├── doc/
│   ├── block_diagrams/
│   ├── measurements/
│   ├── reports/
│   └── timing/
├── CITATION.cff
├── LICENSE
└── README.md
```

## 8. Zásady této revize

Při úpravě repozitáře platí několik pravidel:

* nepřejmenovávat části tak, aby se ztratila návaznost na původní přílohu,
* nepředstírat, že revizní stav je totožný s původním odevzdáním,
* nedoplňovat výsledky bez uvedení, jak byly získány,
* oddělit zdrojové kódy, měření, grafy a dokumentaci,
* u každého převzatého nebo upraveného demonstračního kódu uvést původ,
* preferovat Tcl skripty a relativní cesty před ručním nastavením projektu,
* ověřovat projekt v čistém prostředí, ne pouze na původním počítači autora.

Cílem revize je reprodukovatelnost, ne kosmetická úprava repozitáře.
