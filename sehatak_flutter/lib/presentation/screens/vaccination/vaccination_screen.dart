import 'package:flutter/material.dart';
import 'package:sehatak/core/constants/app_colors.dart';

class VaccinationScreen extends StatelessWidget {
  const VaccinationScreen({super.key});

  final List<Map<String, dynamic>> _vaccines = const [
    {'name': 'كورونا (كوفيد-19)', 'doses': '3 جرعات', 'status': 'مكتمل', 'date': 'يناير 2025', 'icon': '🦠', 'color': AppColors.success},
    {'name': 'الإنفلونزا الموسمية', 'doses': 'سنوياً', 'status': 'قريباً', 'date': 'أكتوبر 2026', 'icon': '🤧', 'color': AppColors.warning},
    {'name': 'التهاب الكبد ب', 'doses': '3 جرعات', 'status': 'مكتمل', 'date': '2023', 'icon': '🫁', 'color': AppColors.success},
    {'name': 'الكزاز', 'doses': 'كل 10 سنوات', 'status': 'قادم', 'date': '2028', 'icon': '💉', 'color': AppColors.info},
    {'name': 'شلل الأطفال', 'doses': '5 جرعات', 'status': 'مكتمل', 'date': 'طفولة', 'icon': '👶', 'color': AppColors.success},
    {'name': 'الحصبة والنكاف', 'doses': 'جرعتين', 'status': 'مكتمل', 'date': 'طفولة', 'icon': '🔴', 'color': AppColors.success},
    {'name': 'المكورات الرئوية', 'doses': 'جرعة', 'status': 'موصى به', 'date': '65+ سنة', 'icon': '🫁', 'color': AppColors.purple},
    {'name': 'فيروس الورم الحليمي', 'doses': '3 جرعات', 'status': 'موصى به', 'date': 'للفتيات', 'icon': '👩', 'color': AppColors.purple},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('سجل التطعيمات', style: TextStyle(fontWeight: FontWeight.bold))),
      body: SingleChildScrollView(padding: const EdgeInsets.all(14), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(gradient: const LinearGradient(colors: [AppColors.success, AppColors.teal]), borderRadius: BorderRadius.circular(16)), child: const Column(children: [Icon(Icons.verified_user, color: Colors.white, size: 40), SizedBox(height: 8), Text('سجل التطعيمات', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)), Text('5 تطعيمات مكتملة • 3 موصى بها', style: TextStyle(color: Colors.white70, fontSize: 12))])),
        const SizedBox(height: 16),
        ..._vaccines.map((v) => Container(
          margin: const EdgeInsets.only(bottom: 8), padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 6)]),
          child: Row(children: [
            Text(v['icon'], style: const TextStyle(fontSize: 30)), const SizedBox(width: 12),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(v['name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)), Text('${v['doses']} • ${v['date']}', style: const TextStyle(fontSize: 10, color: AppColors.grey))])),
            Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), decoration: BoxDecoration(color: (v['color'] as Color).withOpacity(0.08), borderRadius: BorderRadius.circular(8)), child: Text(v['status'], style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: v['color']))),
          ]),
        )),
      ])),
    );
  }
}
