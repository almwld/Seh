import 'package:flutter/material.dart';
import 'package:sehatak/core/constants/app_colors.dart';

class HomeLabScreen extends StatefulWidget {
  const HomeLabScreen({super.key});
  @override
  State<HomeLabScreen> createState() => _HomeLabScreenState();
}

class _HomeLabScreenState extends State<HomeLabScreen> {
  final List<Map<String, dynamic>> _tests = const [
    {'name': 'تحليل CBC', 'price': '150', 'duration': 'نتيجة خلال 4 ساعات', 'preparation': 'لا يحتاج صيام', 'icon': '🩸', 'color': AppColors.error},
    {'name': 'سكر صائم', 'price': '80', 'duration': 'نتيجة خلال 2 ساعة', 'preparation': 'صيام 8 ساعات', 'icon': '💉', 'color': AppColors.info},
    {'name': 'دهون ثلاثية', 'price': '200', 'duration': 'نتيجة خلال 6 ساعات', 'preparation': 'صيام 12 ساعة', 'icon': '🧪', 'color': AppColors.warning},
    {'name': 'فيتامين د', 'price': '250', 'duration': 'نتيجة خلال 24 ساعة', 'preparation': 'لا يحتاج صيام', 'icon': '☀️', 'color': AppColors.amber},
    {'name': 'وظائف كبد', 'price': '180', 'duration': 'نتيجة خلال 6 ساعات', 'preparation': 'صيام 8 ساعات', 'icon': '🔬', 'color': AppColors.success},
    {'name': 'هرمونات الغدة', 'price': '350', 'duration': 'نتيجة خلال 48 ساعة', 'preparation': 'صيام 8 ساعات', 'icon': '🧬', 'color': AppColors.purple},
    {'name': 'تحليل بول', 'price': '60', 'duration': 'نتيجة خلال ساعة', 'preparation': 'عينة صباحية', 'icon': '🧫', 'color': AppColors.teal},
    {'name': 'فيروسات كبد', 'price': '400', 'duration': 'نتيجة خلال 48 ساعة', 'preparation': 'لا يحتاج صيام', 'icon': '🦠', 'color': AppColors.primary},
  ];

  final Set<String> _selected = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('فحص منزلي', style: TextStyle(fontWeight: FontWeight.bold))),
      body: Column(children: [
        Container(
          margin: const EdgeInsets.all(14),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(gradient: const LinearGradient(colors: [AppColors.primary, AppColors.primaryDark]), borderRadius: BorderRadius.circular(16)),
          child: Row(children: [const Icon(Icons.home_work, color: Colors.white, size: 32), const SizedBox(width: 10), const Expanded(child: Text('فحوصات في منزلك', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)))]),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            itemCount: _tests.length,
            itemBuilder: (context, idx) {
              final t = _tests[idx];
              return Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 6)]),
                child: Row(children: [
                  Container(width: 44, height: 44, decoration: BoxDecoration(color: (t['color'] as Color).withOpacity(0.08), borderRadius: BorderRadius.circular(10)), child: Center(child: Text(t['icon'], style: const TextStyle(fontSize: 22)))),
                  const SizedBox(width: 10),
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(t['name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                    Text(t['duration'], style: const TextStyle(fontSize: 10, color: AppColors.grey)),
                    Text(t['preparation'], style: const TextStyle(fontSize: 9, color: AppColors.warning)),
                  ])),
                  Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                    Text('${t['price']} ر.س', style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary)),
                    Checkbox(value: _selected.contains(t['name']), activeColor: AppColors.primary, onChanged: (v) => setState(() { if (v!) { _selected.add(t['name']); } else { _selected.remove(t['name']); } })),
                  ]),
                ]),
              );
            },
          ),
        ),
        if (_selected.isNotEmpty)
          Container(
            padding: const EdgeInsets.all(14),
            color: Colors.white,
            child: Row(children: [
              Text('${_selected.length} فحوصات', style: const TextStyle(fontWeight: FontWeight.bold)),
              const Spacer(),
              ElevatedButton.icon(onPressed: () {}, icon: const Icon(Icons.send), label: const Text('طلب الفحص'), style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary)),
            ]),
          ),
      ]),
    );
  }
}
