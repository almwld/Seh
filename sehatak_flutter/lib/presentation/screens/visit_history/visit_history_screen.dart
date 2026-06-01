import 'package:flutter/material.dart';
import 'package:sehatak/core/constants/app_colors.dart';

class VisitHistoryScreen extends StatelessWidget {
  const VisitHistoryScreen({super.key});

  final List<Map<String, dynamic>> _visits = const [
    {'doctor': 'د. حسن رضا', 'specialty': 'طبيب عام', 'date': '1 مايو 2026', 'reason': 'فحص دوري', 'diagnosis': 'سليم - لا توجد مشاكل', 'fee': '300', 'image': '👨‍⚕️', 'color': AppColors.success},
    {'doctor': 'د. عثمان خان', 'specialty': 'طبيب قلب', 'date': '25 أبريل 2026', 'reason': 'ألم في الصدر', 'diagnosis': 'إجهاد عضلي - لا مشكلة قلبية', 'fee': '1000', 'image': '👨‍⚕️', 'color': AppColors.info},
    {'doctor': 'د. عائشة ملك', 'specialty': 'طبيبة جلدية', 'date': '18 أبريل 2026', 'reason': 'حساسية جلدية', 'diagnosis': 'إكزيما - وصف مرهم', 'fee': '800', 'image': '👩‍⚕️', 'color': AppColors.warning},
    {'doctor': 'د. فاطمة صديقي', 'specialty': 'طبيبة أطفال', 'date': '10 مارس 2026', 'reason': 'تطعيم أطفال', 'diagnosis': 'تطعيم روتيني', 'fee': '200', 'image': '👩‍⚕️', 'color': AppColors.primary},
    {'doctor': 'د. أسامة خان', 'specialty': 'طبيب عظام', 'date': '5 فبراير 2026', 'reason': 'آلام ظهر', 'diagnosis': 'انزلاق غضروفي بسيط - علاج طبيعي', 'fee': '700', 'image': '👨‍⚕️', 'color': AppColors.purple},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('سجل الزيارات')),
      body: ListView.builder(
        padding: const EdgeInsets.all(14),
        itemCount: _visits.length,
        itemBuilder: (context, index) {
          final v = _visits[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 6)]),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                Container(width: 44, height: 44, decoration: BoxDecoration(color: (v['color'] as Color).withOpacity(0.1), borderRadius: BorderRadius.circular(10)), child: Center(child: Text(v['image'], style: const TextStyle(fontSize: 22)))),
                const SizedBox(width: 10),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(v['doctor'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)), Text(v['specialty'], style: const TextStyle(fontSize: 11, color: AppColors.grey)), Text(v['date'], style: const TextStyle(fontSize: 10, color: AppColors.grey))])),
                Text('${v['fee']} ر.س', style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary, fontSize: 16)),
              ]),
              const Divider(height: 16),
              _detailRow('السبب', v['reason']),
              _detailRow('التشخيص', v['diagnosis']),
              const SizedBox(height: 6),
              Row(children: [
                Expanded(child: OutlinedButton(onPressed: () {}, style: OutlinedButton.styleFrom(foregroundColor: AppColors.primary), child: const Text('تقرير'))),
                const SizedBox(width: 8),
                Expanded(child: ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary), child: const Text('إعادة حجز'))),
              ]),
            ]),
          );
        },
      ),
    );
  }

  Widget _detailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('$label: ', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
        Expanded(child: Text(value, style: const TextStyle(fontSize: 12, color: AppColors.darkGrey))),
      ]),
    );
  }
}
