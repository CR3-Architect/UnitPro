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
    HapticFeedback.selectionClick();
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

  void _openUnitPicker(String side) {
    final cat = UnitData.categories[_catIndex];
    final current = side == 'from' ? _fromUnit : _toUnit;
    HapticFeedback.selectionClick();
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => _UnitPickerSheet(
        title: side == 'from' ? 'Convert from' : 'Convert to',
        categoryName: cat.name,
        categoryIcon: cat.icon,
        selected: current,
        units: cat.units,
        showFactors: cat.name != 'Temperature',
        onPick: (u) {
          Navigator.pop(context);
          setState(() {
            if (side == 'from') {
              _fromUnit = u;
            } else {
              _toUnit = u;
            }
          });
          _convert();
        },
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
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const HistoryScreen())),
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
                    HapticFeedback.selectionClick();
                    setState(() {
                      _catIndex = i;
                      _fromUnit = UnitData.categories[i].units.keys.first;
                      _toUnit = UnitData.categories[i].units.keys.last;
                    });
                    _convert();
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    curve: Curves.easeOut,
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    decoration: BoxDecoration(
                      color: selected ? AppColors.accent : surface,
                      borderRadius: BorderRadius.circular(20),
                      border: selected ? null : Border.all(color: surfaceVar.withValues(alpha: 0.6)),
                      boxShadow: selected
                          ? [BoxShadow(color: AppColors.accent.withValues(alpha: 0.3), blurRadius: 8, offset: const Offset(0, 2))]
                          : null,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          UnitData.categories[i].icon,
                          size: 15,
                          color: selected ? Colors.black : sub,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          UnitData.categories[i].name,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                            color: selected ? Colors.black : sub,
                          ),
                        ),
                      ],
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
              _unitSelector('From', _fromUnit, () => _openUnitPicker('from'), surface, surfaceVar, fg, sub),
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
              _unitSelector('To', _toUnit, () => _openUnitPicker('to'), surface, surfaceVar, fg, sub),
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
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
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
                  fit: BoxFit.scaleDown,
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
                Text(_toUnit, style: TextStyle(fontSize: 14, color: sub.withOpacity(0.6)), overflow: TextOverflow.ellipsis, maxLines: 1),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _actionBtn(Icons.copy_rounded, 'Copy', _copyResult),
                    const SizedBox(width: 8),
                    _actionBtn(Icons.share_rounded, 'Share', _shareResult),
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
            child: Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 8,
              children: [
                Icon(Icons.calculate_rounded, size: 14, color: sub.withOpacity(0.4)),
                Text(
                  _formula(),
                  style: TextStyle(fontFamily: 'monospace', fontSize: 12, color: sub.withOpacity(0.6)),
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

  Widget _unitSelector(String label, String unit, VoidCallback onTap, Color surface, Color surfaceVar, Color fg, Color sub) {
    return Expanded(
      child: Material(
        color: surface,
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: surfaceVar.withValues(alpha: 0.5)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(label, style: TextStyle(fontSize: 11, color: sub.withOpacity(0.6))),
                      const SizedBox(height: 2),
                      Text(
                        unit,
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: fg),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 4),
                Icon(Icons.keyboard_arrow_down_rounded, color: sub.withOpacity(0.5), size: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _actionBtn(IconData icon, String label, VoidCallback onTap) {
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
}

/// Professional bottom-sheet unit picker
class _UnitPickerSheet extends StatelessWidget {
  final String title;
  final String categoryName;
  final IconData categoryIcon;
  final String selected;
  final Map<String, double> units;
  final bool showFactors;
  final ValueChanged<String> onPick;

  const _UnitPickerSheet({
    required this.title,
    required this.categoryName,
    required this.categoryIcon,
    required this.selected,
    required this.units,
    required this.showFactors,
    required this.onPick,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final fg = isDark ? AppColors.darkOnBg : AppColors.lightOnBg;
    final sub = isDark ? AppColors.darkOnSurface : AppColors.lightOnSurface;
    final surface = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final entries = units.entries.toList();

    return Container(
      constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.68),
      decoration: BoxDecoration(
        color: surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 10),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: sub.withOpacity(0.25),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 8, 12),
              child: Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: AppColors.accent.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(categoryIcon, color: AppColors.accent, size: 20),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: fg)),
                        const SizedBox(height: 2),
                        Text(
                          '$categoryName · ${entries.length} units',
                          style: TextStyle(fontSize: 12, color: sub.withOpacity(0.6)),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.close_rounded, color: sub.withOpacity(0.5), size: 22),
                  ),
                ],
              ),
            ),
            Divider(height: 1, color: sub.withOpacity(0.08)),
            Flexible(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                itemCount: entries.length,
                separatorBuilder: (_, __) => const SizedBox(height: 4),
                itemBuilder: (_, i) {
                  final name = entries[i].key;
                  final factor = entries[i].value;
                  final isSel = name == selected;
                  return Material(
                    color: isSel ? surface.withValues(alpha: 0.5) : Colors.transparent,
                    borderRadius: BorderRadius.circular(14),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(14),
                      onTap: () => onPick(name),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          border: isSel
                              ? Border.all(color: AppColors.accent.withValues(alpha: 0.35))
                              : null,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                name,
                                style: TextStyle(
                                  fontSize: 14.5,
                                  fontWeight: isSel ? FontWeight.w700 : FontWeight.w500,
                                  color: fg,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(width: 10),
                            if (showFactors && factor != 1) ...[
                              Text(
                                '× ${UnitData.formatResult(factor)}',
                                style: TextStyle(
                                  fontFamily: 'monospace',
                                  fontSize: 11,
                                  color: sub.withOpacity(0.45),
                                ),
                              ),
                              const SizedBox(width: 6),
                            ],
                            if (isSel) ...[
                              const Icon(Icons.check_rounded, color: AppColors.accent, size: 18),
                            ],
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
