import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
    final surfaceVar = isDark ? AppColors.darkSurfaceVar : AppColors.lightSurfaceVar;
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
          // ── Appearance ──
          _sectionHeader('APPEARANCE', sub),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: surfaceVar.withValues(alpha: 0.5)),
            ),
            child: Column(
              children: [
                ListTile(
                  leading: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: AppColors.accent.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.palette_rounded, color: AppColors.accent, size: 20),
                  ),
                  title: Text('Theme', style: TextStyle(color: fg, fontSize: 15, fontWeight: FontWeight.w600)),
                  subtitle: Text('Choose app appearance', style: TextStyle(color: sub, fontSize: 12)),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: SegmentedButton<int>(
                    segments: [
                      for (int i = 0; i < themes.length; i++)
                        ButtonSegment(value: i, label: Text(themes[i], style: const TextStyle(fontSize: 13))),
                    ],
                    selected: {themeUpdater.themeIndex},
                    onSelectionChanged: (s) => themeUpdater.onThemeChanged(s.first),
                    style: SegmentedButton.styleFrom(
                      selectedBackgroundColor: AppColors.accent.withValues(alpha: 0.15),
                      selectedForegroundColor: AppColors.accent,
                      foregroundColor: sub,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // ── About ──
          _sectionHeader('ABOUT', sub),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: surfaceVar.withValues(alpha: 0.5)),
            ),
            child: Column(
              children: [
                ListTile(
                  leading: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(colors: [AppColors.accent, AppColors.accentDim]),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.swap_horiz_rounded, color: Colors.black, size: 20),
                  ),
                  title: Text('UnitPro Studio', style: TextStyle(color: fg, fontSize: 15, fontWeight: FontWeight.w700)),
                  subtitle: Text('v1.0.0', style: TextStyle(color: sub, fontSize: 12)),
                ),
                Divider(height: 1, color: surfaceVar.withValues(alpha: 0.5)),
                _infoTile(Icons.category_rounded, '12 categories · 100+ units', sub),
                Divider(height: 1, color: surfaceVar.withValues(alpha: 0.5)),
                _infoTile(Icons.functions_rounded, '14 physical constants', sub),
                Divider(height: 1, color: surfaceVar.withValues(alpha: 0.5)),
                _infoTile(Icons.code_rounded, 'MIT License · Open Source', sub),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // ── Credits ──
          _sectionHeader('CREDITS', sub),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: surfaceVar.withValues(alpha: 0.5)),
            ),
            child: Column(
              children: [
                _infoTile(Icons.person_rounded, 'Atiqullah · CR3-Architect', sub),
                Divider(height: 1, color: surfaceVar.withValues(alpha: 0.5)),
                _infoTile(Icons.link_rounded, 'github.com/CR3-Architect/UnitPro', sub),
                Divider(height: 1, color: surfaceVar.withValues(alpha: 0.5)),
                _infoTile(Icons.favorite_rounded, 'Pairs with CalcPro Studio', sub),
              ],
            ),
          ),

          const SizedBox(height: 24),

          Center(
            child: Text(
              'Made with Flutter',
              style: TextStyle(color: sub.withOpacity(0.4), fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionHeader(String label, Color sub) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Text(
        label,
        style: TextStyle(
          color: sub.withOpacity(0.6),
          fontSize: 11,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _infoTile(IconData icon, String text, Color sub) {
    return ListTile(
      dense: true,
      leading: Icon(icon, color: sub.withOpacity(0.6), size: 18),
      title: Text(text, style: TextStyle(fontSize: 13, color: sub)),
    );
  }
}
