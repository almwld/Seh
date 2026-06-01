import 'package:flutter/material.dart';
import 'package:sehatak/core/constants/app_colors.dart';

class ReportIssueScreen extends StatefulWidget {
  const ReportIssueScreen({super.key});
  @override
  State<ReportIssueScreen> createState() => _ReportIssueScreenState();
}

class _ReportIssueScreenState extends State<ReportIssueScreen> {
  String _issueType = 'مشكلة تقنية';
  String _priority = 'متوسط';
  bool _includeScreenshot = false;
  final TextEditingController _descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('الإبلاغ عن مشكلة', style: TextStyle(fontWeight: FontWeight.bold))),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(14),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(color: AppColors.error.withOpacity(0.05), borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.error.withOpacity(0.2))),
            child: const Row(children: [Icon(Icons.bug_report, color: AppColors.error, size: 28), SizedBox(width: 10), Expanded(child: Text('نأسف للمشكلة! ساعدنا في حلها بإرسال التفاصيل', style: TextStyle(fontSize: 12, color: AppColors.darkGrey)))]),
          ),
          const SizedBox(height: 16),

          // نوع المشكلة
          Text('نوع المشكلة', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Wrap(spacing: 6, children: ['مشكلة تقنية', 'خطأ في البيانات', 'مشكلة في الدفع', 'اقتراح تحسين', 'أخرى'].map((t) => ChoiceChip(
            label: Text(t, style: const TextStyle(fontSize: 11)),
            selected: _issueType == t,
            selectedColor: AppColors.primary,
            labelStyle: TextStyle(color: _issueType == t ? Colors.white : AppColors.darkGrey),
            onSelected: (_) => setState(() => _issueType = t),
          )).toList()),
          const SizedBox(height: 14),

          // الأولوية
          Text('الأولوية', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Row(children: [
            _priorityChip('منخفض', Colors.green),
            _priorityChip('متوسط', Colors.orange),
            _priorityChip('عاجل', AppColors.error),
          ]),
          const SizedBox(height: 14),

          // الوصف
          Text('وصف المشكلة', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          TextField(
            controller: _descController,
            maxLines: 5,
            textAlign: TextAlign.right,
            decoration: InputDecoration(
              hintText: 'صف المشكلة بالتفصيل... ماذا حدث؟ متى؟ كيف؟',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              filled: true,
              fillColor: AppColors.surfaceContainerLow.withOpacity(0.3),
            ),
          ),
          const SizedBox(height: 12),

          // لقطة شاشة
          SwitchListTile(
            title: const Text('إرفاق لقطة شاشة', style: TextStyle(fontWeight: FontWeight.w500)),
            subtitle: const Text('تساعدنا في فهم المشكلة', style: TextStyle(fontSize: 10, color: AppColors.grey)),
            value: _includeScreenshot,
            activeColor: AppColors.primary,
            secondary: const Icon(Icons.screenshot, color: AppColors.primary),
            onChanged: (v) => setState(() => _includeScreenshot = v),
          ),
          const SizedBox(height: 16),

          SizedBox(width: double.infinity, child: ElevatedButton.icon(onPressed: () { ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('تم إرسال البلاغ. سنراجعه ونتواصل معك.'), backgroundColor: AppColors.success)); }, icon: const Icon(Icons.send), label: const Text('إرسال البلاغ'), style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, padding: const EdgeInsets.symmetric(vertical: 14)))),
        ]),
      ),
    );
  }

  Widget _priorityChip(String label, Color color) {
    final selected = _priority == label;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _priority = label),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 3),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(color: selected ? color.withOpacity(0.1) : Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: selected ? color : AppColors.outlineVariant, width: selected ? 2 : 1)),
          child: Text(label, textAlign: TextAlign.center, style: TextStyle(color: selected ? color : AppColors.darkGrey, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}
