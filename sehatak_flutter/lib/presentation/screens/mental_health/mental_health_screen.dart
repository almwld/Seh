import 'package:flutter/material.dart';
import 'package:sehatak/core/constants/app_colors.dart';

class MentalHealthScreen extends StatelessWidget {
  const MentalHealthScreen({super.key});

  final List<Map<String, dynamic>> _services = const [
    {'name': 'استشارة نفسية', 'icon': '🧠', 'color': AppColors.purple, 'desc': 'جلسات مع أخصائي نفسي'},
    {'name': 'تأمل واسترخاء', 'icon': '🧘', 'color': AppColors.teal, 'desc': 'تمارين تنفس وتأمل موجه'},
    {'name': 'علاج سلوكي', 'icon': '💭', 'color': AppColors.info, 'desc': 'علاج معرفي سلوكي CBT'},
    {'name': 'مقياس اكتئاب', 'icon': '📊', 'color': AppColors.warning, 'desc': 'اختبار فحص الاكتئاب'},
    {'name': 'مقياس قلق', 'icon': '📈', 'color': AppColors.amber, 'desc': 'اختبار فحص القلق'},
    {'name': 'دعم فوري', 'icon': '🆘', 'color': AppColors.error, 'desc': 'خط ساخن للدعم النفسي'},
    {'name': 'مجموعات دعم', 'icon': '👥', 'color': AppColors.success, 'desc': 'انضم لمجموعات الدعم'},
    {'name': 'محتوى توعوي', 'icon': '📚', 'color': AppColors.primary, 'desc': 'مقالات وفيديوهات توعوية'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('الصحة النفسية')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(14),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.purple.shade400, Colors.purple.shade700]), borderRadius: BorderRadius.circular(16)),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text('صحتي النفسية', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 6),
              const Text('صحّتك النفسية تهمنا.. أنت لست وحدك 🤍', style: TextStyle(color: Colors.white70, fontSize: 14)),
              const SizedBox(height: 14),
              ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: Colors.purple), child: const Text('احجز استشارة')),
            ]),
          ),
          const SizedBox(height: 18),
          // شبكة الخدمات
          GridView.count(
            crossAxisCount: 2, shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 10, mainAxisSpacing: 10, childAspectRatio: 0.95,
            children: _services.map((s) => Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 6)]),
              child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(s['icon'], style: const TextStyle(fontSize: 36)),
                const SizedBox(height: 8),
                Text(s['name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13), textAlign: TextAlign.center),
                const SizedBox(height: 4),
                Text(s['desc'], style: const TextStyle(fontSize: 9, color: AppColors.grey), textAlign: TextAlign.center),
              ]),
            )).toList(),
          ),
          const SizedBox(height: 18),
          // بطاقة الدعم الفوري
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: AppColors.error.withOpacity(0.05), borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.error.withOpacity(0.2))),
            child: Row(children: [const Icon(Icons.sos, color: AppColors.error, size: 32), const SizedBox(width: 12), const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('تحتاج مساعدة فورية؟', style: TextStyle(fontWeight: FontWeight.bold)), Text('اتصل على خط الدعم النفسي', style: TextStyle(fontSize: 12, color: AppColors.grey))])), ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: AppColors.error), child: const Text('اتصل الآن'))]),
          ),
        ]),
      ),
    );
  }
}
