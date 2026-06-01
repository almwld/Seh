import 'package:flutter/material.dart';
import 'package:sehatak/core/constants/app_colors.dart';

class CheckupReminderScreen extends StatelessWidget {
  const CheckupReminderScreen({super.key});

  final List<Map<String, dynamic>> _checkups = const [
    {'name': 'فحص السكر', 'frequency': 'كل 6 أشهر', 'next': '15 يوليو 2026', 'done': false, 'icon': '💉', 'color': AppColors.info},
    {'name': 'قياس الضغط', 'frequency': 'شهرياً', 'next': '1 يونيو 2026', 'done': true, 'icon': '🩺', 'color': AppColors.primary},
    {'name': 'فحص الكوليسترول', 'frequency': 'سنوياً', 'next': '10 سبتمبر 2026', 'done': false, 'icon': '🧪', 'color': AppColors.warning},
    {'name': 'فحص الأسنان', 'frequency': 'كل 6 أشهر', 'next': '20 أغسطس 2026', 'done': false, 'icon': '🦷', 'color': AppColors.teal},
    {'name': 'فحص العيون', 'frequency': 'سنوياً', 'next': '5 ديسمبر 2026', 'done': false, 'icon': '👁️', 'color': AppColors.purple},
    {'name': 'تحليل فيتامين د', 'frequency': 'سنوياً', 'next': '1 يناير 2027', 'done': false, 'icon': '☀️', 'color': AppColors.amber},
    {'name': 'فحص البروستاتا', 'frequency': 'سنوياً (40+)', 'next': '10 مارس 2027', 'done': false, 'icon': '🩸', 'color': AppColors.error},
    {'name': 'تطعيم الإنفلونزا', 'frequency': 'سنوياً', 'next': '15 أكتوبر 2026', 'done': false, 'icon': '💊', 'color': AppColors.success},
  ];

  @override
  Widget build(BuildContext context) {
    final done = _checkups.where((c) => c['done']).length;
    return Scaffold(
      appBar: AppBar(title: const Text('تذكير الفحوصات الدورية', style: TextStyle(fontWeight: FontWeight.bold))),
      body: Column(children: [
        Container(
          margin: const EdgeInsets.all(14),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(gradient: const LinearGradient(colors: [AppColors.primary, AppColors.primaryDark]), borderRadius: BorderRadius.circular(16)),
          child: Column(children: [
            Text('$done/${_checkups.length}', style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)),
            const Text('فحص مكتمل', style: TextStyle(color: Colors.white70, fontSize: 14)),
            const SizedBox(height: 8),
            LinearProgressIndicator(value: done / _checkups.length, backgroundColor: Colors.white24, color: Colors.white, minHeight: 5, borderRadius: BorderRadius.circular(3)),
          ]),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            itemCount: _checkups.length,
            itemBuilder: (context, idx) {
              final c = _checkups[idx];
              return Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 4)]),
                child: Row(children: [
                  Container(width: 40, height: 40, decoration: BoxDecoration(color: (c['color'] as Color).withOpacity(0.08), shape: BoxShape.circle), child: Center(child: Text(c['icon'], style: const TextStyle(fontSize: 20)))),
                  const SizedBox(width: 10),
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(c['name'], style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13)),
                    Text('${c['frequency']} • القادم: ${c['next']}', style: const TextStyle(fontSize: 9, color: AppColors.grey)),
                  ])),
                  Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3), decoration: BoxDecoration(color: c['done'] ? AppColors.success.withOpacity(0.1) : AppColors.warning.withOpacity(0.1), borderRadius: BorderRadius.circular(6)), child: Text(c['done'] ? 'تم' : 'قادم', style: TextStyle(fontSize: 9, color: c['done'] ? AppColors.success : AppColors.warning, fontWeight: FontWeight.bold))),
                ]),
              );
            },
          ),
        ),
      ]),
    );
  }
}
