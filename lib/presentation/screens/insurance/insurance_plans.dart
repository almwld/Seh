import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_dimensions.dart';

class InsurancePlans extends StatelessWidget {
  final String companyId;
  const InsurancePlans({super.key, required this.companyId});

  @override
  Widget build(BuildContext context) {
    final plans = [
      {'name': 'الخطة الأساسية', 'price': 15000.0, 'duration': 'سنوي', 'coverage': ['استشارات', 'فحوصات أساسية']},
      {'name': 'الخطة المتوسطة', 'price': 30000.0, 'duration': 'سنوي', 'coverage': ['استشارات', 'فحوصات', 'عمليات صغيرة']},
      {'name': 'الخطة الشاملة', 'price': 50000.0, 'duration': 'سنوي', 'coverage': ['كل الخدمات', 'عمليات كبرى', 'علاج طبيعي']},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('خطط التأمين')),
      body: ListView.builder(
        padding: const EdgeInsets.all(AppDimensions.paddingL),
        itemCount: plans.length,
        itemBuilder: (context, index) {
          final plan = plans[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(AppDimensions.paddingL),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.outlineVariant.withOpacity(0.5)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(plan['name'] as String, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                      child: Text(
                        '${plan['price']} ${AppStrings.currencyYER}',
                        style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                ...((plan['coverage'] as List<String>).map((c) => Row(
                  children: [
                    const Icon(Icons.check_circle, color: AppColors.success, size: 16),
                    const SizedBox(width: 8),
                    Text(c, style: Theme.of(context).textTheme.bodyMedium),
                  ],
                ))),
                const SizedBox(height: 16),
                ElevatedButton(onPressed: () {}, child: const Text('اشترك الآن')),
              ],
            ),
          );
        },
      ),
    );
  }
}
