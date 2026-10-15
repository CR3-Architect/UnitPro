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
      builder: (context, child) => ThemeUpdater(
        themeIndex: _themeIndex,
        onThemeChanged: _setTheme,
        child: AnimatedTheme(
          data: Theme.of(context),
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOutCubic,
          child: child!,
        ),
      ),
      home: const ConverterScreen(),
    );
  }

  ThemeData _darkTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.darkBg,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.accent,
        secondary: AppColors.accent,
        surface: AppColors.darkSurface,
        error: AppColors.error,
        onPrimary: Colors.black,
        onSurface: AppColors.darkOnBg,
      ),
      appBarTheme: const AppBarTheme(backgroundColor: Colors.transparent, elevation: 0),
      cardTheme: CardThemeData(color: AppColors.darkSurface, elevation: 0),
      dividerTheme: const DividerThemeData(color: AppColors.darkSurfaceVar, thickness: 1),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.darkSurface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
      dropdownMenuTheme: const DropdownMenuThemeData(
        menuStyle: MenuStyle(backgroundColor: WidgetStatePropertyAll(AppColors.darkSurface)),
      ),
    );
  }

  ThemeData _lightTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.lightBg,
      colorScheme: const ColorScheme.light(
        primary: AppColors.accentDim,
        secondary: AppColors.accent,
        surface: AppColors.lightSurface,
        error: AppColors.error,
        onPrimary: Colors.white,
        onSurface: AppColors.lightOnBg,
      ),
      appBarTheme: const AppBarTheme(backgroundColor: Colors.transparent, elevation: 0),
      cardTheme: CardThemeData(color: AppColors.lightSurface, elevation: 0),
      dividerTheme: const DividerThemeData(color: AppColors.lightSurfaceVar, thickness: 1),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.lightSurface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  ThemeData _amoledTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.amoledBg,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.accent,
        secondary: AppColors.accent,
        surface: AppColors.amoledSurface,
        error: AppColors.error,
        onPrimary: Colors.black,
        onSurface: AppColors.darkOnBg,
      ),
      appBarTheme: const AppBarTheme(backgroundColor: Colors.transparent, elevation: 0),
      cardTheme: CardThemeData(color: AppColors.amoledSurface, elevation: 0),
    );
  }
}

/// Available to ALL routes via MaterialApp wrapper
class ThemeUpdater extends InheritedWidget {
  final int themeIndex;
  final ValueChanged<int> onThemeChanged;
  const ThemeUpdater({super.key, required this.themeIndex, required this.onThemeChanged, required super.child});

  static ThemeUpdater of(BuildContext context) {
    final t = context.dependOnInheritedWidgetOfExactType<ThemeUpdater>();
    assert(t != null, 'ThemeUpdater not found in widget tree');
    return t!;
  }

  @override
  bool updateShouldNotify(ThemeUpdater oldWidget) => themeIndex != oldWidget.themeIndex;
}
