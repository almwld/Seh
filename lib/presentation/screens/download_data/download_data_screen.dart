import 'package:flutter/material.dart';
import 'package:sehatak/core/constants/app_colors.dart';

class DownloadDataScreen extends StatefulWidget {
  const DownloadDataScreen({super.key});
  @override
  State<DownloadDataScreen> createState() => _DownloadDataScreenState();
}

class _DownloadDataScreenState extends State<DownloadDataScreen> {
  bool _medicalHistory = true;
  bool _prescriptions = true;
  bool _labResults = true;
  bool _appointments = true;
  bool _profileData = true;
  String _format = 'PDF';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('تحميل بياناتي', style: TextStyle(fontWeight: FontWeight.bold))),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(14),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(gradient: const LinearGradient(colors: [AppColors.info, AppColors.primary]), borderRadius: BorderRadius.circular(16)),
            child: const Column(children: [Icon(Icons.download, color: Colors.white, size: 40), SizedBox(height: 8), Text('تصدير بياناتك', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)), Text('حمّل نسخة من جميع بياناتك الصحية', style: TextStyle(color: Colors.white70, fontSize: 12))]),
          ),
          const SizedBox(height: 16),
          
          Text('اختر البيانات المراد تحميلها', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          _dataOption('التاريخ الطبي', 'أمراض، حساسية، تطعيمات', Icons.folder_shared, _medicalHistory, (v) => setState(() => _medicalHistory = v)),
          _dataOption('الوصفات الطبية', 'وصفات حالية وسابقة', Icons.receipt_long, _prescriptions, (v) => setState(() => _prescriptions = v)),
          _dataOption('نتائج التحاليل', 'تحاليل دم وأشعة', Icons.science, _labResults, (v) => setState(() => _labResults = v)),
          _dataOption('المواعيد', 'مواعيد قادمة وسابقة', Icons.calendar_today, _appointments, (v) => setState(() => _appointments = v)),
          _dataOption('الملف الشخصي', 'الاسم، البريد، الهاتف', Icons.person, _profileData, (v) => setState(() => _profileData = v)),
          const SizedBox(height: 16),

          // الصيغة
          Text('صيغة الملف', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Row(children: [
            _formatChip('PDF', Icons.picture_as_pdf),
            _formatChip('JSON', Icons.code),
            _formatChip('CSV', Icons.table_chart),
          ]),
          const SizedBox(height: 20),

          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(color: AppColors.info.withOpacity(0.05), borderRadius: BorderRadius.circular(12)),
            child: Row(children: [const Icon(Icons.info, color: AppColors.info), const SizedBox(width: 8), const Expanded(child: Text('سيتم إرسال الملف إلى بريدك الإلكتروني خلال 24 ساعة', style: TextStyle(fontSize: 11, color: AppColors.darkGrey)))]),
          ),
          const SizedBox(height: 16),
          SizedBox(width: double.infinity, child: ElevatedButton.icon(onPressed: () { ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('تم طلب تحميل البيانات. ستصل إلى بريدك الإلكتروني.'), backgroundColor: AppColors.success)); }, icon: const Icon(Icons.download), label: const Text('طلب تحميل البيانات'), style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, padding: const EdgeInsets.symmetric(vertical: 14)))),
        ]),
      ),
    );
  }

  Widget _dataOption(String title, String subtitle, IconData icon, bool value, Function(bool) onChange) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 4)]),
      child: CheckboxListTile(value: value, activeColor: AppColors.primary, onChanged: (v) => onChange(v!), title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)), subtitle: Text(subtitle, style: const TextStyle(fontSize: 10, color: AppColors.grey)), secondary: Icon(icon, color: AppColors.primary)),
    );
  }

  Widget _formatChip(String label, IconData icon) {
    final selected = _format == label;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _format = label),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(color: selected ? AppColors.primary : Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: selected ? AppColors.primary : AppColors.outlineVariant)),
          child: Column(children: [Icon(icon, color: selected ? Colors.white : AppColors.grey, size: 28), const SizedBox(height: 4), Text(label, style: TextStyle(color: selected ? Colors.white : AppColors.darkGrey, fontWeight: FontWeight.bold))]),
        ),
      ),
    );
  }
}
