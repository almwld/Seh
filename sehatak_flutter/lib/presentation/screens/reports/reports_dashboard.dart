import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_dimensions.dart';

class ReportsDashboard extends StatelessWidget {
  const ReportsDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final reports = [
      {'title': 'التقرير الطبي الشامل', 'date': '2024-01-15', 'type': 'طبي', 'icon': Icons.folder_open, 'color': AppColors.primary},
      {'title': 'تحاليل الدم', 'date': '2024-01-10', 'type': 'مختبر', 'icon': Icons.science, 'color': AppColors.info},
      {'title': 'وصفات طبية', 'date': '2024-01-08', 'type': 'صيدلي', 'icon': Icons.medication, 'color': AppColors.warning},
      {'title': 'المواعيد الطبية', 'date': '2024-01-05', 'type': 'مواعيد', 'icon': Icons.calendar_today, 'color': AppColors.success},
      {'title': 'المصروفات الطبية', 'date': '2024-01-01', 'type': 'مالي', 'icon': Icons.account_balance_wallet, 'color': AppColors.purple},
    ];

    return Scaffold(
      appBar: AppBar(title: Text(AppStrings.reports)),
      body: ListView.builder(
        padding: const EdgeInsets.all(AppDimensions.paddingL),
        itemCount: reports.length,
        itemBuilder: (context, index) {
          final report = reports[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(AppDimensions.paddingL),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.outlineVariant.withOpacity(0.5)),
            ),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(color: (report['color'] as Color).withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
                  child: Icon(report['icon'] as IconData, color: report['color'] as Color, size: 24),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(report['title'] as String, style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600)),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Text('${report['type']} - ${report['date']}', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.grey)),
                        ],
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    IconButton(icon: const Icon(Icons.share, size: 20, color: AppColors.grey), onPressed: () {}),
                    IconButton(icon: const Icon(Icons.download, size: 20, color: AppColors.primary), onPressed: () {}),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
