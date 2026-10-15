import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/app_colors.dart';
import 'screens/converter_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final themeIndex = prefs.getInt('theme') ?? 0;
  runApp(UnitProApp(themeIndex: themeIndex));
}

class UnitProApp extends StatefulWidget {
  final int themeIndex;
  const UnitProApp({super.key, required this.themeIndex});

  @override
  State<UnitProApp> createState() => _UnitProAppState();
}

class _UnitProAppState extends State<UnitProApp> {
  late int _themeIndex;

  @override
  void initState() {
    super.initState();
    _themeIndex = widget.themeIndex;
  }

  void _setTheme(int i) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('theme', i);
    setState(() => _themeIndex = i);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UnitPro Studio',
      debugShowCheckedModeBanner: false,
      themeMode: _themeIndex == 1 ? ThemeMode.light : ThemeMode.dark,
      theme: _lightTheme(),
      darkTheme: _themeIndex == 2 ? _amoledTheme() : _darkTheme(),
      home: ThemeUpdater(themeIndex: _themeIndex, onThemeChanged: _setTheme, child: const ConverterScreen()),
    );
  }

  ThemeData _darkTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.darkBg,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.accent,
        brightness: Brightness.dark,
        surface: AppColors.darkSurface,
      ),
      appBarTheme: const AppBarTheme(backgroundColor: Colors.transparent, elevation: 0),
    );
  }

  ThemeData _lightTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.lightBg,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.accent,
        brightness: Brightness.light,
        surface: AppColors.lightSurface,
      ),
      appBarTheme: const AppBarTheme(backgroundColor: Colors.transparent, elevation: 0),
    );
  }

  ThemeData _amoledTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.amoledBg,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.accent,
        brightness: Brightness.dark,
        surface: AppColors.amoledSurface,
      ),
      appBarTheme: const AppBarTheme(backgroundColor: Colors.transparent, elevation: 0),
    );
  }
}

/// Inherited widget for theme switching from settings
class ThemeUpdater extends InheritedWidget {
  final int themeIndex;
  final ValueChanged<int> onThemeChanged;
  const ThemeUpdater({super.key, required this.themeIndex, required this.onThemeChanged, required super.child});

  static ThemeUpdater of(BuildContext context) => context.dependOnInheritedWidgetOfExactType<ThemeUpdater>()!;

  @override
  bool updateShouldNotify(ThemeUpdater oldWidget) => themeIndex != oldWidget.themeIndex;
}
