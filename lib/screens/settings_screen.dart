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
          const SizedBox(height: 10),
          Row(
            children: [
              _themeCard(
                context,
                index: 0,
                label: 'Dark',
                subtitle: 'Slate',
                icon: Icons.dark_mode_rounded,
                current: themeUpdater.themeIndex,
                onTap: themeUpdater.onThemeChanged,
                sub: sub,
                fg: fg,
              ),
              const SizedBox(width: 10),
              _themeCard(
                context,
                index: 1,
                label: 'Light',
                subtitle: 'Cool',
                icon: Icons.light_mode_rounded,
                current: themeUpdater.themeIndex,
                onTap: themeUpdater.onThemeChanged,
                sub: sub,
                fg: fg,
              ),
              const SizedBox(width: 10),
              _themeCard(
                context,
                index: 2,
                label: 'AMOLED',
                subtitle: 'Pure black',
                icon: Icons.contrast_rounded,
                current: themeUpdater.themeIndex,
                onTap: themeUpdater.onThemeChanged,
                sub: sub,
                fg: fg,
              ),
            ],
          ),

          const SizedBox(height: 24),

          // ── App ──
          _sectionHeader('APP', sub),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              color: surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: surfaceVar.withValues(alpha: 0.5)),
            ),
            child: Column(
              children: [
                _tile(Icons.category_rounded, '15 categories', '120+ units across all categories', fg, sub),
                Divider(height: 1, indent: 52, color: surfaceVar.withValues(alpha: 0.5)),
                _tile(Icons.functions_rounded, 'Physical constants', '14 fundamental constants, tap to copy', fg, sub),
                Divider(height: 1, indent: 52, color: surfaceVar.withValues(alpha: 0.5)),
                _tile(Icons.swap_horiz_rounded, 'Smart conversion', 'Live results, formula display, swap', fg, sub),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // ── About ──
          _sectionHeader('ABOUT', sub),
          const SizedBox(height: 10),
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
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(colors: [AppColors.accent, AppColors.accentDim]),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.swap_horiz_rounded, color: Colors.black, size: 22),
                  ),
                  title: Text('UnitPro Studio', style: TextStyle(color: fg, fontSize: 16, fontWeight: FontWeight.w700)),
                  subtitle: Text('v1.0.0 · MIT License', style: TextStyle(color: sub, fontSize: 12)),
                ),
                Divider(height: 1, color: surfaceVar.withValues(alpha: 0.5)),
                _actionTile(Icons.code_rounded, 'View on GitHub', () {
                  _snack(context, 'github.com/CR3-Architect/UnitPro');
                }, sub),
                Divider(height: 1, indent: 52, color: surfaceVar.withValues(alpha: 0.5)),
                _actionTile(Icons.favorite_rounded, 'Pairs with CalcPro Studio', () {
                  _snack(context, 'Scientific calculator — 9 modes, free & open source');
                }, sub),
              ],
            ),
          ),

          const SizedBox(height: 28),

          Center(
            child: Text(
              'Made with Flutter · © 2026 Atiqullah',
              style: TextStyle(color: sub.withOpacity(0.4), fontSize: 12),
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _themeCard(
    BuildContext context, {
    required int index,
    required String label,
    required String subtitle,
    required IconData icon,
    required int current,
    required ValueChanged<int> onTap,
    required Color sub,
    required Color fg,
  }) {
    final selected = index == current;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          HapticFeedback.selectionClick();
          onTap(index);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 6),
          decoration: BoxDecoration(
            color: selected
                ? AppColors.accent.withValues(alpha: 0.10)
                : Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: selected ? AppColors.accent.withValues(alpha: 0.6) : sub.withOpacity(0.12),
              width: selected ? 1.5 : 1,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: selected ? AppColors.accent : sub.withValues(alpha: 0.08),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 20, color: selected ? Colors.black : sub),
              ),
              const SizedBox(height: 8),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                    color: selected ? AppColors.accent : fg,
                  ),
                ),
              ),
              const SizedBox(height: 2),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  subtitle,
                  style: TextStyle(fontSize: 10, color: sub.withOpacity(0.5)),
                ),
              ),
              const SizedBox(height: 6),
              AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: selected ? 1 : 0,
                child: const Icon(Icons.check_rounded, color: AppColors.accent, size: 16),
              ),
            ],
          ),
        ),
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

  Widget _tile(IconData icon, String title, String subtitle, Color fg, Color sub) {
    return ListTile(
      dense: true,
      leading: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: AppColors.accent.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: AppColors.accent, size: 19),
      ),
      title: Text(title, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: fg)),
      subtitle: Text(subtitle, style: TextStyle(fontSize: 12, color: sub.withOpacity(0.6))),
    );
  }

  Widget _actionTile(IconData icon, String title, VoidCallback onTap, Color sub) {
    return ListTile(
      dense: true,
      leading: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: AppColors.accent.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: AppColors.accent, size: 19),
      ),
      title: Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.accent)),
      trailing: Icon(Icons.chevron_right_rounded, color: sub.withOpacity(0.4), size: 20),
      onTap: onTap,
    );
  }

  void _snack(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg, style: const TextStyle(fontSize: 13)),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
