import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_dimensions.dart';

class PaymentMethods extends StatelessWidget {
  const PaymentMethods({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppStrings.paymentMethods)),
      body: ListView(
        padding: const EdgeInsets.all(AppDimensions.paddingL),
        children: [
          _buildPaymentMethod(context, 'يمن موبايل', '770123456', Icons.phone_android, true),
          _buildPaymentMethod(context, 'سبأفون', '770654321', Icons.phone_android, false),
          _buildPaymentMethod(context, 'بنك الكريمي', '**** 1234', Icons.account_balance, false),
          _buildPaymentMethod(context, 'كاش', 'الدفع عند الاستلام', Icons.money, false),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildPaymentMethod(BuildContext context, String name, String detail, IconData icon, bool isDefault) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: isDefault ? AppColors.primary : AppColors.outlineVariant.withOpacity(0.5), width: isDefault ? 2 : 1),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
            child: Icon(icon, color: AppColors.primary, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(name, style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600)),
                    if (isDefault) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.1), borderRadius: BorderRadius.circular(6)),
                        child: const Text('افتراضي', style: TextStyle(fontSize: 10, color: AppColors.primary)),
                      ),
                    ],
                  ],
                ),
                Text(detail, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.grey)),
              ],
            ),
          ),
          PopupMenuButton(
            itemBuilder: (context) => [
              const PopupMenuItem(child: Text('تعيين كافتراضي')),
              const PopupMenuItem(child: Text('تعديل')),
              const PopupMenuItem(child: Text('حذف', style: TextStyle(color: AppColors.error))),
            ],
          ),
        ],
      ),
    );
  }
}
