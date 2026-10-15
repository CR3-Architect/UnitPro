import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../core/app_colors.dart';
import '../core/unit_data.dart';

class ConstantsScreen extends StatelessWidget {
  const ConstantsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final fg = isDark ? AppColors.darkOnBg : AppColors.lightOnBg;
    final sub = isDark ? AppColors.darkOnSurface : AppColors.lightOnSurface;
    final surface = isDark ? AppColors.darkSurface : AppColors.lightSurface;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBg : AppColors.lightBg,
      appBar: AppBar(
        title: const Text('Physical Constants', style: TextStyle(fontWeight: FontWeight.w600)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: UnitData.constants.length,
        itemBuilder: (_, i) {
          final c = UnitData.constants[i];
          return Container(
            margin: const EdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(
              color: surface,
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              leading: Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: AppColors.accent.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    c['symbol']!,
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: AppColors.accent,
                    ),
                  ),
                ),
              ),
              title: Text(c['name']!, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: fg)),
              subtitle: Text(
                '${c['value']} ${c['unit']}',
                style: TextStyle(fontFamily: 'monospace', fontSize: 12, color: sub.withOpacity(0.7)),
              ),
              trailing: Icon(Icons.copy_rounded, size: 16, color: sub.withOpacity(0.4)),
              onTap: () {
                Clipboard.setData(ClipboardData(text: '${c['value']} ${c['unit']}'));
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Copied'), duration: Duration(seconds: 1)),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
