import 'package:flutter/material.dart';
import 'package:sehatak/core/constants/app_colors.dart';

class AdvancedReminderScreen extends StatefulWidget {
  const AdvancedReminderScreen({super.key});
  @override
  State<AdvancedReminderScreen> createState() => _AdvancedReminderScreenState();
}

class _AdvancedReminderScreenState extends State<AdvancedReminderScreen> {
  final List<Map<String, dynamic>> _medications = [
    {'name': 'أملوديبين 5mg', 'time': '8:00 ص', 'taken': true, 'remaining': 25, 'total': 30, 'refill': '18 يونيو', 'icon': '💊', 'color': AppColors.primary},
    {'name': 'أوميبرازول 40mg', 'time': '9:00 ص', 'taken': true, 'remaining': 3, 'total': 14, 'refill': '10 يونيو', 'icon': '💊', 'color': AppColors.success},
    {'name': 'فيتامين د 1000IU', 'time': '2:00 م', 'taken': false, 'remaining': 45, 'total': 60, 'refill': '30 أغسطس', 'icon': '💊', 'color': AppColors.amber},
    {'name': 'سيتريزين 10mg', 'time': '10:00 م', 'taken': false, 'remaining': 8, 'total': 20, 'refill': '5 يوليو', 'icon': '💊', 'color': AppColors.info},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('التذكير المتقدم', style: TextStyle(fontWeight: FontWeight.bold))),
      body: ListView.builder(
        padding: const EdgeInsets.all(14),
        itemCount: _medications.length,
        itemBuilder: (context, idx) {
          final m = _medications[idx];
          final needsRefill = (m['remaining'] as int) < 5;
          return Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8)]),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                Container(width: 44, height: 44, decoration: BoxDecoration(color: (m['color'] as Color).withOpacity(0.08), borderRadius: BorderRadius.circular(10)), child: Center(child: Text(m['icon'], style: const TextStyle(fontSize: 22)))),
                const SizedBox(width: 10),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(m['name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  Text(m['time'], style: const TextStyle(fontSize: 11, color: AppColors.grey)),
                ])),
                Checkbox(value: m['taken'], activeColor: AppColors.success, onChanged: (v) => setState(() => m['taken'] = v)),
              ]),
              const SizedBox(height: 10),
              Row(children: [
                Expanded(child: LinearProgressIndicator(value: (m['remaining'] as int) / (m['total'] as int), backgroundColor: AppColors.surfaceContainerLow, color: needsRefill ? AppColors.error : AppColors.success, minHeight: 5, borderRadius: BorderRadius.circular(3))),
                const SizedBox(width: 8),
                Text('${m['remaining']}/${m['total']}', style: TextStyle(fontSize: 11, color: needsRefill ? AppColors.error : AppColors.grey)),
              ]),
              if (needsRefill)
                Container(
                  margin: const EdgeInsets.only(top: 8),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(color: AppColors.error.withOpacity(0.05), borderRadius: BorderRadius.circular(8)),
                  child: Row(children: [const Icon(Icons.warning, color: AppColors.error, size: 14), const SizedBox(width: 4), Text('يحتاج إعادة تعبئة قبل ${m['refill']}', style: const TextStyle(color: AppColors.error, fontSize: 10))]),
                ),
              const SizedBox(height: 8),
              Row(children: [
                Expanded(child: OutlinedButton(onPressed: () {}, child: const Text('تأجيل', style: TextStyle(fontSize: 10)))),
                const SizedBox(width: 6),
                Expanded(child: ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary), child: const Text('إعادة تعبئة', style: TextStyle(fontSize: 10)))),
              ]),
            ]),
          );
        },
      ),
    );
  }
}
