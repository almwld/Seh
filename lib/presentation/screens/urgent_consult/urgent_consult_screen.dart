import 'package:flutter/material.dart';
import 'package:sehatak/core/constants/app_colors.dart';

class UrgentConsultScreen extends StatefulWidget {
  const UrgentConsultScreen({super.key});
  @override
  State<UrgentConsultScreen> createState() => _UrgentConsultScreenState();
}

class _UrgentConsultScreenState extends State<UrgentConsultScreen> {
  String _selectedUrgency = 'متوسط';
  bool _sendPhotos = false;
  bool _shareLocation = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('استشارة طارئة', style: TextStyle(fontWeight: FontWeight.bold)), backgroundColor: AppColors.error, foregroundColor: Colors.white),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(14),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: AppColors.error.withOpacity(0.05), borderRadius: BorderRadius.circular(14), border: Border.all(color: AppColors.error.withOpacity(0.2))),
            child: const Row(children: [Icon(Icons.warning_amber, color: AppColors.error, size: 28), SizedBox(width: 10), Expanded(child: Text('لحالات الطوارئ، اتصل على 1122 فوراً', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)))],),
          ),
          const SizedBox(height: 14),
          // درجة الاستعجال
          Text('درجة الاستعجال', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Row(children: [
            _urgencyOption('منخفض', 'خلال 24 ساعة', Colors.green),
            _urgencyOption('متوسط', 'خلال ساعتين', Colors.orange),
            _urgencyOption('عاجل', 'خلال 30 دقيقة', AppColors.error),
          ]),
          const SizedBox(height: 16),
          // وصف الحالة
          Text('وصف الحالة', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          TextField(maxLines: 4, textAlign: TextAlign.right, decoration: InputDecoration(hintText: 'صف الأعراض التي تعاني منها...', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)), filled: true, fillColor: AppColors.surfaceContainerLow.withOpacity(0.3))),
          const SizedBox(height: 12),
          // خيارات إضافية
          SwitchListTile(title: const Text('إرسال صور'), subtitle: const Text('صور للمنطقة المصابة'), value: _sendPhotos, activeColor: AppColors.primary, onChanged: (v) => setState(() => _sendPhotos = v)),
          SwitchListTile(title: const Text('مشاركة موقعي'), subtitle: const Text('لتحديد أقرب مستشفى'), value: _shareLocation, activeColor: AppColors.primary, onChanged: (v) => setState(() => _shareLocation = v)),
          const SizedBox(height: 16),
          SizedBox(width: double.infinity, child: ElevatedButton.icon(onPressed: () {}, icon: const Icon(Icons.send), label: const Text('إرسال الاستشارة'), style: ElevatedButton.styleFrom(backgroundColor: AppColors.error, padding: const EdgeInsets.symmetric(vertical: 14)))),
        ]),
      ),
    );
  }

  Widget _urgencyOption(String label, String time, Color color) {
    final selected = _selectedUrgency == label;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedUrgency = label),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 3),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(color: selected ? color.withOpacity(0.1) : Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: selected ? color : AppColors.outlineVariant, width: selected ? 2 : 1)),
          child: Column(children: [Text(label, style: TextStyle(fontWeight: FontWeight.bold, color: selected ? color : AppColors.darkGrey)), const SizedBox(height: 2), Text(time, style: TextStyle(fontSize: 9, color: selected ? color : AppColors.grey))]),
        ),
      ),
    );
  }
}
