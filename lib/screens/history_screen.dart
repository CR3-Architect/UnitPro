import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../core/app_colors.dart';

class HistoryScreen extends StatefulWidget {
  final List<String>? history;
  const HistoryScreen({super.key, this.history});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<String> _items = [];

  @override
  void initState() {
    super.initState();
    _items = widget.history ?? [];
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final fg = isDark ? AppColors.darkOnBg : AppColors.lightOnBg;
    final sub = isDark ? AppColors.darkOnSurface : AppColors.lightOnSurface;
    final surface = isDark ? AppColors.darkSurface : AppColors.lightSurface;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBg : AppColors.lightBg,
      appBar: AppBar(
        title: const Text('History', style: TextStyle(fontWeight: FontWeight.w600)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          if (_items.isNotEmpty)
            IconButton(
              onPressed: () => setState(() => _items.clear()),
              icon: const Icon(Icons.delete_sweep_rounded, size: 22),
              tooltip: 'Clear all',
            ),
        ],
      ),
      body: _items.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.history_rounded, size: 48, color: sub.withOpacity(0.3)),
                  const SizedBox(height: 12),
                  Text('No conversions yet', style: TextStyle(color: sub.withOpacity(0.5), fontSize: 15)),
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
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    title: Text(
                      _items[i],
                      style: TextStyle(fontFamily: 'monospace', fontSize: 13, color: fg),
                    ),
                    trailing: Icon(Icons.copy_rounded, size: 16, color: sub.withOpacity(0.4)),
                    onTap: () {
                      Clipboard.setData(ClipboardData(text: _items[i]));
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
