import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  Prefs._();

  static Future<void> saveLastSelection(int catIndex, String from, String to) async {
    final p = await SharedPreferences.getInstance();
    await p.setInt('lastCat', catIndex);
    await p.setString('lastFrom', from);
    await p.setString('lastTo', to);
  }

  static Future<List<dynamic>?> loadLastSelection() async {
    final p = await SharedPreferences.getInstance();
    final i = p.getInt('lastCat');
    final f = p.getString('lastFrom');
    final t = p.getString('lastTo');
    if (i == null || f == null || t == null) return null;
    return [i, f, t];
  }

  static Future<Map<String, List<String>>> loadFavorites() async {
    final p = await SharedPreferences.getInstance();
    final raw = p.getString('favorites');
    if (raw == null) return {};
    try {
      final decoded = jsonDecode(raw) as Map<String, dynamic>;
      return decoded.map((k, v) => MapEntry(k, (v as List).cast<String>()));
    } catch (_) {
      return {};
    }
  }

  static Future<void> saveFavorites(Map<String, List<String>> favs) async {
    final p = await SharedPreferences.getInstance();
    await p.setString('favorites', jsonEncode(favs));
  }

  static Future<void> addHistory(String entry) async {
    final p = await SharedPreferences.getInstance();
    final list = p.getStringList('history') ?? [];
    if (list.isNotEmpty && list.first == entry) return;
    list.insert(0, entry);
    if (list.length > 50) list.removeLast();
    await p.setStringList('history', list);
  }
}
