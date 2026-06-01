import 'package:flutter/material.dart';
import 'package:sehatak/core/constants/app_colors.dart';

class PregnancyTrackerScreen extends StatefulWidget {
  const PregnancyTrackerScreen({super.key});
  @override
  State<PregnancyTrackerScreen> createState() => _PregnancyTrackerScreenState();
}

class _PregnancyTrackerScreenState extends State<PregnancyTrackerScreen> {
  int _week = 24;
  final DateTime _dueDate = DateTime.now().add(const Duration(days: 112));

  final Map<int, Map<String, String>> _tips = {
    8: {'title': 'بداية الحمل', 'baby': 'بحجم حبة الفاصوليا', 'icon': '🫘', 'tip': 'تناولي حمض الفوليك يومياً'},
    16: {'title': 'الثلث الثاني', 'baby': 'بحجم الأفوكادو', 'icon': '🥑', 'tip': 'اهتمي بالتغذية وتمارين الحمل'},
    24: {'title': 'زيادة الوزن', 'baby': 'بحجم الذرة', 'icon': '🌽', 'tip': 'تناولي الحديد وجهزي حقيبة المستشفى'},
    32: {'title': 'الثلث الأخير', 'baby': 'بحجم جوز الهند', 'icon': '🥥', 'tip': 'راقبي الضغط واستعدي للولادة'},
    40: {'title': 'أي يوم!', 'baby': 'بحجم البطيخة', 'icon': '🍉', 'tip': 'راقبي علامات الولادة'},
  };

  Map<String, String> get _currentTip {
    int key = 8;
    if (_week >= 36) key = 40; else if (_week >= 28) key = 32; else if (_week >= 20) key = 24; else if (_week >= 12) key = 16;
    return _tips[key] ?? _tips[8]!;
  }

  @override
  Widget build(BuildContext context) {
    final daysLeft = _dueDate.difference(DateTime.now()).inDays;
    final tip = _currentTip;
    return Scaffold(
      appBar: AppBar(title: const Text('متابعة الحمل', style: TextStyle(fontWeight: FontWeight.bold))),
      body: SingleChildScrollView(padding: const EdgeInsets.all(14), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.pink.shade300, Colors.purple.shade400]), borderRadius: BorderRadius.circular(16)),
          child: Column(children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              const Text('🤰', style: TextStyle(fontSize: 40)),
              Column(children: [const Text('الأسبوع', style: TextStyle(color: Colors.white70, fontSize: 12)), Text('$_week', style: const TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.bold)), const Text('من 40', style: TextStyle(color: Colors.white70, fontSize: 12))]),
              Column(children: [const Text('متبقي', style: TextStyle(color: Colors.white70, fontSize: 12)), Text('$daysLeft', style: const TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.bold)), const Text('يوم', style: TextStyle(color: Colors.white70, fontSize: 12))]),
            ]),
            const SizedBox(height: 10),
            LinearProgressIndicator(value: _week / 40, backgroundColor: Colors.white24, color: Colors.white, minHeight: 6, borderRadius: BorderRadius.circular(3)),
            Text('الموعد: ${_dueDate.day}/${_dueDate.month}/${_dueDate.year}', style: const TextStyle(color: Colors.white70, fontSize: 11)),
          ]),
        ),
        const SizedBox(height: 14),
        Container(padding: const EdgeInsets.all(14), decoration: BoxDecoration(color: Colors.pink.shade50, borderRadius: BorderRadius.circular(14)), child: Row(children: [Text(tip['icon']!, style: const TextStyle(fontSize: 44)), const SizedBox(width: 10), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(tip['title']!, style: const TextStyle(fontWeight: FontWeight.bold)), Text('طفلك الآن ${tip['baby']}', style: const TextStyle(color: AppColors.darkGrey)), const SizedBox(height: 4), Text('💡 ${tip['tip']}', style: const TextStyle(fontSize: 12))]))])),
      ])),
    );
  }
}
