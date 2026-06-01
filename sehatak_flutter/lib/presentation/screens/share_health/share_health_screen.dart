import 'package:flutter/material.dart';
import 'package:sehatak/core/constants/app_colors.dart';

class ShareHealthScreen extends StatelessWidget {
  const ShareHealthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('مشاركة الملف الصحي', style: TextStyle(fontWeight: FontWeight.bold))),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(14),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: AppColors.info.withOpacity(0.05), borderRadius: BorderRadius.circular(14), border: Border.all(color: AppColors.info.withOpacity(0.2))),
            child: const Row(children: [Icon(Icons.security, color: AppColors.info, size: 28), SizedBox(width: 10), Expanded(child: Text('مشاركة آمنة ومشفرة لبياناتك الصحية مع طبيبك أو المستشفى', style: TextStyle(fontSize: 12)))],),
          ),
          const SizedBox(height: 16),
          Text('اختر ما تريد مشاركته', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          _shareOption('السجل الطبي الكامل', 'أمراض، حساسية، تطعيمات', Icons.folder_shared, AppColors.primary, true),
          _shareOption('التحاليل والفحوصات', 'نتائج تحاليل وأشعة', Icons.science, AppColors.info, true),
          _shareOption('الوصفات الطبية', 'وصفات حالية وسابقة', Icons.receipt_long, AppColors.success, false),
          _shareOption('التقارير الطبية', 'تقارير PDF', Icons.description, AppColors.purple, true),
          const SizedBox(height: 16),
          // إدخال الطبيب
          Text('أرسل إلى', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          TextField(
            textAlign: TextAlign.right,
            decoration: InputDecoration(
              hintText: 'بريد الطبيب الإلكتروني',
              prefixIcon: const Icon(Icons.email),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              filled: true,
              fillColor: AppColors.surfaceContainerLow.withOpacity(0.3),
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            textAlign: TextAlign.right,
            maxLines: 3,
            decoration: InputDecoration(
              hintText: 'رسالة للطبيب (اختياري)',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              filled: true,
              fillColor: AppColors.surfaceContainerLow.withOpacity(0.3),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(width: double.infinity, child: ElevatedButton.icon(onPressed: () {}, icon: const Icon(Icons.send), label: const Text('مشاركة'), style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, padding: const EdgeInsets.symmetric(vertical: 14)))),
        ]),
      ),
    );
  }

  Widget _shareOption(String title, String subtitle, IconData icon, Color color, bool selected) {
    return Card(
      margin: const EdgeInsets.only(bottom: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: SwitchListTile(
        secondary: Icon(icon, color: color),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13)),
        subtitle: Text(subtitle, style: const TextStyle(fontSize: 10, color: AppColors.grey)),
        value: selected,
        activeColor: AppColors.primary,
        onChanged: (_) {},
      ),
    );
  }
}
