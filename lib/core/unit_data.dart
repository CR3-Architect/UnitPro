/// Unit conversion data and logic
import 'package:flutter/material.dart';

class UnitCategory {
  final String name;
  final IconData icon;
  final Map<String, double> units;
  const UnitCategory(this.name, this.icon, this.units);
}

class UnitData {
  UnitData._();

  static const List<UnitCategory> categories = [
    UnitCategory('Length', Icons.straighten_rounded, {
      'Meter': 1, 'Kilometer': 1000, 'Centimeter': 0.01, 'Millimeter': 0.001,
      'Micrometer': 1e-6, 'Nanometer': 1e-9, 'Mile': 1609.344, 'Yard': 0.9144,
      'Foot': 0.3048, 'Inch': 0.0254, 'Nautical Mile': 1852, 'Light Year': 9.4607e15,
      'Parsec': 3.0857e16, 'AU': 1.49598e11,
    }),
    UnitCategory('Mass', Icons.fitness_center_rounded, {
      'Kilogram': 1, 'Gram': 0.001, 'Milligram': 1e-6, 'Microgram': 1e-9,
      'Metric Ton': 1000, 'Pound': 0.453592, 'Ounce': 0.0283495,
      'Stone': 6.35029, 'US Ton': 907.185, 'Imperial Ton': 1016.05,
      'Atomic Mass Unit': 1.66054e-27, 'Carat': 0.0002, 'Grain': 6.479891e-5,
      'Troy Ounce': 0.0311035, 'Slug': 14.5939,
    }),
    UnitCategory('Temperature', Icons.thermostat_rounded, {
      'Celsius': 1, 'Fahrenheit': 1, 'Kelvin': 1, 'Rankine': 1,
    }),
    UnitCategory('Time', Icons.schedule_rounded, {
      'Second': 1, 'Millisecond': 0.001, 'Microsecond': 1e-6, 'Nanosecond': 1e-9,
      'Minute': 60, 'Hour': 3600, 'Day': 86400, 'Week': 604800,
      'Month (30d)': 2592000, 'Year (365d)': 31536000, 'Decade': 315360000,
      'Century': 3153600000,
    }),
    UnitCategory('Speed', Icons.speed_rounded, {
      'm/s': 1, 'km/h': 0.277778, 'mph': 0.44704, 'knot': 0.514444,
      'ft/s': 0.3048, 'Mach': 343, 'c': 299792458,
    }),
    UnitCategory('Area', Icons.crop_square_rounded, {
      'sq meter': 1, 'sq kilometer': 1e6, 'sq centimeter': 1e-4,
      'sq millimeter': 1e-6, 'sq micrometer': 1e-12,
      'Hectare': 10000, 'Acre': 4046.86, 'Are': 100, 'Barn': 1e-28,
      'sq foot': 0.092903, 'sq inch': 6.4516e-4, 'sq mile': 2.59e6,
      'sq yard': 0.836127,
    }),
    UnitCategory('Volume', Icons.water_drop_rounded, {
      'Liter': 1, 'Milliliter': 0.001, 'Cubic Meter': 1000,
      'Gallon (US)': 3.78541, 'Gallon (UK)': 4.54609, 'Quart (US)': 0.946353,
      'Pint (US)': 0.473176, 'Cup (US)': 0.236588, 'Fl Oz (US)': 0.0295735,
      'Tablespoon': 0.0147868, 'Teaspoon': 0.00492892, 'Cubic Foot': 28.3168,
      'Cubic Inch': 0.0163871,
    }),
    UnitCategory('Data', Icons.storage_rounded, {
      'Bit': 1, 'Byte': 8, 'Kilobyte': 8192, 'Megabyte': 8388608,
      'Gigabyte': 8589934592, 'Terabyte': 8796093022208, 'Petabyte': 8.8e15,
      'Kibibyte': 8192, 'Mebibyte': 8388608, 'Gibibyte': 8.59e9,
    }),
    UnitCategory('Energy', Icons.bolt_rounded, {
      'Joule': 1, 'Kilojoule': 1000, 'Megajoule': 1e6, 'Gigajoule': 1e9,
      'Calorie': 4184, 'Kilocalorie': 4184000,
      'Watt-hour': 3600, 'Kilowatt-hour': 3.6e6, 'eV': 1.60218e-19,
      'BTU': 1055.06, 'Foot-pound': 1.35582, 'Erg': 1e-7, 'Therm': 1.0551e8,
    }),
    UnitCategory('Pressure', Icons.compress_rounded, {
      'Pascal': 1, 'Kilopascal': 1000, 'Bar': 100000, 'Atmosphere': 101325,
      'psi': 6894.76, 'mmHg': 133.322, 'Torr': 133.322, 'MPa': 1e6,
    }),
    UnitCategory('Frequency', Icons.radio_rounded, {
      'Hertz': 1, 'Kilohertz': 1000, 'Megahertz': 1e6, 'Gigahertz': 1e9,
      'Terahertz': 1e12, 'RPM': 1 / 60,
    }),
    UnitCategory('Angle', Icons.rotate_right_rounded, {
      'Degree': 1, 'Radian': 57.2958, 'Gradian': 0.9,
      'Arc Minute': 1 / 60, 'Arc Second': 1 / 3600, 'Turn': 360,
    }),
    UnitCategory('Power', Icons.electric_bolt_rounded, {
      'Watt': 1, 'Kilowatt': 1000, 'Megawatt': 1e6, 'Horsepower': 745.699872,
      'Metric Horsepower': 735.49875, 'BTU per Hour': 0.29307107,
      'Erg per Second': 1e-7, 'Foot-pound/min': 0.016857,
    }),
    UnitCategory('Torque', Icons.sync_alt_rounded, {
      'Newton-meter': 1, 'Kilonewton-meter': 1000, 'Foot-pound': 1.3558179,
      'Inch-pound': 0.1129848, 'Dyne-meter': 1e-5,
      'Kilogram-force Meter': 9.80665,
    }),
    UnitCategory('Fuel Economy', Icons.local_gas_station_rounded, {
      'Kilometer/Liter': 1, 'Mile/Liter': 1.609344, 'Meter/Liter': 1000,
      'Mile per Gallon (US)': 0.425144, 'Mile per Gallon (UK)': 0.354006,
    }),
  ];

  /// Physical constants
  static const List<Map<String, String>> constants = [
    {'name': 'Speed of Light', 'value': '299,792,458', 'unit': 'm/s', 'symbol': 'c'},
    {'name': 'Planck Constant', 'value': '6.626 × 10⁻³⁴', 'unit': 'J·s', 'symbol': 'h'},
    {'name': 'Gravitational Constant', 'value': '6.674 × 10⁻¹¹', 'unit': 'm³/(kg·s²)', 'symbol': 'G'},
    {'name': 'Boltzmann Constant', 'value': '1.381 × 10⁻²³', 'unit': 'J/K', 'symbol': 'kB'},
    {'name': 'Elementary Charge', 'value': '1.602 × 10⁻¹⁹', 'unit': 'C', 'symbol': 'e'},
    {'name': 'Electron Mass', 'value': '9.109 × 10⁻³¹', 'unit': 'kg', 'symbol': 'me'},
    {'name': 'Proton Mass', 'value': '1.673 × 10⁻²⁷', 'unit': 'kg', 'symbol': 'mp'},
    {'name': 'Avogadro Number', 'value': '6.022 × 10²³', 'unit': '/mol', 'symbol': 'NA'},
    {'name': 'Gas Constant', 'value': '8.314', 'unit': 'J/(mol·K)', 'symbol': 'R'},
    {'name': 'Standard Gravity', 'value': '9.807', 'unit': 'm/s²', 'symbol': 'g'},
    {'name': 'Earth Mass', 'value': '5.972 × 10²⁴', 'unit': 'kg', 'symbol': 'M⊕'},
    {'name': 'Earth Radius', 'value': '6,371', 'unit': 'km', 'symbol': 'R⊕'},
    {'name': 'Electron Volt', 'value': '1.602 × 10⁻¹⁹', 'unit': 'J', 'symbol': 'eV'},
    {'name': 'Atomic Mass Unit', 'value': '1.661 × 10⁻²⁷', 'unit': 'kg', 'symbol': 'u'},
  ];

  static double convert(double value, String category, String from, String to) {
    if (category == 'Temperature') return _convertTemp(value, from, to);
    final cat = categories.firstWhere((c) => c.name == category);
    return value * cat.units[from]! / cat.units[to]!;
  }

  static double _convertTemp(double v, String from, String to) {
    double c;
    switch (from) {
      case 'Celsius': c = v; break;
      case 'Fahrenheit': c = (v - 32) * 5 / 9; break;
      case 'Kelvin': c = v - 273.15; break;
      case 'Rankine': c = (v - 491.67) * 5 / 9; break;
      default: c = v;
    }
    switch (to) {
      case 'Celsius': return c;
      case 'Fahrenheit': return c * 9 / 5 + 32;
      case 'Kelvin': return c + 273.15;
      case 'Rankine': return (c + 273.15) * 9 / 5;
      default: return c;
    }
  }

  static String formatResult(double value) {
    if (value.isNaN || value.isInfinite) return value.toString();
    if (value.abs() >= 1e15 || (value.abs() < 1e-6 && value != 0)) {
      return value.toStringAsExponential(4);
    }
    if (value == value.roundToDouble() && value.abs() < 1e15) {
      return value.toInt().toString();
    }
    var s = value.toStringAsFixed(6);
    if (s.contains('.')) {
      s = s.replaceAll(RegExp(r'0+$'), '').replaceAll(RegExp(r'\.$'), '');
    }
    return s;
  }
}
