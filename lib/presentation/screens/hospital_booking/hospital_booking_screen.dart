import 'package:flutter/material.dart';
import 'package:sehatak/core/constants/app_colors.dart';

class HospitalBookingScreen extends StatelessWidget {
  const HospitalBookingScreen({super.key});

  final List<Map<String, dynamic>> _specialties = const [
    {'name': 'باطنية', 'icon': '🩺', 'doctors': 45, 'waitTime': '10-15 دقيقة'},
    {'name': 'قلب', 'icon': '❤️', 'doctors': 32, 'waitTime': '20-30 دقيقة'},
    {'name': 'عظام', 'icon': '🦴', 'doctors': 28, 'waitTime': '15-20 دقيقة'},
    {'name': 'أطفال', 'icon': '👶', 'doctors': 38, 'waitTime': '10-15 دقيقة'},
    {'name': 'نساء وولادة', 'icon': '🤰', 'doctors': 25, 'waitTime': '25-35 دقيقة'},
    {'name': 'عيون', 'icon': '👁️', 'doctors': 22, 'waitTime': '15-20 دقيقة'},
    {'name': 'أنف وأذن', 'icon': '👂', 'doctors': 18, 'waitTime': '10-15 دقيقة'},
    {'name': 'جلدية', 'icon': '🤚', 'doctors': 20, 'waitTime': '20-25 دقيقة'},
    {'name': 'أسنان', 'icon': '🦷', 'doctors': 35, 'waitTime': '10-15 دقيقة'},
    {'name': 'نفسية وعصبية', 'icon': '🧠', 'doctors': 15, 'waitTime': '30-40 دقيقة'},
    {'name': 'مسالك بولية', 'icon': '🔬', 'doctors': 12, 'waitTime': '20-25 دقيقة'},
    {'name': 'جراحة عامة', 'icon': '🏥', 'doctors': 30, 'waitTime': '15-20 دقيقة'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('حجز موعد مستشفى')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(14),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // بطاقة الحجز السريع
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(gradient: const LinearGradient(colors: [AppColors.primary, AppColors.primaryDark]), borderRadius: BorderRadius.circular(16)),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text('حجز سريع', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Row(children: [
                Expanded(child: _quickBookField('التخصص', Icons.medical_services)),
                const SizedBox(width: 8),
                Expanded(child: _quickBookField('المدينة', Icons.location_city)),
              ]),
              const SizedBox(height: 8),
              Row(children: [
                Expanded(child: _quickBookField('التاريخ', Icons.calendar_today)),
                const SizedBox(width: 8),
                Expanded(child: _quickBookField('الوقت', Icons.access_time)),
              ]),
              const SizedBox(height: 12),
              SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: AppColors.primary), child: const Text('بحث عن موعد'))),
            ]),
          ),
          const SizedBox(height: 20),
          // التخصصات
          Text('اختر التخصص', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          GridView.count(
            crossAxisCount: 3, shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 10, mainAxisSpacing: 10, childAspectRatio: 0.85,
            children: _specialties.map((s) => Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 6)]),
              child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(s['icon'], style: const TextStyle(fontSize: 32)),
                const SizedBox(height: 6),
                Text(s['name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                Text('${s['doctors']} طبيب', style: const TextStyle(fontSize: 9, color: AppColors.grey)),
                Container(margin: const EdgeInsets.only(top: 4), padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: AppColors.success.withOpacity(0.1), borderRadius: BorderRadius.circular(4)), child: Text(s['waitTime'], style: const TextStyle(fontSize: 8, color: AppColors.success))),
              ]),
            )).toList(),
          ),
        ]),
      ),
    );
  }

  Widget _quickBookField(String hint, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(8)),
      child: Row(children: [Icon(icon, color: Colors.white70, size: 16), const SizedBox(width: 6), Expanded(child: TextField(decoration: InputDecoration(hintText: hint, hintStyle: const TextStyle(color: Colors.white60, fontSize: 11), border: InputBorder.none), style: const TextStyle(color: Colors.white, fontSize: 11)))],),
    );
  }
}
