import 'package:flutter/material.dart';
import 'package:sehatak/core/constants/app_colors.dart';

class RiskCalculatorScreen extends StatefulWidget {
  const RiskCalculatorScreen({super.key});
  @override
  State<RiskCalculatorScreen> createState() => _RiskCalculatorScreenState();
}

class _RiskCalculatorScreenState extends State<RiskCalculatorScreen> {
  int _age = 40;
  bool _smoker = false;
  bool _diabetic = false;
  bool _hypertensive = false;
  bool _obese = false;
  bool _familyHistory = false;

  String get _riskLevel {
    int score = 0;
    if (_age > 45) score += 2;
    if (_smoker) score += 3;
    if (_diabetic) score += 3;
    if (_hypertensive) score += 2;
    if (_obese) score += 2;
    if (_familyHistory) score += 1;
    if (score <= 3) return 'منخفض';
    if (score <= 7) return 'متوسط';
    return 'مرتفع';
  }

  Color get _riskColor {
    switch (_riskLevel) {
      case 'منخفض': return AppColors.success;
      case 'متوسط': return AppColors.warning;
      case 'مرتفع': return AppColors.error;
      default: return AppColors.grey;
    }
  }

  List<String> get _recommendations {
    final list = <String>[];
    if (_smoker) list.add('• أقلع عن التدخين فوراً');
    if (_diabetic) list.add('• تحكم بمستوى السكر لديك');
    if (_hypertensive) list.add('• راقب ضغط الدم بانتظام');
    if (_obese) list.add('• ابدأ برنامجاً لإنقاص الوزن');
    list.add('• مارس الرياضة 30 دقيقة يومياً');
    list.add('• تناول غذاءً صحياً متوازناً');
    list.add('• قم بفحص دوري سنوي');
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('حاسبة خطر الأمراض', style: TextStyle(fontWeight: FontWeight.bold))),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(14),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // النتيجة
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(gradient: LinearGradient(colors: [_riskColor.withOpacity(0.7), _riskColor]), borderRadius: BorderRadius.circular(16)),
            child: Column(children: [
              const Text('مستوى الخطر', style: TextStyle(color: Colors.white70, fontSize: 14)),
              const SizedBox(height: 4),
              Text(_riskLevel, style: const TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              const Text('للأمراض القلبية والسكتة الدماغية', style: TextStyle(color: Colors.white70, fontSize: 11))
            ]),
          ),
          const SizedBox(height: 18),

          // العوامل
          Text('العوامل المؤثرة', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          _sliderSetting('العمر', _age.toString(), (v) => setState(() => _age = v.toInt()), 20, 80),
          _switchSetting('التدخين', 'أدخن حالياً', _smoker, (v) => setState(() => _smoker = v)),
          _switchSetting('السكري', 'مصاب بالسكري', _diabetic, (v) => setState(() => _diabetic = v)),
          _switchSetting('ضغط الدم', 'مصاب بارتفاع ضغط الدم', _hypertensive, (v) => setState(() => _hypertensive = v)),
          _switchSetting('السمنة', 'مؤشر كتلة جسم > 30', _obese, (v) => setState(() => _obese = v)),
          _switchSetting('تاريخ عائلي', 'أمراض قلب في العائلة', _familyHistory, (v) => setState(() => _familyHistory = v)),
          const SizedBox(height: 16),

          // التوصيات
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(color: _riskColor.withOpacity(0.05), borderRadius: BorderRadius.circular(14), border: Border.all(color: _riskColor.withOpacity(0.2))),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('💡 توصيات', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: _riskColor)),
              const SizedBox(height: 8),
              ..._recommendations.map((r) => Text(r, style: const TextStyle(fontSize: 12, height: 1.5))),
            ]),
          ),
        ]),
      ),
    );
  }

  Widget _sliderSetting(String label, String value, Function(double) onChange, double min, double max) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 4)]),
      child: Column(children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(label), Text(value, style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary))]),
        Slider(value: double.parse(value), min: min, max: max, activeColor: AppColors.primary, onChanged: onChange),
      ]),
    );
  }

  Widget _switchSetting(String title, String subtitle, bool value, Function(bool) onChange) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 4)]),
      child: SwitchListTile(title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)), subtitle: Text(subtitle, style: const TextStyle(fontSize: 10, color: AppColors.grey)), value: value, activeColor: AppColors.primary, onChanged: onChange),
    );
  }
}
