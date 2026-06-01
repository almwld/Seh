import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_dimensions.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppStrings.wallet)),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(AppDimensions.paddingL),
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [AppColors.primary, AppColors.primaryDark], begin: Alignment.topLeft, end: Alignment.bottomRight),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [BoxShadow(color: AppColors.primary.withOpacity(0.3), blurRadius: 15, offset: const Offset(0, 8))],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(AppStrings.balance, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.white.withOpacity(0.9))),
                const SizedBox(height: 8),
                Text(
                  '125,000 ${AppStrings.currencyYER}',
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(color: AppColors.white, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.add, size: 18),
                        label: Text(AppStrings.addMoney),
                        style: ElevatedButton.styleFrom(backgroundColor: AppColors.white, foregroundColor: AppColors.primary),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.arrow_downward, size: 18),
                        label: Text(AppStrings.withdraw),
                        style: ElevatedButton.styleFrom(backgroundColor: AppColors.white.withOpacity(0.2), foregroundColor: AppColors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(AppDimensions.paddingL),
              children: [
                Text(AppStrings.transactions, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600)),
                const SizedBox(height: 12),
                _buildTransactionItem(context, 'حجز موعد طبي', '-5,000', '2024-01-15', AppColors.error, Icons.calendar_today),
                _buildTransactionItem(context, 'شحن محفظة', '+50,000', '2024-01-10', AppColors.success, Icons.add),
                _buildTransactionItem(context, 'شراء أدوية', '-12,000', '2024-01-08', AppColors.error, Icons.medication),
                _buildTransactionItem(context, 'استرداد مبلغ', '+3,000', '2024-01-05', AppColors.success, Icons.undo),
                _buildTransactionItem(context, 'تحليل مخبري', '-3,500', '2024-01-03', AppColors.error, Icons.science),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionItem(BuildContext context, String title, String amount, String date, Color color, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w500)),
                Text(date, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.grey)),
              ],
            ),
          ),
          Text(
            amount,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(color: color, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
