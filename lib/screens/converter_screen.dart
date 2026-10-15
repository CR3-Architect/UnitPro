import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';

import '../core/app_colors.dart';
import '../core/unit_data.dart';
import 'constants_screen.dart';
import 'history_screen.dart';
import 'settings_screen.dart';

class ConverterScreen extends StatefulWidget {
  const ConverterScreen({super.key});

  @override
  State<ConverterScreen> createState() => _ConverterScreenState();
}

class _ConverterScreenState extends State<ConverterScreen> {
  int _catIndex = 0;
  String _fromUnit = '';
  String _toUnit = '';
  final _inputCtrl = TextEditingController(text: '1');
  double _result = 0;

  @override
  void initState() {
    super.initState();
    _fromUnit = UnitData.categories[0].units.keys.first;
    _toUnit = UnitData.categories[0].units.keys.last;
    _convert();
  }

  @override
  void dispose() {
    _inputCtrl.dispose();
    super.dispose();
  }

  void _convert() {
    final v = double.tryParse(_inputCtrl.text.replaceAll(',', ''));
    if (v == null) {
      setState(() => _result = 0);
      return;
    }
    final cat = UnitData.categories[_catIndex];
    setState(() => _result = UnitData.convert(v, cat.name, _fromUnit, _toUnit));
  }

  void _swap() {
    setState(() {
      final t = _fromUnit;
      _fromUnit = _toUnit;
      _toUnit = t;
    });
    _convert();
  }

  void _copyResult() {
    Clipboard.setData(ClipboardData(text: UnitData.formatResult(_result)));
    _snack('Result copied');
  }

  void _shareResult() {
    Share.share(
      '${_inputCtrl.text} $_fromUnit = ${UnitData.formatResult(_result)} $_toUnit\nvia UnitPro Studio',
    );
  }

  void _snack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg, style: const TextStyle(fontSize: 13)),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final fg = isDark ? AppColors.darkOnBg : AppColors.lightOnBg;
    final sub = isDark ? AppColors.darkOnSurface : AppColors.lightOnSurface;
    final surface = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final surfaceVar = isDark ? AppColors.darkSurfaceVar : AppColors.lightSurfaceVar;
    final units = UnitData.categories[_catIndex].units.keys.toList();

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBg : AppColors.lightBg,
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.accent, AppColors.accentDim],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(7),
              ),
              child: const Icon(Icons.swap_horiz_rounded, size: 18, color: Colors.black),
            ),
            const SizedBox(width: 10),
            const Text('UnitPro', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18)),
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () async {
              await Navigator.push(context, MaterialPageRoute(builder: (_) => const HistoryScreen()));
            },
            icon: const Icon(Icons.history_rounded, size: 21),
            tooltip: 'History',
          ),
          IconButton(
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ConstantsScreen())),
            icon: const Icon(Icons.functions_rounded, size: 21),
            tooltip: 'Constants',
          ),
          IconButton(
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsScreen())),
            icon: const Icon(Icons.tune_rounded, size: 21),
            tooltip: 'Settings',
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 4, 16, 32),
        children: [
          SizedBox(
            height: 40,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: UnitData.categories.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (_, i) {
                final selected = i == _catIndex;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _catIndex = i;
                      _fromUnit = UnitData.categories[i].units.keys.first;
                      _toUnit = UnitData.categories[i].units.keys.last;
                    });
                    _convert();
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: selected ? AppColors.accent : surface,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: selected
                          ? [BoxShadow(color: AppColors.accent.withValues(alpha: 0.3), blurRadius: 8, offset: const Offset(0, 2))]
                          : null,
                    ),
                    child: Center(
                      child: Text(
                        UnitData.categories[i].name,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                          color: selected ? Colors.black : sub,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 20),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
              color: surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: surfaceVar.withValues(alpha: 0.5)),
            ),
            child: TextField(
              controller: _inputCtrl,
              keyboardType: TextInputType.number,
              onChanged: (_) => _convert(),
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 32,
                fontWeight: FontWeight.w600,
                color: fg,
              ),
              decoration: InputDecoration(
                labelText: 'Enter value',
                labelStyle: TextStyle(color: sub.withOpacity(0.5), fontSize: 13),
                border: InputBorder.none,
                suffixIcon: IconButton(
                  onPressed: () {
                    _inputCtrl.clear();
                    _convert();
                  },
                  icon: Icon(Icons.close_rounded, color: sub.withOpacity(0.35), size: 18),
                ),
              ),
            ),
          ),

          const SizedBox(height: 14),

          Row(
            children: [
              Expanded(child: _dropdown('From', _fromUnit, units, surface, fg, sub, (v) {
                setState(() => _fromUnit = v!);
                _convert();
              })),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: GestureDetector(
                  onTap: _swap,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [AppColors.accent, AppColors.accentDim],
                      ),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(color: AppColors.accent.withValues(alpha: 0.3), blurRadius: 8, offset: const Offset(0, 2)),
                      ],
                    ),
                    child: const Icon(Icons.swap_vert_rounded, color: Colors.black, size: 20),
                  ),
                ),
              ),
              Expanded(child: _dropdown('To', _toUnit, units, surface, fg, sub, (v) {
                setState(() => _toUnit = v!);
                _convert();
              })),
            ],
          ),

          const SizedBox(height: 20),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
            decoration: BoxDecoration(
              color: surface,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: surfaceVar.withValues(alpha: 0.5)),
            ),
            child: Column(
              children: [
                Text(
                  '${_inputCtrl.text} $_fromUnit',
                  style: TextStyle(fontSize: 14, color: sub.withOpacity(0.6)),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.accent.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.arrow_downward_rounded, color: AppColors.accent, size: 18),
                ),
                const SizedBox(height: 10),
                FittedBox(
                  child: Text(
                    UnitData.formatResult(_result),
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 40,
                      fontWeight: FontWeight.w700,
                      color: AppColors.accent,
                      height: 1.1,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Text(_toUnit, style: TextStyle(fontSize: 14, color: sub.withOpacity(0.6))),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _actionBtn(Icons.copy_rounded, 'Copy', _copyResult, sub),
                    const SizedBox(width: 8),
                    _actionBtn(Icons.share_rounded, 'Share', _shareResult, sub),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 14),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              color: surfaceVar.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.calculate_rounded, size: 14, color: sub.withOpacity(0.4)),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    _formula(),
                    style: TextStyle(fontFamily: 'monospace', fontSize: 12, color: sub.withOpacity(0.6)),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formula() {
    final v = _inputCtrl.text;
    if (_catIndex == 2) return '$_fromUnit → $_toUnit temperature conversion';
    final cat = UnitData.categories[_catIndex];
    final f = cat.units[_fromUnit]!;
    final t = cat.units[_toUnit]!;
    return '$v × ${f.toStringAsPrecision(6)} ÷ ${t.toStringAsPrecision(6)} = ${UnitData.formatResult(_result)}';
  }

  Widget _actionBtn(IconData icon, String label, VoidCallback onTap, Color sub) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.accent.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 15, color: AppColors.accent),
            const SizedBox(width: 6),
            Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.accent)),
          ],
        ),
      ),
    );
  }

  Widget _dropdown(String label, String value, List<String> items, Color surface, Color fg, Color sub, ValueChanged<String?> onChanged) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: surface.withValues(alpha: 0.8)),
      ),
      child: DropdownButtonFormField<String>(
        value: value,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: sub.withOpacity(0.5), fontSize: 12),
          border: InputBorder.none,
          isDense: true,
        ),
        dropdownColor: surface,
        style: TextStyle(fontSize: 14, color: fg, fontWeight: FontWeight.w600),
        icon: Icon(Icons.keyboard_arrow_down_rounded, color: sub.withOpacity(0.5), size: 20),
        items: items.map((u) => DropdownMenuItem(value: u, child: Text(u))).toList(),
        onChanged: onChanged,
      ),
    );
  }
}
