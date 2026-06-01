import 'package:flutter/material.dart';
import 'package:sehatak/core/constants/app_colors.dart';

class PhysiotherapyScreen extends StatefulWidget {
  const PhysiotherapyScreen({super.key});
  @override
  State<PhysiotherapyScreen> createState() => _PhysiotherapyScreenState();
}

class _PhysiotherapyScreenState extends State<PhysiotherapyScreen> {
  final List<Map<String, dynamic>> _services = [
    {'name': 'علاج آلام الظهر', 'price': '250', 'sessions': '6 جلسات', 'icon': '🦴', 'desc': 'تمارين متخصصة لتقوية عضلات الظهر', 'color': AppColors.warning},
    {'name': 'علاج آلام الرقبة', 'price': '200', 'sessions': '5 جلسات', 'icon': '🧍', 'desc': 'تخفيف آلام الرقبة والكتف', 'color': AppColors.info},
    {'name': 'علاج خشونة الركبة', 'price': '300', 'sessions': '8 جلسات', 'icon': '🦵', 'desc': 'تقوية عضلات الركبة وتحسين الحركة', 'color': AppColors.error},
    {'name': 'تأهيل إصابات رياضية', 'price': '350', 'sessions': '10 جلسات', 'icon': '⚽', 'desc': 'برنامج تأهيلي مخصص للرياضيين', 'color': AppColors.success},
    {'name': 'علاج الشلل النصفي', 'price': '400', 'sessions': '12 جلسة', 'icon': '🧠', 'desc': 'تأهيل حركي بعد الجلطات', 'color': AppColors.purple},
    {'name': 'تدليك استرخائي', 'price': '150', 'sessions': 'جلسة واحدة', 'icon': '💆', 'desc': 'تدليك عضلي لتخفيف التوتر', 'color': AppColors.teal},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('العلاج الطبيعي', style: TextStyle(fontWeight: FontWeight.bold))),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(14),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(gradient: const LinearGradient(colors: [AppColors.primary, AppColors.primaryDark]), borderRadius: BorderRadius.circular(16)),
            child: const Column(children: [Icon(Icons.accessibility_new, color: Colors.white, size: 48), SizedBox(height: 8), Text('علاج طبيعي في منزلك', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)), Text('جلسات مخصصة مع أفضل الأخصائيين', style: TextStyle(color: Colors.white70, fontSize: 12))]),
          ),
          const SizedBox(height: 16),
          ..._services.map((s) => Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 6)]),
            child: Row(children: [
              Container(width: 50, height: 50, decoration: BoxDecoration(color: (s['color'] as Color).withOpacity(0.08), borderRadius: BorderRadius.circular(12)), child: Center(child: Text(s['icon'], style: const TextStyle(fontSize: 28)))),
              const SizedBox(width: 12),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(s['name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)), Text(s['desc'], style: const TextStyle(fontSize: 10, color: AppColors.grey))])),
              Column(crossAxisAlignment: CrossAxisAlignment.end, children: [Text('${s['price']} ر.س', style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary)), Text(s['sessions'], style: const TextStyle(fontSize: 9, color: AppColors.grey)), const SizedBox(height: 6), ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5), minimumSize: Size.zero), child: const Text('احجز', style: TextStyle(fontSize: 10)))]),
            ]),
          )),
        ]),
      ),
    );
  }
}
