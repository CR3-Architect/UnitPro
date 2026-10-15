import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/app_colors.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<String> _items = [];
  bool _loaded = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _items = prefs.getStringList('history') ?? [];
      _loaded = true;
    });
  }

  Future<void> _clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('history');
    setState(() => _items = []);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final fg = isDark ? AppColors.darkOnBg : AppColors.lightOnBg;
    final sub = isDark ? AppColors.darkOnSurface : AppColors.lightOnSurface;
    final surface = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final surfaceVar = isDark ? AppColors.darkSurfaceVar : AppColors.lightSurfaceVar;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBg : AppColors.lightBg,
      appBar: AppBar(
        title: const Text('History', style: TextStyle(fontWeight: FontWeight.w600)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          if (_items.isNotEmpty)
            IconButton(
              onPressed: _clearAll,
              icon: const Icon(Icons.delete_sweep_rounded, size: 22),
              tooltip: 'Clear all',
            ),
        ],
      ),
      body: !_loaded
          ? const Center(child: CircularProgressIndicator(color: AppColors.accent))
          : _items.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 72,
                        height: 72,
                        decoration: BoxDecoration(
                          color: AppColors.accent.withValues(alpha: 0.08),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.history_rounded, size: 36, color: sub.withOpacity(0.3)),
                      ),
                      const SizedBox(height: 16),
                      Text('No conversions yet', style: TextStyle(color: sub.withOpacity(0.5), fontSize: 15)),
                      const SizedBox(height: 6),
                      Text('Your recent conversions will appear here', style: TextStyle(color: sub.withOpacity(0.3), fontSize: 12)),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _items.length,
                  itemBuilder: (_, i) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      decoration: BoxDecoration(
                        color: surface,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: surfaceVar.withValues(alpha: 0.5)),
                      ),
                      child: ListTile(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        leading: Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: AppColors.accent.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(Icons.swap_horiz_rounded, color: AppColors.accent, size: 18),
                        ),
                        title: Text(
                          _items[i],
                          style: TextStyle(fontFamily: 'monospace', fontSize: 13, color: fg),
                        ),
                        trailing: Icon(Icons.copy_rounded, size: 16, color: sub.withOpacity(0.4)),
                        onTap: () {
                          Clipboard.setData(ClipboardData(text: _items[i]));
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text('Copied', style: TextStyle(fontSize: 13)),
                              behavior: SnackBarBehavior.floating,
                              duration: const Duration(seconds: 1),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
    );
  }
}
