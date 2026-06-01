import 'package:flutter/material.dart';
import 'package:sehatak/core/constants/app_colors.dart';

class FamilyDoctorScreen extends StatelessWidget {
  const FamilyDoctorScreen({super.key});

  final List<Map<String, dynamic>> _members = const [
    {'name': 'أحمد محمد', 'relation': 'الأب', 'age': '45', 'blood': 'O+', 'conditions': 'ضغط، سكري', 'icon': '👨', 'color': AppColors.info},
    {'name': 'فاطمة علي', 'relation': 'الأم', 'age': '42', 'blood': 'A+', 'conditions': 'لا يوجد', 'icon': '👩', 'color': AppColors.pink},
    {'name': 'سارة أحمد', 'relation': 'ابنة', 'age': '12', 'blood': 'O+', 'conditions': 'حساسية', 'icon': '👧', 'color': AppColors.success},
    {'name': 'عمر أحمد', 'relation': 'ابن', 'age': '8', 'blood': 'O-', 'conditions': 'ربو', 'icon': '👦', 'color': AppColors.purple},
    {'name': 'مريم أحمد', 'relation': 'جدة', 'age': '70', 'blood': 'B+', 'conditions': 'قلب، عظام', 'icon': '👵', 'color': AppColors.warning},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('طبيب العائلة', style: TextStyle(fontWeight: FontWeight.bold)), actions: [IconButton(icon: const Icon(Icons.add), onPressed: () {})]),
      body: SingleChildScrollView(padding: const EdgeInsets.all(14), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(gradient: const LinearGradient(colors: [AppColors.primary, AppColors.primaryDark]), borderRadius: BorderRadius.circular(16)), child: const Row(children: [Icon(Icons.family_restroom, color: Colors.white, size: 40), SizedBox(width: 12), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('عائلة محمد', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)), Text('5 أفراد', style: TextStyle(color: Colors.white70))]))])),
        const SizedBox(height: 16),
        ..._members.map((m) => Container(
          margin: const EdgeInsets.only(bottom: 8), padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 6)]),
          child: Row(children: [
            Container(width: 48, height: 48, decoration: BoxDecoration(color: (m['color'] as Color).withOpacity(0.08), shape: BoxShape.circle), child: Center(child: Text(m['icon'], style: const TextStyle(fontSize: 26)))),
            const SizedBox(width: 10),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(m['name'], style: const TextStyle(fontWeight: FontWeight.bold)), Text('${m['relation']} • ${m['age']} سنة', style: const TextStyle(fontSize: 10, color: AppColors.grey)), Row(children: [Icon(Icons.bloodtype, size: 14, color: AppColors.error), const SizedBox(width: 4), Text(m['blood'], style: const TextStyle(fontSize: 11)), const SizedBox(width: 10), const Icon(Icons.medical_services, size: 14, color: AppColors.warning), const SizedBox(width: 4), Text(m['conditions'], style: const TextStyle(fontSize: 11))])])),
            IconButton(icon: const Icon(Icons.calendar_today, color: AppColors.primary), onPressed: () {}),
            IconButton(icon: const Icon(Icons.chat, color: AppColors.success), onPressed: () {}),
          ]),
        )),
        const SizedBox(height: 10),
        SizedBox(width: double.infinity, child: ElevatedButton.icon(onPressed: () {}, icon: const Icon(Icons.add), label: const Text('إضافة فرد'), style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, padding: const EdgeInsets.symmetric(vertical: 14)))),
      ])),
    );
  }
}
