import 'package:flutter/material.dart';
import 'package:sehatak/core/constants/app_colors.dart';

class NearbyClinicsScreen extends StatelessWidget {
  const NearbyClinicsScreen({super.key});

  final List<Map<String, dynamic>> _clinics = const [
    {'name': 'مجمع السلام الطبي', 'distance': '0.5 كم', 'rating': 4.7, 'specialties': 'عام، أسنان، جلدية', 'open': true, 'closes': '10:00 م', 'image': '🏥', 'phone': '01-456123'},
    {'name': 'مركز ابن سينا', 'distance': '1.2 كم', 'rating': 4.8, 'specialties': 'باطنية، قلب، عظام', 'open': true, 'closes': '9:00 م', 'image': '🏥', 'phone': '01-567234'},
    {'name': 'مجمع الرازي الطبي', 'distance': '2.0 كم', 'rating': 4.5, 'specialties': 'أطفال، نساء، أنف وأذن', 'open': false, 'closes': '8:00 ص', 'image': '🏥', 'phone': '01-678345'},
    {'name': 'مركز اليمن الدولي', 'distance': '2.8 كم', 'rating': 4.6, 'specialties': 'عيون، أعصاب، مسالك', 'open': true, 'closes': '11:00 م', 'image': '🏥', 'phone': '01-789456'},
    {'name': 'العيادة الشاملة', 'distance': '3.5 كم', 'rating': 4.4, 'specialties': 'عام، طوارئ', 'open': true, 'closes': '24 ساعة', 'image': '🏥', 'phone': '01-890567'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('عيادات قريبة', style: TextStyle(fontWeight: FontWeight.bold)), actions: [IconButton(icon: const Icon(Icons.map), onPressed: () {})]),
      body: ListView.builder(
        padding: const EdgeInsets.all(14),
        itemCount: _clinics.length,
        itemBuilder: (context, idx) {
          final c = _clinics[idx];
          return Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 6)]),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                Container(width: 50, height: 50, decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.06), borderRadius: BorderRadius.circular(12)), child: Center(child: Text(c['image'], style: const TextStyle(fontSize: 26)))),
                const SizedBox(width: 10),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(c['name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  Text(c['specialties'], style: const TextStyle(fontSize: 10, color: AppColors.grey)),
                  Row(children: [const Icon(Icons.star, color: AppColors.amber, size: 14), Text(' ${c['rating']}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)), const SizedBox(width: 8), const Icon(Icons.location_on, size: 14, color: AppColors.grey), Text(' ${c['distance']}', style: const TextStyle(fontSize: 11, color: AppColors.grey))]),
                ])),
                Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                  Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3), decoration: BoxDecoration(color: c['open'] ? AppColors.success.withOpacity(0.1) : AppColors.error.withOpacity(0.1), borderRadius: BorderRadius.circular(6)), child: Text(c['open'] ? 'مفتوح' : 'مغلق', style: TextStyle(fontSize: 9, color: c['open'] ? AppColors.success : AppColors.error, fontWeight: FontWeight.bold))),
                  Text(c['closes'], style: const TextStyle(fontSize: 9, color: AppColors.grey)),
                ]),
              ]),
              const SizedBox(height: 10),
              Row(children: [
                Expanded(child: OutlinedButton.icon(onPressed: () {}, icon: const Icon(Icons.call, size: 14), label: Text(c['phone']), style: OutlinedButton.styleFrom(foregroundColor: AppColors.success, padding: const EdgeInsets.symmetric(vertical: 8)))),
                const SizedBox(width: 8),
                Expanded(child: ElevatedButton.icon(onPressed: () {}, icon: const Icon(Icons.navigation, size: 14), label: const Text('توجيه'), style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, padding: const EdgeInsets.symmetric(vertical: 8)))),
              ]),
            ]),
          );
        },
      ),
    );
  }
}
