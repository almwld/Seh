import 'package:flutter/material.dart';
import 'package:sehatak/core/constants/app_colors.dart';

class SymptomCheckerScreen extends StatefulWidget {
  const SymptomCheckerScreen({super.key});
  @override
  State<SymptomCheckerScreen> createState() => _SymptomCheckerScreenState();
}

class _SymptomCheckerScreenState extends State<SymptomCheckerScreen> {
  final List<Map<String, dynamic>> _bodyParts = const [
    {'name': 'رأس', 'icon': '🗣️', 'symptoms': ['صداع', 'دوخة', 'طنين الأذن', 'ألم العين', 'احتقان الأنف', 'ألم الأسنان']},
    {'name': 'صدر', 'icon': '💪', 'symptoms': ['ألم الصدر', 'ضيق التنفس', 'خفقان القلب', 'سعال', 'بلغم']},
    {'name': 'بطن', 'icon': '🦵', 'symptoms': ['ألم البطن', 'غثيان', 'إسهال', 'إمساك', 'انتفاخ', 'حرقة المعدة']},
    {'name': 'ظهر', 'icon': '🧍', 'symptoms': ['ألم الظهر', 'ألم الرقبة', 'ألم الكتف', 'ألم المفاصل', 'تصلب العضلات']},
    {'name': 'عام', 'icon': '🏃', 'symptoms': ['حمى', 'تعب', 'فقدان الوزن', 'زيادة الوزن', 'تعرق ليلي', 'فقدان الشهية']},
  ];

  final Set<String> _selectedSymptoms = {};
  String _result = '';

  final Map<String, String> _diagnosis = {
    'صداع,حمى,تعب': 'قد تكون مصاباً بالإنفلونزا أو نزلة برد. ننصحك بالراحة وشرب السوائل.',
    'ألم الصدر,ضيق التنفس,خفقان القلب': '⚠️ حالة طارئة! يجب التوجه فوراً لأقرب مستشفى.',
    'ألم البطن,غثيان,إسهال': 'قد يكون تسمم غذائي أو التهاب معوي. اشرب الماء بكثرة وراجع الطبيب.',
    'صداع,دوخة,تعب': 'قد يكون فقر دم أو إجهاد. ننصح بفحص الدم والراحة.',
    'حمى,سعال,احتقان الأنف': 'أعراض تنفسية. قد تكون نزلة برد أو التهاب جيوب أنفية.',
    'ألم الظهر,ألم الرقبة,تصلب العضلات': 'قد يكون إجهاد عضلي. ننصح بالراحة وتمارين الإطالة.',
    'حرقة المعدة,انتفاخ,غثيان': 'قد يكون ارتجاع معدي مريئي. تجنب الأطعمة الدسمة والحارة.',
    'فقدان الوزن,تعب,فقدان الشهية': 'يجب مراجعة الطبيب للفحص الشامل.',
  };

  void _checkSymptoms() {
    final key = _selectedSymptoms.toList()..sort();
    final joined = key.join(',');
    String result = 'الرجاء استشارة الطبيب للتشخيص الدقيق.';

    for (var entry in _diagnosis.entries) {
      if (entry.key.split(',').every((s) => _selectedSymptoms.contains(s)) && _selectedSymptoms.length >= entry.key.split(',').length) {
        result = entry.value;
        break;
      }
    }
    setState(() => _result = result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('فحص الأعراض')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(14),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: AppColors.warning.withOpacity(0.05), borderRadius: BorderRadius.circular(14), border: Border.all(color: AppColors.warning.withOpacity(0.3))),
            child: Row(children: [const Icon(Icons.warning_amber, color: AppColors.warning, size: 28), const SizedBox(width: 10), const Expanded(child: Text('هذه الأداة للمساعدة فقط وليست بديلاً عن الاستشارة الطبية المتخصصة', style: TextStyle(fontSize: 11, color: AppColors.darkGrey)))]),
          ),
          const SizedBox(height: 16),
          Text('اختر الأعراض التي تشعر بها', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          ..._bodyParts.map((part) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [Text(part['icon'], style: const TextStyle(fontSize: 24)), const SizedBox(width: 8), Text(part['name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16))]),
              const SizedBox(height: 6),
              Wrap(spacing: 6, runSpacing: 6, children: (part['symptoms'] as List).map((s) => FilterChip(
                label: Text(s, style: const TextStyle(fontSize: 11)),
                selected: _selectedSymptoms.contains(s),
                selectedColor: AppColors.primary.withOpacity(0.2),
                checkmarkColor: AppColors.primary,
                onSelected: (v) => setState(() { if (v) { _selectedSymptoms.add(s); } else { _selectedSymptoms.remove(s); } _result = ''; }),
              )).toList()),
              const SizedBox(height: 14),
            ],
          )),
          if (_selectedSymptoms.isNotEmpty) ...[
            SizedBox(width: double.infinity, child: ElevatedButton(onPressed: _checkSymptoms, style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, padding: const EdgeInsets.symmetric(vertical: 14)), child: const Text('تحليل الأعراض'))),
            if (_result.isNotEmpty) ...[
              const SizedBox(height: 14),
              Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: AppColors.info.withOpacity(0.05), borderRadius: BorderRadius.circular(14), border: Border.all(color: AppColors.info.withOpacity(0.3))), child: Row(children: [const Icon(Icons.info, color: AppColors.info, size: 24), const SizedBox(width: 10), Expanded(child: Text(_result, style: const TextStyle(fontSize: 14, height: 1.4)))]),),
            ],
          ],
        ]),
      ),
    );
  }
}
