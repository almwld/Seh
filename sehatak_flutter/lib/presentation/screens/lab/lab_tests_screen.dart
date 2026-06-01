import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_dimensions.dart';
import 'test_booking_screen.dart';

class LabTestsScreen extends StatelessWidget {
  final String labId;
  const LabTestsScreen({super.key, required this.labId});

  @override
  Widget build(BuildContext context) {
    final tests = [
      {'name': 'CBC - صورة دم كاملة', 'price': 3500.0, 'duration': '30 دقيقة', 'category': 'دم'},
      {'name': 'سكر صائم', 'price': 1500.0, 'duration': '15 دقيقة', 'category': 'سكر'},
      {'name': 'وظائف الكلى', 'price': 4500.0, 'duration': '1 ساعة', 'category': 'كيمياء'},
      {'name': 'وظائف الكبد', 'price': 5000.0, 'duration': '1 ساعة', 'category': 'كيمياء'},
      {'name': 'دهون في الدم', 'price': 4000.0, 'duration': '45 دقيقة', 'category': 'دهون'},
      {'name': 'فيتامين دال', 'price': 3000.0, 'duration': '2 ساعة', 'category': 'فيتامينات'},
      {'name': 'تحليل البول', 'price': 1000.0, 'duration': '15 دقيقة', 'category': 'بول'},
      {'name': 'HBA1C', 'price': 2500.0, 'duration': '1 ساعة', 'category': 'سكر'},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('التحاليل المتاحة')),
      body: ListView.builder(
        padding: const EdgeInsets.all(AppDimensions.paddingL),
        itemCount: tests.length,
        itemBuilder: (context, index) {
          final test = tests[index];
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
                  decoration: BoxDecoration(color: AppColors.info.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
                  child: const Icon(Icons.science, color: AppColors.info),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(test['name'] as String, style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600)),
                      const SizedBox(height: 4),
                      Text('${test['category']} - ${test['duration']}', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.grey)),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('${test['price']} ${AppStrings.currencyYER}', style: Theme.of(context).textTheme.titleSmall?.copyWith(color: AppColors.primary, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => TestBookingScreen(testId: 't$index'))),
                      style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), minimumSize: Size.zero),
                      child: const Text('احجز', style: TextStyle(fontSize: 12)),
                    ),
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
