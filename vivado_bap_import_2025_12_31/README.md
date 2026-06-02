# bap

Tato složka obsahuje zmenšenou zdrojovou přílohu projektu bakalářské práce.

Obsahuje:
- VHDL/Verilog zdrojové soubory,
- XDC constraint soubory,
- Vivado projektový soubor,
- block design soubory,
- konfigurace IP jader ve formě `.xci`, `.bd` a Tcl souborů,
- Python skripty,
- C/C++ zdrojové soubory,
- ručně připravenou MicroBlaze/Vitis UDP aplikaci ve zdrojové podobě,
- stavové README soubory.

Neobsahuje:
- `BAP.gen`,
- `BAP.runs`,
- `BAP.cache`,
- `.Xil`,
- `vitis_ws`,
- `ip_user_files`,
- vygenerované IP output products,
- bitstream `.bit`,
- XSA export,
- ELF soubor,
- cache a dočasné build artefakty.

Poznámka k IP jádrům:
Součástí balíku jsou konfigurační soubory IP jader (`.xci`, `.bd`, Tcl), ze kterých lze IP jádra ve Vivadu znovu vygenerovat. Vygenerované výstupy IP jader nejsou přiloženy kvůli velikostnímu limitu odevzdávacího systému.

Poznámka k MicroBlaze/Vitis:
Firmware je přiložen ve zdrojové podobě ve složce `manual_vitis_udp`. Výsledný ELF se generuje až při buildu aplikace pro konkrétní BSP a lokální MicroBlaze toolchain.
