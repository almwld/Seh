import 'package:flutter/material.dart';
import 'package:sehatak/core/constants/app_colors.dart';

class BMICalculatorScreen extends StatefulWidget {
  const BMICalculatorScreen({super.key});
  @override
  State<BMICalculatorScreen> createState() => _BMICalculatorScreenState();
}

class _BMICalculatorScreenState extends State<BMICalculatorScreen> {
  double _height = 170;
  double _weight = 70;
  int _age = 25;
  bool _isMale = true;

  double get _bmi => _weight / ((_height / 100) * (_height / 100));

  String get _bmiCategory {
    if (_bmi < 18.5) return 'نقص الوزن';
    if (_bmi < 25) return 'وزن طبيعي';
    if (_bmi < 30) return 'زيادة وزن';
    return 'سمنة';
  }

  Color get _bmiColor {
    if (_bmi < 18.5) return AppColors.warning;
    if (_bmi < 25) return AppColors.success;
    if (_bmi < 30) return AppColors.amber;
    return AppColors.error;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('حاسبة BMI')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          // الجنس
          Row(children: [
            _genderCard('ذكر', Icons.male, _isMale, () => setState(() => _isMale = true)),
            const SizedBox(width: 12),
            _genderCard('أنثى', Icons.female, !_isMale, () => setState(() => _isMale = false)),
          ]),
          const SizedBox(height: 20),
          // النتيجة
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(color: _bmiColor.withOpacity(0.08), borderRadius: BorderRadius.circular(20), border: Border.all(color: _bmiColor.withOpacity(0.2))),
            child: Column(children: [
              const Text('مؤشر كتلة الجسم', style: TextStyle(color: AppColors.grey)),
              const SizedBox(height: 8),
              Text(_bmi.toStringAsFixed(1), style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: _bmiColor)),
              Text(_bmiCategory, style: TextStyle(fontSize: 18, color: _bmiColor, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text('الوزن المثالي: ${(_height - 100) * 0.9} - ${(_height - 100) * 1.1} كجم', style: const TextStyle(color: AppColors.grey, fontSize: 12)),
            ]),
          ),
          const SizedBox(height: 20),
          // الطول
          _sliderCard('الطول (سم)', _height, 100, 220, (v) => setState(() => _height = v)),
          _sliderCard('الوزن (كجم)', _weight, 30, 200, (v) => setState(() => _weight = v)),
          _sliderCard('العمر', _age.toDouble(), 1, 120, (v) => setState(() => _age = v.toInt())),
        ]),
      ),
    );
  }

  Widget _genderCard(String label, IconData icon, bool selected, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(padding: const EdgeInsets.all(20), decoration: BoxDecoration(color: selected ? AppColors.primary.withOpacity(0.08) : Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: selected ? AppColors.primary : AppColors.outlineVariant)), child: Column(children: [Icon(icon, size: 40, color: selected ? AppColors.primary : AppColors.grey), const SizedBox(height: 8), Text(label, style: TextStyle(color: selected ? AppColors.primary : AppColors.grey, fontWeight: FontWeight.bold))])),
      ),
    );
  }

  Widget _sliderCard(String label, double value, double min, double max, Function(double) onChange) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 4)]),
      child: Column(children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(label, style: const TextStyle(fontWeight: FontWeight.w500)), Text('${value.toInt()}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: AppColors.primary))]),
        Slider(value: value, min: min, max: max, activeColor: AppColors.primary, onChanged: onChange),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text('${min.toInt()}', style: const TextStyle(fontSize: 10, color: AppColors.grey)), Text('${max.toInt()}', style: const TextStyle(fontSize: 10, color: AppColors.grey))]),
      ]),
    );
  }
}
