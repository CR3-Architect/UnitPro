<div align="center">

# ⚖️ UnitPro Studio

**A professional unit converter for Android — 15 categories, 130+ units, physical constants reference.**

[![Flutter](https://img.shields.io/badge/Flutter-3.19+-02569B?style=flat&logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.3+-0175C2?style=flat&logo=dart&logoColor=white)](https://dart.dev)
[![License](https://img.shields.io/badge/License-MIT-green?style=flat)](LICENSE)
[![Tests](https://img.shields.io/badge/tests-15%20passed-brightgreen?style=flat)](#-testing)
[![Release](https://img.shields.io/badge/release-v1.0.0-orange?style=flat)](../../releases)

Free · Open source · No ads · No telemetry

</div>

---

## ✨ Features

| | Feature | Details |
|---|---|---|
| 🔄 | **Live conversion** | Results update instantly as you type |
| 📚 | **15 categories** | 130+ units — from meters to light years |
| 🌡️ | **Smart temperature** | Exact °C / °F / K / °R formulas, not naive factors |
| 🔬 | **Physical constants** | 14 fundamental constants — tap to copy |
| 🔍 | **Professional picker** | Bottom-sheet unit list with factors & search-style layout |
| ⚖️ | **One-tap swap** | Flip from/to instantly with haptic feedback |
| 🧮 | **Formula display** | See the exact math behind every conversion |
| 📋 | **Copy & share** | Send results to clipboard or any app |
| 🎨 | **3 themes** | Dark · Light · AMOLED — animated 400ms transitions |
| 📱 | **100% offline** | No network, no tracking, no accounts |

## 📐 Categories

| Category | Units |
|---|---|
| **Length** | Meter, Kilometer, Centimeter, Millimeter, Micrometer, Nanometer, Mile, Yard, Foot, Inch, Nautical Mile, Light Year, Parsec, AU |
| **Mass** | Kilogram, Gram, Milligram, Microgram, Metric Ton, Pound, Ounce, Stone, US Ton, Imperial Ton, Atomic Mass Unit, Carat, Grain, Troy Ounce, Slug |
| **Temperature** | Celsius, Fahrenheit, Kelvin, Rankine |
| **Time** | Nanosecond, Microsecond, Millisecond, Second, Minute, Hour, Day, Week, Month, Year, Decade, Century |
| **Speed** | m/s, km/h, mph, Knot, ft/s, Mach, Speed of Light |
| **Area** | m², km², cm², mm², µm², Hectare, Acre, Are, Barn, ft², in², mi², yd² |
| **Volume** | Liter, Milliliter, Cubic Meter, Gallon (US/UK), Quart, Pint, Cup, Fl Oz, Tablespoon, Teaspoon, Cubic Foot, Cubic Inch |
| **Data** | Bit, Byte, KB, MB, GB, TB, PB, KiB, MiB, GiB |
| **Energy** | Joule, Kilojoule, Megajoule, Gigajoule, Calorie, Kilocalorie, Watt-hour, Kilowatt-hour, eV, BTU, Foot-pound, Erg, Therm |
| **Pressure** | Pascal, Kilopascal, Megapascal, Bar, Atmosphere, psi, mmHg, Torr |
| **Frequency** | Hz, kHz, MHz, GHz, THz, RPM |
| **Angle** | Degree, Radian, Gradian, Arc Minute, Arc Second, Turn |
| **Power** | Watt, Kilowatt, Megawatt, Horsepower, Metric Horsepower, BTU/h, Erg/s, Foot-pound/min |
| **Torque** | Newton-meter, Kilonewton-meter, Foot-pound, Inch-pound, Dyne-meter, Kilogram-force Meter |
| **Fuel Economy** | km/L, mi/L, m/L, mpg (US), mpg (UK) |

**Constants included:** `c` · `h` · `G` · `k_B` · `e` · `m_e` · `m_p` · `N_A` · `R` · `g` · `M⊕` · `R⊕` · `eV` · `u`

## 🏗️ Architecture

```
lib/
├── core/
│   ├── app_colors.dart      # Navy + amber design tokens
│   └── unit_data.dart       # 15 categories, conversions, constants
├── screens/
│   ├── converter_screen.dart    # Main UI + bottom-sheet unit picker
│   ├── constants_screen.dart    # Physical constants reference
│   ├── history_screen.dart      # Persisted conversion history
│   └── settings_screen.dart     # Themes, links, about
└── main.dart                 # Theme switching (AnimatedTheme)
```

- **State:** lightweight — `setState` + `InheritedWidget` (ThemeUpdater)
- **Persistence:** `shared_preferences`
- **Sharing:** `share_plus`
- **Links:** `url_launcher`
- **No heavy frameworks** — the whole app builds in seconds

## 🚀 Build it yourself

```bash
git clone https://github.com/CR3-Architect/UnitPro.git
cd UnitPro
flutter pub get
flutter test                      # 15 tests
flutter build apk --release --split-per-abi
```

Output: `build/app/outputs/flutter-apk/app-arm64-v8a-release.apk`

## 🧪 Testing

```bash
flutter test
```

15 tests covering real conversions (inch→cm, °C→°F, GB→MB…), result formatting edge cases (integers, decimals, scientific notation), and widget rendering.

## 🤝 Pairs with

**[CalcPro Studio](https://github.com/CR3-Architect/CalcPro)** — scientific calculator with 9 modes: standard, scientific, programmer, matrix, calculus, base-n, equations, graphs, and yes — a unit converter too.

## 📄 License

[MIT](LICENSE) © 2026 [Atiqullah](https://github.com/CR3-Architect)

---

<div align="center">

**⭐ Star the repo if you find it useful**

</div>
