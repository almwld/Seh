import 'package:flutter/material.dart';
import 'package:sehatak/core/constants/app_colors.dart';

class WeightTrackerScreen extends StatefulWidget {
  const WeightTrackerScreen({super.key});
  @override
  State<WeightTrackerScreen> createState() => _WeightTrackerScreenState();
}

class _WeightTrackerScreenState extends State<WeightTrackerScreen> {
  double _currentWeight = 72.5;
  double _targetWeight = 68.0;
  double _height = 175;

  final List<Map<String, dynamic>> _history = const [
    {'date': '1 مايو', 'weight': 72.5},
    {'date': '15 أبريل', 'weight': 73.2},
    {'date': '1 أبريل', 'weight': 74.0},
    {'date': '15 مارس', 'weight': 75.1},
    {'date': '1 مارس', 'weight': 76.5},
    {'date': '15 فبراير', 'weight': 78.0},
  ];

  double get _bmi => _currentWeight / ((_height / 100) * (_height / 100));
  double get _lost => _history.last['weight'] - _currentWeight;
  double get _remaining => _currentWeight - _targetWeight;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('تتبع الوزن')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(14),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(gradient: const LinearGradient(colors: [AppColors.success, AppColors.teal]), borderRadius: BorderRadius.circular(16)),
            child: Column(children: [
              const Text('وزنك الحالي', style: TextStyle(color: Colors.white70, fontSize: 14)),
              const SizedBox(height: 4),
              Text('$_currentWeight', style: const TextStyle(color: Colors.white, fontSize: 48, fontWeight: FontWeight.bold)),
              const Text('كجم', style: TextStyle(color: Colors.white70)),
              const SizedBox(height: 8),
              const Text('🎯 الهدف: 68.0 كجم', style: TextStyle(color: Colors.white70, fontSize: 13)),
            ]),
          ),
          const SizedBox(height: 14),
          Row(children: [
            _statCard('خسرت', '${_lost.toStringAsFixed(1)} كجم', Icons.trending_down, AppColors.success),
            const SizedBox(width: 10),
            _statCard('متبقي', '${_remaining.toStringAsFixed(1)} كجم', Icons.flag, AppColors.warning),
            const SizedBox(width: 10),
            _statCard('BMI', _bmi.toStringAsFixed(1), Icons.monitor_weight, AppColors.info),
          ]),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 6)]),
            height: 180,
            child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: _history.reversed.toList().map((h) {
              final maxWeight = _history.map((x) => x['weight'] as double).reduce((a, b) => a > b ? a : b);
              final minWeight = _history.map((x) => x['weight'] as double).reduce((a, b) => a < b ? a : b);
              final height = ((h['weight'] as double) - minWeight) / (maxWeight - minWeight) * 100;
              return Expanded(
                child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                  Text('${h['weight']}', style: const TextStyle(fontSize: 9)),
                  const SizedBox(height: 4),
                  Container(width: 30, height: height + 20, decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(6))),
                  const SizedBox(height: 4),
                  Text(h['date'].toString().substring(0, 6), style: const TextStyle(fontSize: 8, color: AppColors.grey)),
                ]),
              );
            }).toList()),
          ),
          const SizedBox(height: 16),
          Container(padding: const EdgeInsets.all(14), decoration: BoxDecoration(color: AppColors.success.withOpacity(0.05), borderRadius: BorderRadius.circular(14)), child: const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('💡 نصائح لإدارة الوزن', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            SizedBox(height: 8),
            Text('• تناول وجبات صغيرة متكررة', style: TextStyle(fontSize: 12)),
            Text('• اشرب الماء قبل الوجبات', style: TextStyle(fontSize: 12)),
            Text('• مارس الرياضة 30 دقيقة يومياً', style: TextStyle(fontSize: 12)),
            Text('• قِس وزنك أسبوعياً في نفس الوقت', style: TextStyle(fontSize: 12)),
          ])),
        ]),
      ),
    );
  }

  Widget _statCard(String label, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: color.withOpacity(0.06), borderRadius: BorderRadius.circular(12)), child: Column(children: [Icon(icon, color: color, size: 20), const SizedBox(height: 4), Text(value, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: color)), Text(label, style: const TextStyle(fontSize: 10, color: AppColors.grey))])),
    );
  }
}
