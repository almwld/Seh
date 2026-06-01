import 'package:flutter/material.dart';
import 'package:sehatak/core/constants/app_colors.dart';

class RecoveryCalculatorScreen extends StatefulWidget {
  const RecoveryCalculatorScreen({super.key});
  @override
  State<RecoveryCalculatorScreen> createState() => _RecoveryCalculatorScreenState();
}

class _RecoveryCalculatorScreenState extends State<RecoveryCalculatorScreen> {
  String _selectedCondition = 'نزلة برد';
  int _age = 30;
  bool _isSmoker = false;
  bool _isExercising = true;

  final Map<String, Map<String, dynamic>> _conditions = {
    'نزلة برد': {'min': 3, 'max': 7, 'unit': 'أيام', 'icon': '🤧', 'color': AppColors.info, 'advice': 'راحة، سوائل، فيتامين C'},
    'إنفلونزا': {'min': 5, 'max': 14, 'unit': 'أيام', 'icon': '🤒', 'color': AppColors.warning, 'advice': 'راحة تامة، سوائل، باراسيتامول'},
    'جرح بسيط': {'min': 7, 'max': 14, 'unit': 'أيام', 'icon': '🩹', 'color': AppColors.success, 'advice': 'تنظيف يومي، تغيير ضماد'},
    'كسر بسيط': {'min': 30, 'max': 60, 'unit': 'يوم', 'icon': '🦴', 'color': AppColors.error, 'advice': 'تثبيت، علاج طبيعي'},
    'شد عضلي': {'min': 3, 'max': 10, 'unit': 'أيام', 'icon': '💪', 'color': AppColors.purple, 'advice': 'راحة، كمادات، مسكن'},
    'عملية جراحية بسيطة': {'min': 14, 'max': 30, 'unit': 'يوم', 'icon': '🏥', 'color': AppColors.teal, 'advice': 'متابعة طبية، راحة'},
  };

  int get _estimatedDays {
    final c = _conditions[_selectedCondition]!;
    int days = ((c['min'] + c['max']) / 2).round();
    if (_isSmoker) days = (days * 1.5).round();
    if (_isExercising) days = (days * 0.7).round();
    if (_age > 50) days = (days * 1.3).round();
    return days;
  }

  @override
  Widget build(BuildContext context) {
    final c = _conditions[_selectedCondition]!;
    return Scaffold(
      appBar: AppBar(title: const Text('حاسبة التعافي', style: TextStyle(fontWeight: FontWeight.bold))),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(14),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Wrap(spacing: 6, children: _conditions.keys.map((k) => ChoiceChip(
            label: Text('${_conditions[k]!['icon']} $k', style: const TextStyle(fontSize: 11)),
            selected: _selectedCondition == k,
            selectedColor: (c['color'] as Color),
            labelStyle: TextStyle(color: _selectedCondition == k ? Colors.white : AppColors.darkGrey),
            onSelected: (_) => setState(() => _selectedCondition = k),
          )).toList()),
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(gradient: LinearGradient(colors: [(c['color'] as Color).withOpacity(0.7), (c['color'] as Color)]), borderRadius: BorderRadius.circular(16)),
            child: Column(children: [
              Text(c['icon'], style: const TextStyle(fontSize: 48)),
              const SizedBox(height: 8),
              const Text('مدة التعافي المتوقعة', style: TextStyle(color: Colors.white70, fontSize: 14)),
              Text('$_estimatedDays ${c['unit']}', style: const TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.bold)),
              Text('من ${c['min']} إلى ${c['max']} ${c['unit']}', style: const TextStyle(color: Colors.white70, fontSize: 12)),
            ]),
          ),
          const SizedBox(height: 16),
          _settingCard('العمر', '$_age سنة', (v) => setState(() => _age = v.toInt()), 1, 100),
          SwitchListTile(title: const Text('مدخن'), value: _isSmoker, activeColor: AppColors.primary, onChanged: (v) => setState(() => _isSmoker = v)),
          SwitchListTile(title: const Text('أمارس الرياضة'), value: _isExercising, activeColor: AppColors.primary, onChanged: (v) => setState(() => _isExercising = v)),
          const SizedBox(height: 12),
          Container(padding: const EdgeInsets.all(14), decoration: BoxDecoration(color: AppColors.success.withOpacity(0.05), borderRadius: BorderRadius.circular(14)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('💡 نصائح للتعافي', style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text('• ${c['advice']}', style: const TextStyle(fontSize: 12)),
            const Text('• التزم بتعليمات الطبيب', style: TextStyle(fontSize: 12)),
            const Text('• تغذية صحية متوازنة', style: TextStyle(fontSize: 12)),
          ])),
        ]),
      ),
    );
  }

  Widget _settingCard(String label, String value, Function(double) onChange, double min, double max) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 4)]),
      child: Column(children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(label), Text(value, style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary))]),
        Slider(value: double.parse(value.split(' ')[0]), min: min, max: max, activeColor: AppColors.primary, onChanged: onChange),
      ]),
    );
  }
}
