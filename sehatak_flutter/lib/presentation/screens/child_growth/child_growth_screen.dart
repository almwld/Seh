import 'package:flutter/material.dart';
import 'package:sehatak/core/constants/app_colors.dart';

class ChildGrowthScreen extends StatelessWidget {
  const ChildGrowthScreen({super.key});

  final List<Map<String, dynamic>> _stages = const [
    {'age': '0-3 أشهر', 'motor': 'يرفع رأسه', 'social': 'يبتسم', 'language': 'يصدر أصواتاً', 'icon': '👶', 'color': AppColors.pink},
    {'age': '4-6 أشهر', 'motor': 'ينقلب', 'social': 'يضحك بصوت', 'language': 'يناغي', 'icon': '👶', 'color': AppColors.success},
    {'age': '7-9 أشهر', 'motor': 'يجلس', 'social': 'يخاف الغرباء', 'language': 'با با', 'icon': '👶', 'color': AppColors.info},
    {'age': '10-12 شهر', 'motor': 'يحبو', 'social': 'يلوح بيده', 'language': 'ما ما', 'icon': '👶', 'color': AppColors.warning},
    {'age': '1-2 سنة', 'motor': 'يمشي', 'social': 'يقلد الكبار', 'language': '20 كلمة', 'icon': '🧒', 'color': AppColors.purple},
    {'age': '2-3 سنوات', 'motor': 'يجري', 'social': 'يلعب مع آخرين', 'language': 'جمل كاملة', 'icon': '🧒', 'color': AppColors.teal},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('نمو الطفل', style: TextStyle(fontWeight: FontWeight.bold))),
      body: SingleChildScrollView(padding: const EdgeInsets.all(14), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(gradient: const LinearGradient(colors: [AppColors.pink, AppColors.purple]), borderRadius: BorderRadius.circular(16)), child: const Row(children: [Icon(Icons.child_care, color: Colors.white, size: 40), SizedBox(width: 12), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('مراحل نمو طفلك', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)), Text('تابع تطور طفلك خطوة بخطوة', style: TextStyle(color: Colors.white70, fontSize: 12))]))])),
        const SizedBox(height: 16),
        ..._stages.map((s) => Container(
          margin: const EdgeInsets.only(bottom: 8), padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 6)]),
          child: Row(children: [
            Text(s['icon'], style: const TextStyle(fontSize: 32)), const SizedBox(width: 8),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(s['age'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              Row(children: [_chip('🏃 ${s['motor']}', s['color']), const SizedBox(width: 4), _chip('👥 ${s['social']}', s['color']), const SizedBox(width: 4), _chip('🗣️ ${s['language']}', s['color'])]),
            ])),
          ]),
        )),
        Container(padding: const EdgeInsets.all(14), decoration: BoxDecoration(color: AppColors.success.withOpacity(0.05), borderRadius: BorderRadius.circular(14)), child: const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('💡 نصائح', style: TextStyle(fontWeight: FontWeight.bold)), Text('• كل طفل يتطور بوتيرته الخاصة', style: TextStyle(fontSize: 12)), Text('• استشر الطبيب إذا تأخر في 3 مراحل', style: TextStyle(fontSize: 12)), Text('• تحدث مع طفلك كثيراً لتنمية اللغة', style: TextStyle(fontSize: 12))])),
      ])),
    );
  }

  Widget _chip(String label, Color color) {
    return Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: color.withOpacity(0.08), borderRadius: BorderRadius.circular(4)), child: Text(label, style: TextStyle(fontSize: 9, color: color)));
  }
}
