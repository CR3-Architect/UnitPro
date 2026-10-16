import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

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
          Container(
            decoration: BoxDecoration(
              color: surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: surfaceVar.withValues(alpha: 0.5)),
            ),
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                _themeCard(context, 0, 'Dark', 'Slate theme', Icons.dark_mode_rounded, themeUpdater, sub, fg, surfaceVar),
                const SizedBox(width: 8),
                _themeCard(context, 1, 'Light', 'Clean & bright', Icons.light_mode_rounded, themeUpdater, sub, fg, surfaceVar),
                const SizedBox(width: 8),
                _themeCard(context, 2, 'AMOLED', 'Pure black', Icons.contrast_rounded, themeUpdater, sub, fg, surfaceVar),
              ],
            ),
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
                  subtitle: Text('v1.1.0 · MIT License', style: TextStyle(color: sub, fontSize: 12)),
                ),
                Divider(height: 1, color: surfaceVar.withValues(alpha: 0.5)),
                _actionTile(Icons.person_rounded, 'Atiqullah · CR3-Architect', () {
                  _openUrl(context, 'https://github.com/CR3-Architect');
                }, sub),
                Divider(height: 1, indent: 52, color: surfaceVar.withValues(alpha: 0.5)),
                _actionTile(Icons.link_rounded, 'github.com/CR3-Architect/UnitPro', () {
                  _openUrl(context, 'https://github.com/CR3-Architect/UnitPro');
                }, sub),
                Divider(height: 1, indent: 52, color: surfaceVar.withValues(alpha: 0.5)),
                _actionTile(Icons.favorite_rounded, 'Pairs with CalcPro Studio', () {
                  _openUrl(context, 'https://github.com/CR3-Architect/CalcPro');
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

  Widget _themeCard(BuildContext context, int index, String label, String subtitle, IconData icon,
      ThemeUpdater themeUpdater, Color sub, Color fg, Color surfaceVar) {
    final selected = index == themeUpdater.themeIndex;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          HapticFeedback.selectionClick();
          themeUpdater.onThemeChanged(index);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 10),
          decoration: BoxDecoration(
            color: selected ? AppColors.accent.withValues(alpha: 0.10) : Colors.transparent,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: selected ? AppColors.accent.withValues(alpha: 0.6) : surfaceVar.withValues(alpha: 0.4),
              width: selected ? 1.5 : 1,
            ),
          ),
          child: Column(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: selected ? AppColors.accent : sub.withValues(alpha: 0.08),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 22, color: selected ? Colors.black : sub),
              ),
              const SizedBox(height: 10),
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: selected ? FontWeight.w700 : FontWeight.w600,
                  color: selected ? AppColors.accent : fg,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                subtitle,
                style: TextStyle(fontSize: 10.5, color: sub.withOpacity(0.5)),
              ),
              const SizedBox(height: 8),
              AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: selected ? 1 : 0,
                child: const Icon(Icons.check_circle_rounded, color: AppColors.accent, size: 18),
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
      trailing: Icon(Icons.open_in_new_rounded, color: sub.withOpacity(0.4), size: 18),
      onTap: onTap,
    );
  }

  Future<void> _openUrl(BuildContext context, String url) async {
    final uri = Uri.parse(url);
    try {
      final ok = await launchUrl(uri, mode: LaunchMode.externalApplication);
      if (!ok) throw Exception('failed');
    } catch (_) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Could not open $url', style: const TextStyle(fontSize: 13)),
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 2),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        );
      }
    }
  }
}
