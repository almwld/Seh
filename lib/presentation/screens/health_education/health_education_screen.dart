import 'package:flutter/material.dart';
import 'package:sehatak/core/constants/app_colors.dart';

class HealthEducationScreen extends StatelessWidget {
  const HealthEducationScreen({super.key});

  final List<Map<String, dynamic>> _videos = const [
    {'title': 'كيفية قياس ضغط الدم', 'doctor': 'د. علي المولد', 'duration': '5:30', 'views': '12K', 'icon': '🫀', 'color': AppColors.error, 'category': 'قلب'},
    {'title': 'تمارين للظهر', 'doctor': 'د. كمال أحمد', 'duration': '8:15', 'views': '8.5K', 'icon': '🦴', 'color': AppColors.warning, 'category': 'عظام'},
    {'title': 'العناية ببشرة الطفل', 'doctor': 'د. فاطمة صديقي', 'duration': '6:45', 'views': '15K', 'icon': '👶', 'color': AppColors.pink, 'category': 'أطفال'},
    {'title': 'أعراض السكري', 'doctor': 'د. حسن رضا', 'duration': '10:20', 'views': '20K', 'icon': '💉', 'color': AppColors.info, 'category': 'سكري'},
    {'title': 'التغذية الصحية', 'doctor': 'د. عائشة ملك', 'duration': '7:00', 'views': '18K', 'icon': '🥗', 'color': AppColors.success, 'category': 'تغذية'},
    {'title': 'الإسعافات الأولية', 'doctor': 'د. عمران شيخ', 'duration': '12:30', 'views': '25K', 'icon': '🚑', 'color': AppColors.primary, 'category': 'طوارئ'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('تثقيف صحي', style: TextStyle(fontWeight: FontWeight.bold)), actions: [IconButton(icon: const Icon(Icons.search), onPressed: () {})]),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(14),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(gradient: const LinearGradient(colors: [AppColors.info, AppColors.primary]), borderRadius: BorderRadius.circular(16)),
            child: Row(children: [const Icon(Icons.play_circle, color: Colors.white, size: 48), const SizedBox(width: 12), const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('تثقيف صحي', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)), Text('فيديوهات تعليمية من أطبائنا', style: TextStyle(color: Colors.white70, fontSize: 12))]))]),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 40,
            child: ListView(scrollDirection: Axis.horizontal, children: ['الكل', 'قلب', 'عظام', 'أطفال', 'سكري', 'تغذية', 'طوارئ'].map((c) => Padding(padding: const EdgeInsets.only(right: 6), child: ChoiceChip(label: Text(c, style: const TextStyle(fontSize: 11)), selected: c == 'الكل', selectedColor: AppColors.primary, labelStyle: const TextStyle(color: Colors.white), onSelected: (_) {}))).toList()),
          ),
          const SizedBox(height: 12),
          ..._videos.map((v) => Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 6)]),
            child: Row(children: [
              Container(width: 80, height: 60, decoration: BoxDecoration(color: (v['color'] as Color).withOpacity(0.1), borderRadius: BorderRadius.circular(10)), child: Center(child: Text(v['icon'], style: const TextStyle(fontSize: 30)))),
              const SizedBox(width: 12),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(v['title'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                Text(v['doctor'], style: const TextStyle(fontSize: 10, color: AppColors.grey)),
                Row(children: [const Icon(Icons.play_circle_fill, size: 12, color: AppColors.primary), const SizedBox(width: 4), Text(v['duration'], style: const TextStyle(fontSize: 10, color: AppColors.primary)), const SizedBox(width: 12), const Icon(Icons.visibility, size: 12, color: AppColors.grey), const SizedBox(width: 4), Text(v['views'], style: const TextStyle(fontSize: 10, color: AppColors.grey))])],
              )),
              const Icon(Icons.bookmark_border, color: AppColors.grey),
            ]),
          )),
        ]),
      ),
    );
  }
}
