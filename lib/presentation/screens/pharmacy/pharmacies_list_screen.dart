import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_dimensions.dart';
import 'pharmacy_products_screen.dart';

class PharmaciesListScreen extends StatelessWidget {
  const PharmaciesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pharmacies = [
      {'name': 'صيدلية الشفاء', 'address': 'صنعاء - شارع الستين', 'isOpen': true, 'rating': 4.8},
      {'name': 'صيدلية النهدي', 'address': 'عدن - المنصورة', 'isOpen': true, 'rating': 4.5},
      {'name': 'صيدلية الصفوة', 'address': 'تعز - شارع تعز', 'isOpen': false, 'rating': 4.7},
      {'name': 'صيدلية الرحمة', 'address': 'الحديدة - شارع صنعاء', 'isOpen': true, 'rating': 4.6},
      {'name': 'صيدلية الصحة', 'address': 'المكلا - شارع الكورنيش', 'isOpen': true, 'rating': 4.9},
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.pharmacies),
        actions: [IconButton(icon: const Icon(Icons.filter_list), onPressed: () {})],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(AppDimensions.paddingL),
        itemCount: pharmacies.length,
        itemBuilder: (context, index) {
          final pharmacy = pharmacies[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => PharmacyProductsScreen(pharmacyId: 'p$index')));
            },
            child: Container(
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
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.local_pharmacy, color: AppColors.primary, size: 32),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          pharmacy['name'] as String,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          pharmacy['address'] as String,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.grey),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(Icons.star, color: AppColors.amber, size: 16),
                            const SizedBox(width: 4),
                            Text('${pharmacy['rating']}'),
                            const SizedBox(width: 16),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: (pharmacy['isOpen'] as bool) ? AppColors.success.withOpacity(0.1) : AppColors.error.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                (pharmacy['isOpen'] as bool) ? 'مفتوح' : 'مغلق',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: (pharmacy['isOpen'] as bool) ? AppColors.success : AppColors.error,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.grey),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
