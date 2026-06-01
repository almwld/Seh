import 'package:flutter/material.dart';
import 'package:sehatak/core/constants/app_colors.dart';

class GeneticCounselingScreen extends StatelessWidget {
  const GeneticCounselingScreen({super.key});

  final List<Map<String, String>> _services = const [
    {'name': 'فحص ما قبل الزواج', 'desc': 'فحص شامل للأمراض الوراثية', 'price': '500', 'icon': '💑'},
    {'name': 'فحص الأجنة', 'desc': 'فحص وراثي للأجنة قبل الزرع', 'price': '3000', 'icon': '🔬'},
    {'name': 'فحص حديثي الولادة', 'desc': 'كشف مبكر عن 50 مرضاً وراثياً', 'price': '400', 'icon': '👶'},
    {'name': 'استشارة وراثية', 'desc': 'جلسة مع أخصائي الوراثة', 'price': '350', 'icon': '👨‍⚕️'},
    {'name': 'فحص DNA', 'desc': 'تحليل البصمة الوراثية', 'price': '1200', 'icon': '🧬'},
    {'name': 'فحص السرطان الوراثي', 'desc': 'كشف الجينات المسببة للسرطان', 'price': '2500', 'icon': '🎗️'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('الاستشارات الوراثية', style: TextStyle(fontWeight: FontWeight.bold))),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(14),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.indigo.shade400, Colors.indigo.shade700]), borderRadius: BorderRadius.circular(16)),
            child: const Column(children: [Text('🧬', style: TextStyle(fontSize: 48)), SizedBox(height: 8), Text('الاستشارات الوراثية', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)), Text('فحوصات متقدمة للكشف عن الأمراض الوراثية', style: TextStyle(color: Colors.white70, fontSize: 12))]),
          ),
          const SizedBox(height: 16),
          ..._services.map((s) => Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 6)]),
            child: Row(children: [
              Text(s['icon']!, style: const TextStyle(fontSize: 36)),
              const SizedBox(width: 12),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(s['name']!, style: const TextStyle(fontWeight: FontWeight.bold)), Text(s['desc']!, style: const TextStyle(fontSize: 10, color: AppColors.grey))])),
              Column(children: [Text('${s['price']} ر.س', style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary)), const SizedBox(height: 6), ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: AppColors.indigo, padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5), minimumSize: Size.zero), child: const Text('احجز', style: TextStyle(fontSize: 10)))]),
            ]),
          )),
        ]),
      ),
    );
  }
}
