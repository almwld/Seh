import 'package:flutter/material.dart';
import 'package:sehatak/core/constants/app_colors.dart';

class ShareAppScreen extends StatelessWidget {
  const ShareAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('مشاركة التطبيق', style: TextStyle(fontWeight: FontWeight.bold))),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(14),
        child: Column(children: [
          const SizedBox(height: 20),
          const Icon(Icons.share, size: 80, color: AppColors.primary),
          const SizedBox(height: 16),
          const Text('شارك صحتك مع أحبابك', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          const Text('ساعد الآخرين في العناية بصحتهم', style: TextStyle(color: AppColors.grey, fontSize: 13)),
          const SizedBox(height: 30),

          // طرق المشاركة
          Text('اختر طريقة المشاركة', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          GridView.count(crossAxisCount: 3, shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), crossAxisSpacing: 12, mainAxisSpacing: 12, childAspectRatio: 0.95,
            children: [
              _shareOption('واتساب', Icons.chat, const Color(0xFF25D366)),
              _shareOption('فيسبوك', Icons.facebook, const Color(0xFF1877F2)),
              _shareOption('تويتر', Icons.alternate_email, const Color(0xFF1DA1F2)),
              _shareOption('تليجرام', Icons.telegram, const Color(0xFF0088cc)),
              _shareOption('رسائل', Icons.message, AppColors.primary),
              _shareOption('نسخ الرابط', Icons.link, AppColors.success),
              _shareOption('بريد', Icons.email, AppColors.warning),
              _shareOption('المزيد', Icons.more_horiz, AppColors.grey),
              _shareOption('QR Code', Icons.qr_code, AppColors.dark),
            ],
          ),
          const SizedBox(height: 24),

          // كود QR
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8)]),
            child: Column(children: [
              const Text('رمز المشاركة السريع', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              const SizedBox(height: 14),
              Container(
                width: 160, height: 160,
                decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.05), borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.primary.withOpacity(0.2))),
                child: const Center(child: Icon(Icons.qr_code_2, size: 120, color: AppColors.primary)),
              ),
              const SizedBox(height: 8),
              const Text('امسح للتحميل', style: TextStyle(fontSize: 11, color: AppColors.grey)),
            ]),
          ),
          const SizedBox(height: 20),
        ]),
      ),
    );
  }

  Widget _shareOption(String label, IconData icon, Color color) {
    return GestureDetector(
      onTap: () {},
      child: Column(children: [
        Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: color.withOpacity(0.08), shape: BoxShape.circle), child: Icon(icon, color: color, size: 28)),
        const SizedBox(height: 6),
        Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500)),
      ]),
    );
  }
}
