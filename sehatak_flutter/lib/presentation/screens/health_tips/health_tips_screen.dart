import 'package:flutter/material.dart';
import 'package:sehatak/core/constants/app_colors.dart';

class HealthTipsScreen extends StatefulWidget {
  const HealthTipsScreen({super.key});
  @override
  State<HealthTipsScreen> createState() => _HealthTipsScreenState();
}

class _HealthTipsScreenState extends State<HealthTipsScreen> {
  String _selectedCategory = 'تغذية';

  final Map<String, List<String>> _tips = {
    'تغذية': ['تناول 5 حصص من الفواكه والخضروات يومياً', 'اشرب 8 أكواب من الماء يومياً', 'تجنب الوجبات السريعة والمشروبات الغازية', 'تناول الأسماك مرتين أسبوعياً', 'اختر الحبوب الكاملة بدلاً من المكررة', 'قلل من استهلاك الملح والسكر', 'تناول وجبة فطور متوازنة يومياً'],
    'رياضة': ['مارس المشي 30 دقيقة يومياً', 'تمارين الإطالة صباحاً ومساءً', 'استخدم الدرج بدلاً من المصعد', 'مارس تمارين القوة مرتين أسبوعياً', 'خذ استراحة كل ساعة عمل', 'مارس السباحة لتقوية العضلات'],
    'نوم': ['نم 7-8 ساعات يومياً', 'تجنب الشاشات قبل النوم بساعة', 'حافظ على مواعيد نوم ثابتة', 'اجعل غرفة النوم مظلمة وهادئة', 'تجنب الكافيين مساءً', 'مارس تمارين الاسترخاء قبل النوم'],
    'صحة نفسية': ['مارس التأمل 10 دقائق يومياً', 'تواصل مع الأصدقاء والعائلة', 'خصص وقتاً لهواياتك', 'اكتب 3 أشياء تشعر بالامتنان لها', 'تعلم أن تقول "لا" عند الحاجة', 'خذ استراحة من وسائل التواصل'],
    'وقاية': ['اغسل يديك بانتظام', 'احصل على التطعيمات الموسمية', 'فحص سنوي شامل', 'تجنب التدخين والكحول', 'استخدم واقي الشمس يومياً', 'نظف أسنانك مرتين يومياً'],
    'صحة القلب': ['قس ضغط الدم بانتظام', 'قلل من استهلاك الملح', 'تناول الدهون الصحية', 'راقب مستوى الكوليسترول', 'تحكم في التوتر والقلق', 'مارس تمارين الكارديو'],
  };

  @override
  Widget build(BuildContext context) {
    final currentTips = _tips[_selectedCategory] ?? [];
    return Scaffold(
      appBar: AppBar(title: const Text('نصائح صحية', style: TextStyle(fontWeight: FontWeight.bold))),
      body: Column(children: [
        SizedBox(
          height: 90,
          child: ListView.builder(scrollDirection: Axis.horizontal, padding: const EdgeInsets.all(10), itemCount: _tips.keys.length, itemBuilder: (context, i) {
            final cat = _tips.keys.elementAt(i);
            final icons = ['🥗', '🏃', '😴', '🧘', '🛡️', '❤️'];
            final colors = [AppColors.success, AppColors.info, AppColors.purple, AppColors.teal, AppColors.primary, AppColors.error];
            final selected = _selectedCategory == cat;
            return GestureDetector(
              onTap: () => setState(() => _selectedCategory = cat),
              child: Container(width: 85, margin: const EdgeInsets.only(right: 8), decoration: BoxDecoration(color: selected ? colors[i].withOpacity(0.08) : Colors.white, borderRadius: BorderRadius.circular(14), border: Border.all(color: selected ? colors[i] : AppColors.outlineVariant.withOpacity(0.3))), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Text(icons[i], style: const TextStyle(fontSize: 28)), Text(cat, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500, color: selected ? colors[i] : AppColors.darkGrey))])),
            );
          }),
        ),
        const Divider(height: 1),
        Expanded(
          child: ListView.builder(padding: const EdgeInsets.all(12), itemCount: currentTips.length, itemBuilder: (context, i) => Container(
            margin: const EdgeInsets.only(bottom: 6),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 4)]),
            child: Row(children: [Container(width: 32, height: 32, decoration: BoxDecoration(color: AppColors.success.withOpacity(0.1), shape: BoxShape.circle), child: const Icon(Icons.check, color: AppColors.success, size: 16)), const SizedBox(width: 10), Expanded(child: Text(currentTips[i], style: const TextStyle(fontSize: 13, height: 1.4)))]),
          )),
        ),
      ]),
    );
  }
}
