import 'package:flutter/material.dart';
import 'package:sehatak/core/constants/app_colors.dart';

class GlucoseTrackerScreen extends StatefulWidget {
  const GlucoseTrackerScreen({super.key});
  @override
  State<GlucoseTrackerScreen> createState() => _GlucoseTrackerScreenState();
}

class _GlucoseTrackerScreenState extends State<GlucoseTrackerScreen> {
  final List<Map<String, dynamic>> _todayReadings = const [
    {'time': 'قبل الفطور', 'value': 95, 'status': 'طبيعي', 'icon': '☀️'},
    {'time': 'بعد الفطور', 'value': 140, 'status': 'مرتفع', 'icon': '🍳'},
    {'time': 'قبل الغداء', 'value': 88, 'status': 'طبيعي', 'icon': '🌤️'},
    {'time': 'بعد الغداء', 'value': 155, 'status': 'مرتفع', 'icon': '🍛'},
    {'time': 'قبل العشاء', 'value': 102, 'status': 'طبيعي', 'icon': '🌅'},
    {'time': 'بعد العشاء', 'value': 180, 'status': 'عالي', 'icon': '🌙'},
  ];

  final List<Map<String, dynamic>> _weekReadings = const [
    {'day': 'سبت', 'morning': 95, 'evening': 140},
    {'day': 'أحد', 'morning': 102, 'evening': 135},
    {'day': 'إثنين', 'morning': 88, 'evening': 155},
    {'day': 'ثلاثاء', 'morning': 98, 'evening': 148},
    {'day': 'أربعاء', 'morning': 92, 'evening': 142},
    {'day': 'خميس', 'morning': 105, 'evening': 138},
    {'day': 'جمعة', 'morning': 100, 'evening': 180},
  ];

  Color _statusColor(String status) {
    switch (status) {
      case 'طبيعي': return AppColors.success;
      case 'مرتفع': return AppColors.warning;
      case 'عالي': return AppColors.error;
      default: return AppColors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('تتبع السكر', style: TextStyle(fontWeight: FontWeight.bold))),
      body: SingleChildScrollView(padding: const EdgeInsets.all(14), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(padding: const EdgeInsets.all(20), decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.blue.shade300, Colors.blue.shade700]), borderRadius: BorderRadius.circular(16)), child: Column(children: [
          const Text('متوسط السكر التراكمي المقدر', style: TextStyle(color: Colors.white70, fontSize: 14)),
          const Text('5.7%', style: TextStyle(color: Colors.white, fontSize: 42, fontWeight: FontWeight.bold)),
          const Text('HbA1c تقديري', style: TextStyle(color: Colors.white70, fontSize: 12)),
        ])),
        const SizedBox(height: 18),
        Text('قراءات اليوم', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
        ..._todayReadings.map((r) => Container(
          margin: const EdgeInsets.only(bottom: 8), padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
          child: Row(children: [
            Text(r['icon']!, style: const TextStyle(fontSize: 24)),
            const SizedBox(width: 10),
            Expanded(child: Text(r['time']!, style: const TextStyle(fontWeight: FontWeight.w500))),
            Text('${r['value']}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: AppColors.primary)),
            const SizedBox(width: 8),
            Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: _statusColor(r['status']!).withOpacity(0.1), borderRadius: BorderRadius.circular(6)), child: Text(r['status']!, style: TextStyle(fontSize: 9, color: _statusColor(r['status']!)))),
          ]),
        )),
        const SizedBox(height: 18),
        Text('نظرة أسبوعية', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
        Container(padding: const EdgeInsets.all(14), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14)), height: 160, child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: _weekReadings.map((r) {
          int m = r['morning'] as int;
          int e = r['evening'] as int;
          return Expanded(child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
            Text('$e', style: const TextStyle(fontSize: 8, color: Colors.orange)),
            Container(width: 14, height: (e - 70) / 110 * 100, decoration: BoxDecoration(color: Colors.orange.withOpacity(0.6), borderRadius: BorderRadius.circular(3))),
            Text('$m', style: const TextStyle(fontSize: 8, color: Colors.blue)),
            Container(width: 14, height: (m - 70) / 110 * 100, decoration: BoxDecoration(color: Colors.blue.withOpacity(0.6), borderRadius: BorderRadius.circular(3))),
            const SizedBox(height: 4),
            Text(r['day']!, style: const TextStyle(fontSize: 9, color: AppColors.grey)),
          ]));
        }).toList())),
      ])),
    );
  }
}
