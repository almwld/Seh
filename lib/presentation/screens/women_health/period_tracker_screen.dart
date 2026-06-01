import 'package:flutter/material.dart';
import 'package:sehatak/core/constants/app_colors.dart';

class PeriodTrackerScreen extends StatefulWidget {
  const PeriodTrackerScreen({super.key});
  @override
  State<PeriodTrackerScreen> createState() => _PeriodTrackerScreenState();
}

class _PeriodTrackerScreenState extends State<PeriodTrackerScreen> {
  int _cycleDay = 15;

  final List<Map<String, String>> _articles = const [
    {'title': 'سرطان الثدي: الكشف المبكر', 'desc': 'تعرفي على طرق الفحص الذاتي وأهمية الماموجرام', 'icon': '🎀'},
    {'title': 'هشاشة العظام عند النساء', 'desc': 'الوقاية والعلاج بعد سن اليأس', 'icon': '🦴'},
    {'title': 'صحة ما بعد الولادة', 'desc': 'نصائح للعناية بنفسك بعد الولادة', 'icon': '🤱'},
    {'title': 'الالتهابات النسائية', 'desc': 'الأسباب والعلاج والوقاية', 'icon': '🩺'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('صحة المرأة', style: TextStyle(fontWeight: FontWeight.bold))),
      body: SingleChildScrollView(padding: const EdgeInsets.all(14), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.pink.shade300, Colors.purple.shade400]), borderRadius: BorderRadius.circular(16)),
          child: Column(children: [
            Text('اليوم $_cycleDay من 28', style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Container(padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5), decoration: BoxDecoration(color: Colors.white.withOpacity(0.25), borderRadius: BorderRadius.circular(12)), child: const Text('مرحلة: جريبي', style: TextStyle(color: Colors.white))),
            const SizedBox(height: 10),
            LinearProgressIndicator(value: _cycleDay / 28, backgroundColor: Colors.white24, color: Colors.white, minHeight: 6, borderRadius: BorderRadius.circular(3)),
            const SizedBox(height: 8),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [Text('الدورة القادمة: ${28 - _cycleDay} يوم', style: const TextStyle(color: Colors.white70, fontSize: 11)), Text('الإباضة: ${14 - _cycleDay} يوم', style: const TextStyle(color: Colors.white70, fontSize: 11))]),
          ]),
        ),
        const SizedBox(height: 16),
        Wrap(spacing: 6, runSpacing: 6, children: ['😊 طبيعي', '😣 تقلصات', '😴 تعب', '😤 انتفاخ', '🤕 صداع', '🍫 اشتهاء'].map((s) => FilterChip(label: Text(s, style: const TextStyle(fontSize: 10)), selected: true, selectedColor: Colors.pink.shade100, onSelected: (_) {})).toList()),
        const SizedBox(height: 16),
        Text('مقالات', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
        ..._articles.map((a) => Container(margin: const EdgeInsets.only(bottom: 8), padding: const EdgeInsets.all(14), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 4)]), child: Row(children: [Text(a['icon']!, style: const TextStyle(fontSize: 32)), const SizedBox(width: 10), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(a['title']!, style: const TextStyle(fontWeight: FontWeight.bold)), Text(a['desc']!, style: const TextStyle(fontSize: 10, color: AppColors.grey))]))]))),
      ])),
    );
  }
}
