import 'package:flutter/material.dart';
import 'package:sehatak/core/constants/app_colors.dart';

class DueDateCalculatorScreen extends StatefulWidget {
  const DueDateCalculatorScreen({super.key});
  @override
  State<DueDateCalculatorScreen> createState() => _DueDateCalculatorScreenState();
}

class _DueDateCalculatorScreenState extends State<DueDateCalculatorScreen> {
  DateTime? _lastPeriod;
  DateTime? _dueDate;
  int _weeks = 0;
  int _days = 0;
  String _trimester = '';

  void _calculate() {
    if (_lastPeriod == null) return;
    _dueDate = _lastPeriod!.add(const Duration(days: 280));
    final diff = DateTime.now().difference(_lastPeriod!);
    _weeks = diff.inDays ~/ 7;
    _days = diff.inDays % 7;
    _trimester = _weeks < 13 ? 'الثلث الأول' : _weeks < 27 ? 'الثلث الثاني' : 'الثلث الثالث';
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('حاسبة موعد الولادة')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.pink.shade300, Colors.purple.shade400]), borderRadius: BorderRadius.circular(16)),
            child: Column(children: [const Icon(Icons.cake, color: Colors.white, size: 40), const SizedBox(height: 8), const Text('حاسبة موعد الولادة', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)), const Text('أدخلي تاريخ آخر دورة شهرية', style: TextStyle(color: Colors.white70, fontSize: 12))]),
          ),
          const SizedBox(height: 18),
          ListTile(
            title: const Text('تاريخ آخر دورة'),
            subtitle: Text(_lastPeriod != null ? '${_lastPeriod!.day}/${_lastPeriod!.month}/${_lastPeriod!.year}' : 'اضغطي للاختيار'),
            leading: const Icon(Icons.calendar_today, color: AppColors.primary),
            onTap: () async {
              final picked = await showDatePicker(context: context, initialDate: DateTime.now().subtract(const Duration(days: 30)), firstDate: DateTime(2025), lastDate: DateTime.now());
              if (picked != null) { _lastPeriod = picked; _calculate(); }
            },
          ),
          if (_dueDate != null) ...[
            const SizedBox(height: 18),
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.05), borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.primary.withOpacity(0.2))),
              child: Column(children: [
                const Text('🎉 الموعد المتوقع', style: TextStyle(color: AppColors.grey, fontSize: 14)),
                const SizedBox(height: 6),
                Text('${_dueDate!.day}/${_dueDate!.month}/${_dueDate!.year}', style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: AppColors.primary)),
              ]),
            ),
            const SizedBox(height: 14),
            Row(children: [
              _infoCard('عمر الحمل', '$_weeks أسبوع و $_days يوم', Icons.pregnant_woman, Colors.pink),
              const SizedBox(width: 8),
              _infoCard('الثلث', _trimester, Icons.baby_changing_station, AppColors.purple),
              const SizedBox(width: 8),
              _infoCard('متبقي', '${_dueDate!.difference(DateTime.now()).inDays} يوم', Icons.hourglass_bottom, AppColors.info),
            ]),
          ],
        ]),
      ),
    );
  }

  Widget _infoCard(String label, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: color.withOpacity(0.06), borderRadius: BorderRadius.circular(12)), child: Column(children: [Icon(icon, color: color, size: 22), const SizedBox(height: 4), Text(value, textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: color)), Text(label, style: const TextStyle(fontSize: 9, color: AppColors.grey))])),
    );
  }
}
