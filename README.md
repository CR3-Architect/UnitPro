# UnitPro Studio

**Professional unit converter — 12 categories, 100+ units, physical constants. Free, open source, no ads.**

[![Flutter](https://img.shields.io/badge/Flutter-3.19+-02569B?style=flat-square&logo=flutter&logoColor=white)](https://flutter.dev)
[![License](https://img.shields.io/badge/License-MIT-green?style=flat-square)](LICENSE)
[![Tests](https://img.shields.io/badge/tests-15%20passed-brightgreen?style=flat-square)](#testing)

---

## What it does

Convert between 100+ units across 12 categories, with a reference table of fundamental physical constants. Built as a companion to [CalcPro Studio](https://github.com/CR3-Architect/CalcPro).

| Category | Units |
|---|---|
| Length | Meter, km, cm, mm, µm, nm, mile, yard, foot, inch, nautical mile, light year, parsec, AU |
| Mass | kg, g, mg, µg, metric ton, pound, ounce, stone, US/Imperial ton, u |
| Temperature | Celsius, Fahrenheit, Kelvin, Rankine |
| Time | µs, ns, ms, second, minute, hour, day, week, month, year, decade, century |
| Speed | m/s, km/h, mph, knot, ft/s, Mach, c |
| Area | m², km², cm², hectare, acre, ft², in², mi², yd² |
| Volume | L, mL, m³, gallon (US/UK), quart, pint, cup, fl oz, tbsp, tsp, ft³ |
| Data | Bit, Byte, KB, MB, GB, TB, PB, KiB, MiB, GiB |
| Energy | J, kJ, cal, kcal, Wh, kWh, eV, BTU, ft·lbf |
| Pressure | Pa, kPa, MPa, bar, atm, psi, mmHg, Torr |
| Frequency | Hz, kHz, MHz, GHz, THz, RPM |
| Angle | Degree, Radian, Gradian, arcmin, arcsec, turn |

**Physical constants:** c, h, G, kB, e, me, mp, NA, R, g, M⊕, R⊕, eV, u — tap to copy.

---

## Features

- **Live conversion** — results update as you type
- **Swap** — one-tap from/to swap
- **Formula display** — see the math behind each conversion
- **Copy & share** — results to clipboard or any app
- **Themes** — Dark, Light, AMOLED
- **14 tests** — conversion accuracy verified

---

## Build

```bash
git clone https://github.com/CR3-Architect/UnitPro.git
cd UnitPro
flutter pub get
flutter test
flutter build apk --release --split-per-abi
```

---

## Pairs with

**[CalcPro Studio](https://github.com/CR3-Architect/CalcPro)** — scientific calculator with 9 modes including this unit converter, currency rates, matrix, calculus, and more.

---

## License

[MIT](LICENSE)

---

© 2026 [Atiqullah](https://github.com/CR3-Architect)
