import 'package:flutter/material.dart';
import 'package:sehatak/core/constants/app_colors.dart';

class PediatricDoseScreen extends StatefulWidget {
  const PediatricDoseScreen({super.key});
  @override
  State<PediatricDoseScreen> createState() => _PediatricDoseScreenState();
}

class _PediatricDoseScreenState extends State<PediatricDoseScreen> {
  double _weight = 15;
  String _selectedMed = 'باراسيتامول';

  final Map<String, Map<String, dynamic>> _medicines = {
    'باراسيتامول': {'dose': 15, 'unit': 'mg/kg', 'frequency': 'كل 6 ساعات', 'maxDaily': 60, 'icon': '💊', 'color': AppColors.primary},
    'إيبوبروفين': {'dose': 10, 'unit': 'mg/kg', 'frequency': 'كل 8 ساعات', 'maxDaily': 40, 'icon': '💊', 'color': AppColors.error},
    'أموكسيسيلين': {'dose': 50, 'unit': 'mg/kg', 'frequency': 'كل 8 ساعات', 'maxDaily': 150, 'icon': '💊', 'color': AppColors.success},
    'سيتريزين': {'dose': 0.25, 'unit': 'mg/kg', 'frequency': 'مرة يومياً', 'maxDaily': 0.5, 'icon': '💊', 'color': AppColors.info},
  };

  double get _singleDose => (_medicines[_selectedMed]!['dose'] as double) * _weight;
  double get _maxDaily => (_medicines[_selectedMed]!['maxDaily'] as double) * _weight;

  @override
  Widget build(BuildContext context) {
    final med = _medicines[_selectedMed]!;
    return Scaffold(
      appBar: AppBar(title: const Text('حاسبة أدوية الأطفال', style: TextStyle(fontWeight: FontWeight.bold))),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(14),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.orange.shade300, Colors.pink.shade400]), borderRadius: BorderRadius.circular(16)),
            child: Column(children: [
              const Icon(Icons.child_care, color: Colors.white, size: 48),
              const SizedBox(height: 8),
              const Text('حاسبة جرعات الأطفال', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
              const Text('احسب الجرعة حسب الوزن', style: TextStyle(color: Colors.white70, fontSize: 12)),
            ]),
          ),
          const SizedBox(height: 16),
          // اختيار الدواء
          Text('اختر الدواء', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Wrap(spacing: 6, children: _medicines.keys.map((k) => ChoiceChip(
            label: Text(k),
            selected: _selectedMed == k,
            selectedColor: (med['color'] as Color),
            labelStyle: TextStyle(color: _selectedMed == k ? Colors.white : AppColors.darkGrey, fontSize: 12),
            onSelected: (_) => setState(() => _selectedMed = k),
          )).toList()),
          const SizedBox(height: 16),
          // الوزن
          Text('وزن الطفل', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 6)]),
            child: Column(children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text('الوزن'), Text('${_weight.toInt()} كجم', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: AppColors.primary))]),
              Slider(value: _weight, min: 3, max: 50, activeColor: AppColors.primary, onChanged: (v) => setState(() => _weight = v)),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text('3 كجم', style: TextStyle(fontSize: 10, color: AppColors.grey)), const Text('50 كجم', style: TextStyle(fontSize: 10, color: AppColors.grey))]),
            ]),
          ),
          const SizedBox(height: 14),
          // النتيجة
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(color: (med['color'] as Color).withOpacity(0.05), borderRadius: BorderRadius.circular(16), border: Border.all(color: (med['color'] as Color).withOpacity(0.2))),
            child: Column(children: [
              Text(_selectedMed, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              const SizedBox(height: 10),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                _doseCard('الجرعة الواحدة', '${_singleDose.toStringAsFixed(1)} mg', Icons.medication, med['color']),
                _doseCard('الحد الأقصى', '${_maxDaily.toStringAsFixed(1)} mg', Icons.warning, AppColors.warning),
              ]),
              const SizedBox(height: 10),
              Text('التكرار: ${med['frequency']}', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
            ]),
          ),
          const SizedBox(height: 16),
          Container(padding: const EdgeInsets.all(14), decoration: BoxDecoration(color: AppColors.warning.withOpacity(0.05), borderRadius: BorderRadius.circular(14), border: Border.all(color: AppColors.warning.withOpacity(0.2))), child: const Row(children: [Icon(Icons.warning_amber, color: AppColors.warning, size: 18), SizedBox(width: 8), Expanded(child: Text('استشر الطبيب قبل إعطاء أي دواء لطفلك', style: TextStyle(fontSize: 11, color: AppColors.warning)))])),
        ]),
      ),
    );
  }

  Widget _doseCard(String label, String value, IconData icon, Color color) {
    return Column(children: [Icon(icon, color: color, size: 24), const SizedBox(height: 4), Text(value, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: color)), Text(label, style: const TextStyle(fontSize: 10, color: AppColors.grey))]);
  }
}
