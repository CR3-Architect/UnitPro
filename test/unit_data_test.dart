import 'package:flutter_test/flutter_test.dart';
import 'package:unitpro_studio/core/unit_data.dart';

void main() {
  group('Unit conversions', () {
    test('length: meter to kilometer', () {
      expect(UnitData.convert(1000, 'Length', 'Meter', 'Kilometer'), closeTo(1, 1e-9));
    });

    test('length: inch to centimeter', () {
      expect(UnitData.convert(1, 'Length', 'Inch', 'Centimeter'), closeTo(2.54, 1e-9));
    });

    test('mass: kilogram to pound', () {
      expect(UnitData.convert(1, 'Mass', 'Kilogram', 'Pound'), closeTo(2.20462, 1e-3));
    });

    test('temperature: Celsius to Fahrenheit', () {
      expect(UnitData.convert(100, 'Temperature', 'Celsius', 'Fahrenheit'), closeTo(212, 1e-9));
    });

    test('temperature: Fahrenheit to Celsius', () {
      expect(UnitData.convert(32, 'Temperature', 'Fahrenheit', 'Celsius'), closeTo(0, 1e-9));
    });

    test('temperature: Celsius to Kelvin', () {
      expect(UnitData.convert(0, 'Temperature', 'Celsius', 'Kelvin'), closeTo(273.15, 1e-9));
    });

    test('time: hour to minute', () {
      expect(UnitData.convert(1, 'Time', 'Hour', 'Minute'), closeTo(60, 1e-9));
    });

    test('speed: km/h to mph', () {
      expect(UnitData.convert(100, 'Speed', 'km/h', 'mph'), closeTo(62.137, 1e-2));
    });

    test('data: gigabyte to megabyte', () {
      expect(UnitData.convert(1, 'Data', 'Gigabyte', 'Megabyte'), closeTo(1024, 1e-9));
    });

    test('energy: kilojoule to calorie', () {
      expect(UnitData.convert(1, 'Energy', 'Kilojoule', 'Calorie'), closeTo(0.239, 1e-2));
    });

    test('formatResult: integer stays clean', () {
      expect(UnitData.formatResult(42.0), '42');
    });

    test('formatResult: decimal trimmed', () {
      expect(UnitData.formatResult(3.14), '3.14');
    });

    test('formatResult: very large uses exponential', () {
      expect(UnitData.formatResult(1e20), contains('e'));
    });

    test('all categories have units', () {
      for (final cat in UnitData.categories) {
        expect(cat.units.isNotEmpty, true, reason: '${cat.name} empty');
      }
    });
  });
}
