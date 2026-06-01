import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';

class HealthDashboard extends StatelessWidget {
  const HealthDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('لوحة الصحة')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppDimensions.paddingL),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildMetricCard(context, Icons.favorite, 'نبض القلب', '72', 'نبضة/دقيقة', AppColors.error, [70, 75, 72, 78, 74, 72, 71]),
            const SizedBox(height: 12),
            _buildMetricCard(context, Icons.water_drop, 'ضغط الدم', '120/80', 'مم زئبق', AppColors.primary, [118, 120, 122, 119, 121, 120, 120]),
            const SizedBox(height: 12),
            _buildMetricCard(context, Icons.bloodtype, 'السكر', '95', 'مج/دل', AppColors.warning, [90, 95, 100, 88, 92, 95, 97]),
            const SizedBox(height: 12),
            _buildMetricCard(context, Icons.monitor_weight, 'الوزن', '72', 'كجم', AppColors.success, [73, 72.5, 72, 71.8, 72, 72.2, 72]),
            const SizedBox(height: 12),
            _buildMetricCard(context, Icons.water, 'شرب الماء', '1.5', 'لتر', AppColors.info, [1.2, 1.5, 1.8, 1.5, 1.0, 1.5, 1.5]),
            const SizedBox(height: 12),
            _buildMetricCard(context, Icons.bedtime, 'النوم', '7.5', 'ساعات', AppColors.purple, [7, 8, 6.5, 7.5, 8, 7.5, 7]),
            const SizedBox(height: 12),
            _buildMetricCard(context, Icons.directions_walk, 'الخطوات', '8,432', 'خطوة', AppColors.teal, [7500, 8200, 9000, 8432, 7800, 8500, 8432]),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildMetricCard(BuildContext context, IconData icon, String title, String value, String unit, Color color, List<double> data) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.outlineVariant.withOpacity(0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
                child: Icon(icon, color: color, size: 22),
              ),
              const SizedBox(width: 12),
              Text(title, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
              const Spacer(),
              TextButton(onPressed: () {}, child: const Text('عرض الكل')),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Text(value, style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.bold, color: color)),
              const SizedBox(width: 8),
              Text(unit, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.grey)),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            height: 60,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: data.map((d) {
                return Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    height: (d / data.reduce((a, b) => a > b ? a : b)) * 50,
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
