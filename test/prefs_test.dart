import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unitpro_studio/core/prefs.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('addHistory saves and shows newest first', () async {
    SharedPreferences.setMockInitialValues({});
    await Prefs.addHistory('1 Meter = 100 Centimeter');
    await Prefs.addHistory('2 Kilogram = 4.409 Pound');

    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList('history');
    expect(list, isNotNull);
    expect(list!.length, 2);
    expect(list.first, contains('Pound'));
  });

  test('addHistory dedupes consecutive same entries', () async {
    SharedPreferences.setMockInitialValues({});
    await Prefs.addHistory('5 km/h = 3.107 mph');
    await Prefs.addHistory('5 km/h = 3.107 mph');

    final prefs = await SharedPreferences.getInstance();
    expect(prefs.getStringList('history')!.length, 1);
  });

  test('addHistory caps at 50 entries', () async {
    SharedPreferences.setMockInitialValues({});
    for (var i = 0; i < 60; i++) {
      await Prefs.addHistory('entry $i');
    }
    final prefs = await SharedPreferences.getInstance();
    expect(prefs.getStringList('history')!.length, 50);
  });

  test('favorites persist', () async {
    SharedPreferences.setMockInitialValues({});
    await Prefs.saveFavorites({'Length': ['Meter', 'Foot']});
    final favs = await Prefs.loadFavorites();
    expect(favs['Length'], containsAll(['Meter', 'Foot']));
  });

  test('last selection persists', () async {
    SharedPreferences.setMockInitialValues({});
    await Prefs.saveLastSelection(3, 'Hour', 'Minute');
    final last = await Prefs.loadLastSelection();
    expect(last, isNotNull);
    expect(last![0], 3);
    expect(last[1], 'Hour');
  });
}
