import 'package:flutter/material.dart';
import 'package:sehatak/core/constants/app_colors.dart';

class MedicationReminderScreen extends StatefulWidget {
  const MedicationReminderScreen({super.key});
  @override
  State<MedicationReminderScreen> createState() => _MedicationReminderScreenState();
}

class _MedicationReminderScreenState extends State<MedicationReminderScreen> {
  final List<Map<String, dynamic>> _medications = [
    {'name': 'أملوديبين', 'dose': '5mg', 'time': '8:00 ص', 'frequency': 'يومياً', 'icon': '💊', 'color': AppColors.primary, 'taken': true, 'remaining': 25, 'total': 30},
    {'name': 'أوميبرازول', 'dose': '40mg', 'time': '9:00 ص', 'frequency': 'قبل الأكل', 'icon': '💊', 'color': AppColors.success, 'taken': true, 'remaining': 8, 'total': 14},
    {'name': 'فيتامين د', 'dose': '1000IU', 'time': '2:00 م', 'frequency': 'أحد/أربعاء/جمعة', 'icon': '💊', 'color': AppColors.amber, 'taken': false, 'remaining': 45, 'total': 60},
    {'name': 'سيتريزين', 'dose': '10mg', 'time': '10:00 م', 'frequency': 'عند اللزوم', 'icon': '💊', 'color': AppColors.info, 'taken': false, 'remaining': 12, 'total': 20},
  ];

  int get _takenToday => _medications.where((m) => m['taken'] == true).length;
  int get _totalToday => _medications.length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('تذكير الأدوية', style: TextStyle(fontWeight: FontWeight.bold)), actions: [IconButton(icon: const Icon(Icons.history), onPressed: () {})]),
      body: Column(children: [
        // ملخص اليوم
        Container(
          margin: const EdgeInsets.all(14),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(gradient: const LinearGradient(colors: [AppColors.primary, AppColors.primaryDark]), borderRadius: BorderRadius.circular(16)),
          child: Column(children: [
            const Text('جرعات اليوم', style: TextStyle(color: Colors.white70, fontSize: 14)),
            const SizedBox(height: 4),
            Text('$_takenToday/$_totalToday', style: const TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            LinearProgressIndicator(value: _takenToday / _totalToday, backgroundColor: Colors.white24, color: Colors.white, minHeight: 6, borderRadius: BorderRadius.circular(3)),
          ]),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            itemCount: _medications.length,
            itemBuilder: (context, index) {
              final m = _medications[index];
              return Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 6)]),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(children: [
                    Container(width: 44, height: 44, decoration: BoxDecoration(color: (m['color'] as Color).withOpacity(0.08), borderRadius: BorderRadius.circular(10)), child: Center(child: Text(m['icon'], style: const TextStyle(fontSize: 22)))),
                    const SizedBox(width: 10),
                    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(m['name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                      Text('${m['dose']} • ${m['frequency']}', style: const TextStyle(fontSize: 10, color: AppColors.grey)),
                      Text(m['time'], style: TextStyle(fontSize: 12, color: m['taken'] ? AppColors.success : AppColors.warning, fontWeight: FontWeight.bold)),
                    ])),
                    Checkbox(value: m['taken'], activeColor: AppColors.success, onChanged: (v) => setState(() => m['taken'] = v)),
                  ]),
                  const SizedBox(height: 8),
                  Row(children: [
                    Text('متبقي: ${m['remaining']}/${m['total']}', style: const TextStyle(fontSize: 10, color: AppColors.grey)),
                    const SizedBox(width: 8),
                    Expanded(child: LinearProgressIndicator(value: (m['remaining'] as int) / (m['total'] as int), backgroundColor: AppColors.surfaceContainerLow, color: (m['remaining'] as int) < 5 ? AppColors.error : AppColors.success, minHeight: 3, borderRadius: BorderRadius.circular(2))),
                  ]),
                ]),
              );
            },
          ),
        ),
      ]),
      floatingActionButton: FloatingActionButton.extended(onPressed: () {}, backgroundColor: AppColors.primary, icon: const Icon(Icons.add), label: const Text('إضافة دواء')),
    );
  }
}
