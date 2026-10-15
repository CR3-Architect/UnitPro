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
  List<String> _history = [];

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
    setState(() {
      _result = UnitData.convert(v, cat.name, _fromUnit, _toUnit);
    });
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
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Copied'), duration: Duration(seconds: 1)),
    );
  }

  void _shareResult() {
    final v = _inputCtrl.text;
    Share.share('$v $_fromUnit = ${UnitData.formatResult(_result)} $_toUnit\nvia UnitPro Studio');
  }

  void _saveHistory() {
    final entry = '$v _fromUnit'.trim();
    final line = '${_inputCtrl.text} $_fromUnit = ${UnitData.formatResult(_result)} $_toUnit';
    setState(() {
      _history.insert(0, line);
      if (_history.length > 50) _history.removeLast();
    });
  }

  String get v => _inputCtrl.text;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final fg = isDark ? AppColors.darkOnBg : AppColors.lightOnBg;
    final sub = isDark ? AppColors.darkOnSurface : AppColors.lightOnSurface;
    final surface = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final surfaceVar = isDark ? AppColors.darkSurfaceVar : AppColors.lightSurfaceVar;
    final cat = UnitData.categories[_catIndex];
    final units = cat.units.keys.toList();

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBg : AppColors.lightBg,
      appBar: AppBar(
        title: const Text('UnitPro Studio', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const HistoryScreen())),
            icon: const Icon(Icons.history_rounded, size: 22),
            tooltip: 'History',
          ),
          IconButton(
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ConstantsScreen())),
            icon: const Icon(Icons.science_rounded, size: 22),
            tooltip: 'Constants',
          ),
          IconButton(
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsScreen())),
            icon: const Icon(Icons.settings_rounded, size: 22),
            tooltip: 'Settings',
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        children: [
          // Category grid
          SizedBox(
            height: 90,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: UnitData.categories.length,
              itemBuilder: (_, i) {
                final c = UnitData.categories[i];
                final selected = i == _catIndex;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _catIndex = i;
                        _fromUnit = c.units.keys.first;
                        _toUnit = c.units.keys.last;
                      });
                      _convert();
                    },
                    child: Container(
                      width: 76,
                      decoration: BoxDecoration(
                        color: selected ? AppColors.accent.withValues(alpha: 0.15) : surface,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: selected ? AppColors.accent : Colors.transparent,
                          width: 1.5,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            _iconData(c.icon),
                            size: 22,
                            color: selected ? AppColors.accent : sub,
                          ),
                          const SizedBox(height: 6),
                          Text(
                            c.name,
                            style: TextStyle(
                              fontSize: 10.5,
                              fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                              color: fg,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 20),

          // Input
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            decoration: BoxDecoration(
              color: surface,
              borderRadius: BorderRadius.circular(14),
            ),
            child: TextField(
              controller: _inputCtrl,
              keyboardType: TextInputType.number,
              onChanged: (_) => _convert(),
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 28,
                fontWeight: FontWeight.w600,
                color: fg,
              ),
              decoration: InputDecoration(
                labelText: 'Value',
                labelStyle: TextStyle(color: sub.withOpacity(0.6), fontSize: 13),
                border: InputBorder.none,
                suffixIcon: IconButton(
                  onPressed: () {
                    _inputCtrl.clear();
                    _convert();
                  },
                  icon: Icon(Icons.clear_rounded, color: sub.withOpacity(0.4), size: 18),
                ),
              ),
            ),
          ),

          const SizedBox(height: 12),

          // From / To
          Row(
            children: [
              Expanded(child: _unitDropdown('From', _fromUnit, units, surface, fg, sub, (v) {
                setState(() => _fromUnit = v!);
                _convert();
              })),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: GestureDetector(
                  onTap: _swap,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.accent.withValues(alpha: 0.15),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.swap_vert_rounded, color: AppColors.accent, size: 22),
                  ),
                ),
              ),
              Expanded(child: _unitDropdown('To', _toUnit, units, surface, fg, sub, (v) {
                setState(() => _toUnit = v!);
                _convert();
              })),
            ],
          ),

          const SizedBox(height: 20),

          // Result card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: surface,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                Text(
                  '${_inputCtrl.text} $_fromUnit',
                  style: TextStyle(fontSize: 14, color: sub.withOpacity(0.6)),
                ),
                const SizedBox(height: 6),
                const Icon(Icons.arrow_downward_rounded, color: AppColors.accent, size: 20),
                const SizedBox(height: 6),
                FittedBox(
                  child: Text(
                    UnitData.formatResult(_result),
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 36,
                      fontWeight: FontWeight.w700,
                      color: AppColors.accent,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(_toUnit, style: TextStyle(fontSize: 14, color: sub.withOpacity(0.6))),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton.icon(
                      onPressed: _copyResult,
                      icon: const Icon(Icons.copy_rounded, size: 15),
                      label: const Text('Copy'),
                    ),
                    TextButton.icon(
                      onPressed: _shareResult,
                      icon: const Icon(Icons.share_rounded, size: 15),
                      label: const Text('Share'),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Quick formula
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: surfaceVar.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              _formula(),
              style: TextStyle(fontFamily: 'monospace', fontSize: 12, color: sub.withOpacity(0.7)),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  String _formula() {
    final v = _inputCtrl.text;
    if (_catIndex == 2) {
      return '$_fromUnit → $_toUnit temperature conversion';
    }
    final cat = UnitData.categories[_catIndex];
    final f = cat.units[_fromUnit]!;
    final t = cat.units[_toUnit]!;
    return '$v × ${f.toStringAsPrecision(6)} ÷ ${t.toStringAsPrecision(6)}';
  }

  Widget _unitDropdown(String label, String value, List<String> items, Color surface, Color fg, Color sub, ValueChanged<String?> onChanged) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButtonFormField<String>(
        value: value,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: sub.withOpacity(0.6), fontSize: 12),
          border: InputBorder.none,
          isDense: true,
        ),
        dropdownColor: surface,
        style: TextStyle(fontSize: 14, color: fg, fontWeight: FontWeight.w500),
        icon: Icon(Icons.arrow_drop_down_rounded, color: sub.withOpacity(0.5)),
        items: items.map((u) => DropdownMenuItem(value: u, child: Text(u))).toList(),
        onChanged: onChanged,
      ),
    );
  }

  IconData _iconData(String name) {
    switch (name) {
      case 'straighten': return Icons.straighten_rounded;
      case 'fitness_center': return Icons.fitness_center_rounded;
      case 'thermostat': return Icons.thermostat_rounded;
      case 'schedule': return Icons.schedule_rounded;
      case 'speed': return Icons.speed_rounded;
      case 'crop_square': return Icons.crop_square_rounded;
      case 'water_drop': return Icons.water_drop_rounded;
      case 'storage': return Icons.storage_rounded;
      case 'bolt': return Icons.bolt_rounded;
      case 'compress': return Icons.compress_rounded;
      case 'radio': return Icons.radio_rounded;
      case 'rotate_right': return Icons.rotate_right_rounded;
      default: return Icons.category_rounded;
    }
  }
}
