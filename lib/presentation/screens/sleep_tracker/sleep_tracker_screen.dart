import 'package:flutter/material.dart';
import 'package:sehatak/core/constants/app_colors.dart';

class SleepTrackerScreen extends StatefulWidget {
  const SleepTrackerScreen({super.key});
  @override
  State<SleepTrackerScreen> createState() => _SleepTrackerScreenState();
}

class _SleepTrackerScreenState extends State<SleepTrackerScreen> {
  final List<Map<String, dynamic>> _weekData = const [
    {'day': 'سبت', 'hours': 7.5, 'quality': 'جيد'},
    {'day': 'أحد', 'hours': 6.2, 'quality': 'متوسط'},
    {'day': 'إثنين', 'hours': 8.0, 'quality': 'ممتاز'},
    {'day': 'ثلاثاء', 'hours': 5.5, 'quality': 'سيء'},
    {'day': 'أربعاء', 'hours': 7.0, 'quality': 'جيد'},
    {'day': 'خميس', 'hours': 7.8, 'quality': 'جيد'},
    {'day': 'جمعة', 'hours': 8.2, 'quality': 'ممتاز'},
  ];

  double get _avgSleep => _weekData.fold(0.0, (s, d) => s + (d['hours'] as double)) / _weekData.length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('تتبع النوم')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(14),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(gradient: const LinearGradient(colors: [Color(0xFF1A237E), Color(0xFF3949AB)]), borderRadius: BorderRadius.circular(16)),
            child: Column(children: [
              const Icon(Icons.bedtime, color: Colors.white, size: 48),
              const SizedBox(height: 8),
              const Text('نوم الليلة الماضية', style: TextStyle(color: Colors.white70, fontSize: 14)),
              const SizedBox(height: 4),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                const Text('7.5', style: TextStyle(color: Colors.white, fontSize: 48, fontWeight: FontWeight.bold)),
                const Text(' ساعة', style: TextStyle(color: Colors.white70, fontSize: 18)),
              ]),
              const SizedBox(height: 8),
              Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4), decoration: BoxDecoration(color: AppColors.success.withOpacity(0.3), borderRadius: BorderRadius.circular(12)), child: const Text('😊 نوم جيد', style: TextStyle(color: Colors.white))),
            ]),
          ),
          const SizedBox(height: 16),
          // متوسط الأسبوع
          Row(children: [
            _statCard('متوسط النوم', '${_avgSleep.toStringAsFixed(1)} س', Icons.bed, AppColors.info),
            const SizedBox(width: 10),
            _statCard('أفضل يوم', 'الجمعة', Icons.star, AppColors.amber),
            const SizedBox(width: 10),
            _statCard('هدف النوم', '8 ساعات', Icons.flag, AppColors.success),
          ]),
          const SizedBox(height: 16),
          // رسم بياني مبسط للأسبوع
          Text('هذا الأسبوع', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 6)]),
            height: 180,
            child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: _weekData.map((d) {
              final hours = d['hours'] as double;
              final color = hours >= 8 ? AppColors.success : hours >= 6 ? AppColors.info : AppColors.error;
              return Expanded(
                child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                  Text('${hours.toStringAsFixed(0)}س', style: TextStyle(fontSize: 9, color: color)),
                  const SizedBox(height: 4),
                  Container(width: 30, height: hours * 15, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(6))),
                  const SizedBox(height: 4),
                  Text(d['day'], style: const TextStyle(fontSize: 10, color: AppColors.grey)),
                ]),
              );
            }).toList()),
          ),
          const SizedBox(height: 16),
          // نصائح نوم
          Container(padding: const EdgeInsets.all(14), decoration: BoxDecoration(color: Colors.indigo.shade50, borderRadius: BorderRadius.circular(14)), child: const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('💤 نصائح لنوم أفضل', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            SizedBox(height: 8),
            Text('• نم واستيقظ في نفس الوقت يومياً', style: TextStyle(fontSize: 12)),
            Text('• تجنب الكافيين قبل النوم بـ 6 ساعات', style: TextStyle(fontSize: 12)),
            Text('• اجعل غرفة النوم مظلمة وباردة', style: TextStyle(fontSize: 12)),
            Text('• أبعد الهاتف قبل النوم بنصف ساعة', style: TextStyle(fontSize: 12)),
          ])),
        ]),
      ),
    );
  }

  Widget _statCard(String label, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: color.withOpacity(0.06), borderRadius: BorderRadius.circular(12)), child: Column(children: [Icon(icon, color: color, size: 20), const SizedBox(height: 4), Text(value, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: color)), Text(label, style: const TextStyle(fontSize: 9, color: AppColors.grey))])),
    );
  }
}
