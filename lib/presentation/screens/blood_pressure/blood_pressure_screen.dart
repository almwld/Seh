import 'package:flutter/material.dart';
import 'package:sehatak/core/constants/app_colors.dart';

class BloodPressureScreen extends StatefulWidget {
  const BloodPressureScreen({super.key});
  @override
  State<BloodPressureScreen> createState() => _BloodPressureScreenState();
}

class _BloodPressureScreenState extends State<BloodPressureScreen> {
  final List<Map<String, dynamic>> _readings = const [
    {'date': '1 مايو', 'systolic': 128, 'diastolic': 82, 'pulse': 72, 'time': 'صباحاً', 'status': 'طبيعي'},
    {'date': '28 أبريل', 'systolic': 135, 'diastolic': 88, 'pulse': 75, 'time': 'مساءً', 'status': 'مرتفع'},
    {'date': '25 أبريل', 'systolic': 122, 'diastolic': 80, 'pulse': 70, 'time': 'صباحاً', 'status': 'مثالي'},
    {'date': '20 أبريل', 'systolic': 145, 'diastolic': 92, 'pulse': 78, 'time': 'مساءً', 'status': 'عالي'},
    {'date': '15 أبريل', 'systolic': 118, 'diastolic': 76, 'pulse': 68, 'time': 'صباحاً', 'status': 'مثالي'},
    {'date': '10 أبريل', 'systolic': 132, 'diastolic': 85, 'pulse': 74, 'time': 'مساءً', 'status': 'مرتفع'},
  ];

  String _getStatusText(int systolic, int diastolic) {
    if (systolic < 120 && diastolic < 80) return 'مثالي';
    if (systolic < 130 && diastolic < 85) return 'طبيعي';
    if (systolic < 140 && diastolic < 90) return 'مرتفع';
    return 'عالي';
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'مثالي': return AppColors.success;
      case 'طبيعي': return AppColors.info;
      case 'مرتفع': return AppColors.warning;
      case 'عالي': return AppColors.error;
      default: return AppColors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ضغط الدم')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(14),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(gradient: const LinearGradient(colors: [AppColors.primary, AppColors.primaryDark]), borderRadius: BorderRadius.circular(16)),
            child: Column(children: [
              const Text('آخر قراءة', style: TextStyle(color: Colors.white70, fontSize: 14)),
              const SizedBox(height: 8),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Column(children: [const Text('الانقباضي', style: TextStyle(color: Colors.white70, fontSize: 11)), const SizedBox(height: 4), Text('${_readings.first['systolic']}', style: const TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.bold))]),
                const Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: Text('/', style: TextStyle(color: Colors.white38, fontSize: 36))),
                Column(children: [const Text('الانبساطي', style: TextStyle(color: Colors.white70, fontSize: 11)), const SizedBox(height: 4), Text('${_readings.first['diastolic']}', style: const TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.bold))]),
              ]),
              const SizedBox(height: 8),
              Text('نبض: ${_readings.first['pulse']} bpm', style: const TextStyle(color: Colors.white70, fontSize: 13)),
              const SizedBox(height: 6),
              Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4), decoration: BoxDecoration(color: _getStatusColor(_readings.first['status']).withOpacity(0.3), borderRadius: BorderRadius.circular(8)), child: Text(_readings.first['status'], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
            ]),
          ),
          const SizedBox(height: 16),
          // تصنيفات
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 6)]),
            child: const Column(children: [
              Text('تصنيفات ضغط الدم', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              SizedBox(height: 10),
              _CategoryRow('مثالي', '< 120 / < 80', AppColors.success),
              _CategoryRow('طبيعي', '120-129 / 80-84', AppColors.info),
              _CategoryRow('مرتفع', '130-139 / 85-89', AppColors.warning),
              _CategoryRow('عالي', '≥ 140 / ≥ 90', AppColors.error),
            ]),
          ),
          const SizedBox(height: 16),
          Text('سجل القراءات', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          ..._readings.map((r) => Container(
            margin: const EdgeInsets.only(bottom: 6),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 4)]),
            child: Row(children: [
              Container(width: 4, height: 40, decoration: BoxDecoration(color: _getStatusColor(r['status']), borderRadius: BorderRadius.circular(2))),
              const SizedBox(width: 10),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('${r['date']} • ${r['time']}', style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13)), Text('نبض: ${r['pulse']} bpm', style: const TextStyle(fontSize: 10, color: AppColors.grey))])),
              Text('${r['systolic']}/${r['diastolic']}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              const SizedBox(width: 8),
              Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3), decoration: BoxDecoration(color: _getStatusColor(r['status']).withOpacity(0.1), borderRadius: BorderRadius.circular(6)), child: Text(r['status'], style: TextStyle(fontSize: 10, color: _getStatusColor(r['status']), fontWeight: FontWeight.bold))),
            ]),
          )),
        ]),
      ),
      floatingActionButton: FloatingActionButton.extended(onPressed: () {}, backgroundColor: AppColors.primary, icon: const Icon(Icons.add), label: const Text('إضافة قراءة')),
    );
  }
}

class _CategoryRow extends StatelessWidget {
  final String label, range;
  final Color color;
  const _CategoryRow(this.label, this.range, this.color);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(children: [
        Container(width: 12, height: 12, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 8),
        Text(label, style: const TextStyle(fontSize: 12)),
        const Spacer(),
        Text(range, style: const TextStyle(fontSize: 11, color: AppColors.grey)),
      ]),
    );
  }
}
