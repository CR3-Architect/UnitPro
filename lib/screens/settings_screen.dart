import 'package:flutter/material.dart';

import '../core/app_colors.dart';
import '../main.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final fg = isDark ? AppColors.darkOnBg : AppColors.lightOnBg;
    final sub = isDark ? AppColors.darkOnSurface : AppColors.lightOnSurface;
    final surface = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final themeUpdater = ThemeUpdater.of(context);
    const themes = ['Dark', 'Light', 'AMOLED'];

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBg : AppColors.lightBg,
      appBar: AppBar(
        title: const Text('Settings', style: TextStyle(fontWeight: FontWeight.w600)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            decoration: BoxDecoration(color: surface, borderRadius: BorderRadius.circular(14)),
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.palette_rounded, color: sub, size: 22),
                  title: Text('Theme', style: TextStyle(color: fg, fontSize: 15)),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: SegmentedButton<int>(
                    segments: [
                      for (int i = 0; i < themes.length; i++)
                        ButtonSegment(value: i, label: Text(themes[i])),
                    ],
                    selected: {themeUpdater.themeIndex},
                    onSelectionChanged: (s) => themeUpdater.onThemeChanged(s.first),
                    style: SegmentedButton.styleFrom(
                      selectedBackgroundColor: AppColors.accent.withValues(alpha: 0.2),
                      selectedForegroundColor: AppColors.accent,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(color: surface, borderRadius: BorderRadius.circular(14)),
            child: const ListTile(
              leading: Icon(Icons.info_rounded, color: AppColors.accent, size: 22),
              title: Text('UnitPro Studio', style: TextStyle(fontSize: 15)),
              subtitle: Text('v1.0.0 · 12 categories · 100+ units · MIT License'),
            ),
          ),
        ],
      ),
    );
  }
}
