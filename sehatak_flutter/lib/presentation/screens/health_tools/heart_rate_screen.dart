import 'package:flutter/material.dart';
import 'package:sehatak/core/constants/app_colors.dart';

class HeartRateScreen extends StatefulWidget {
  const HeartRateScreen({super.key});
  @override
  State<HeartRateScreen> createState() => _HeartRateScreenState();
}

class _HeartRateScreenState extends State<HeartRateScreen> {
  int _age = 30;
  int _restingHR = 72;
  bool _isAthlete = false;

  int get _maxHR => 220 - _age;
  int get _targetMin => ((_maxHR - _restingHR) * 0.5 + _restingHR).round();
  int get _targetMax => ((_maxHR - _restingHR) * 0.85 + _restingHR).round();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('معدل ضربات القلب')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(14),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(gradient: const LinearGradient(colors: [AppColors.error, Color(0xFFC62828)]), borderRadius: BorderRadius.circular(16)),
            child: Column(children: [
              const Icon(Icons.favorite, color: Colors.white, size: 48),
              const SizedBox(height: 8),
              const Text('أقصى معدل لقلبك', style: TextStyle(color: Colors.white70, fontSize: 14)),
              Text('$_maxHR', style: const TextStyle(color: Colors.white, fontSize: 48, fontWeight: FontWeight.bold)),
              const Text('نبضة/دقيقة', style: TextStyle(color: Colors.white70)),
            ]),
          ),
          const SizedBox(height: 16),
          // نطاق التمرين
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 6)]),
            child: Column(children: [
              const Text('نطاق التمرين المثالي', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 12),
              Row(children: [
                _zoneCard('إحماء', 50, 60, AppColors.success),
                _zoneCard('حرق دهون', 60, 70, AppColors.info),
                _zoneCard('تحمل', 70, 80, AppColors.warning),
                _zoneCard('أقصى مجهود', 80, 90, AppColors.error),
              ]),
              const SizedBox(height: 10),
              Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.05), borderRadius: BorderRadius.circular(12)), child: Row(children: [const Icon(Icons.info, color: AppColors.primary), const SizedBox(width: 8), Expanded(child: Text('معدل التمرين الموصى: $_targetMin - $_targetMax نبضة/دقيقة', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)))])),
            ]),
          ),
          const SizedBox(height: 16),
          // إعدادات
          _sliderSetting('العمر', _age.toDouble(), 1, 100, (v) => setState(() => _age = v.toInt())),
          _sliderSetting('معدل الراحة', _restingHR.toDouble(), 40, 100, (v) => setState(() => _restingHR = v.toInt())),
          SwitchListTile(title: const Text('رياضي محترف'), value: _isAthlete, activeColor: AppColors.primary, onChanged: (v) => setState(() => _isAthlete = v)),
        ]),
      ),
    );
  }

  Widget _zoneCard(String label, int minPercent, int maxPercent, Color color) {
    final min = (_maxHR * minPercent / 100).round();
    final max = (_maxHR * maxPercent / 100).round();
    return Expanded(
      child: Container(margin: const EdgeInsets.symmetric(horizontal: 2), padding: const EdgeInsets.all(6), decoration: BoxDecoration(color: color.withOpacity(0.08), borderRadius: BorderRadius.circular(8)), child: Column(children: [Text(label, style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold, color: color)), const SizedBox(height: 2), Text('$min-$max', style: TextStyle(fontSize: 10, color: color))])),
    );
  }

  Widget _sliderSetting(String label, double value, double min, double max, Function(double) onChange) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 4)]),
      child: Column(children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(label), Text('${value.toInt()}', style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary))]),
        Slider(value: value, min: min, max: max, activeColor: AppColors.primary, onChanged: onChange),
      ]),
    );
  }
}
