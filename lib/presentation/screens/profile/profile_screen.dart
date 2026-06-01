import 'package:flutter/material.dart';
import 'package:sehatak/core/constants/app_colors.dart';
import 'package:sehatak/presentation/screens/settings/settings_screen.dart';
import 'package:sehatak/presentation/screens/patient/patient_appointments.dart';
import 'package:sehatak/presentation/screens/patient/patient_prescriptions.dart';
import 'package:sehatak/presentation/screens/patient/patient_medical_history.dart';
import 'package:sehatak/presentation/screens/medical_reports/medical_reports_screen.dart';
import 'package:sehatak/presentation/screens/subscriptions/subscriptions_screen.dart';
import 'package:sehatak/presentation/screens/payment/payment_methods_screen.dart';
import 'package:sehatak/presentation/screens/favorites/favorite_doctors_screen.dart';
import 'package:sehatak/presentation/screens/visit_history/visit_history_screen.dart';
import 'package:sehatak/presentation/screens/medical_notes/medical_notes_screen.dart';
import 'package:sehatak/presentation/screens/auth/login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('حسابي', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(icon: const Icon(Icons.settings_outlined), onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsScreen()))),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(14),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // بطاقة الملف الشخصي
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(gradient: const LinearGradient(colors: [AppColors.primary, AppColors.primaryDark]), borderRadius: BorderRadius.circular(16)),
            child: Column(children: [
              Stack(children: [
                const CircleAvatar(radius: 45, backgroundColor: Colors.white24, child: Text('أح', style: TextStyle(fontSize: 36, color: Colors.white))),
                Positioned(bottom: 0, right: 0, child: Container(padding: const EdgeInsets.all(4), decoration: const BoxDecoration(color: AppColors.success, shape: BoxShape.circle), child: const Icon(Icons.edit, color: Colors.white, size: 14))),
              ]),
              const SizedBox(height: 12),
              const Text('أحمد محمد', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
              const Text('ahmed@email.com', style: TextStyle(color: Colors.white70, fontSize: 13)),
              const Text('📱 +967 777 123 456', style: TextStyle(color: Colors.white70, fontSize: 12)),
              const SizedBox(height: 10),
              Container(padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6), decoration: BoxDecoration(color: Colors.white.withOpacity(0.15), borderRadius: BorderRadius.circular(20)), child: const Text('عضو منذ 2024', style: TextStyle(color: Colors.white, fontSize: 11))),
            ]),
          ),
          const SizedBox(height: 20),

          // نقاط ومستوى
          Row(children: [
            _statCard('النقاط', '1,250', Icons.stars, AppColors.amber),
            const SizedBox(width: 10),
            _statCard('المستوى', 'ذهبي', Icons.workspace_premium, AppColors.success),
            const SizedBox(width: 10),
            _statCard('الزيارات', '12', Icons.history, AppColors.info),
          ]),
          const SizedBox(height: 22),

          // النشاط الصحي
          Text('نشاطي الصحي', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          _menuItem(context, Icons.calendar_month_rounded, 'مواعيدي', '3 مواعيد قادمة', () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PatientAppointments()))),
          _menuItem(context, Icons.receipt_long, 'وصفاتي', '3 وصفات نشطة', () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PatientPrescriptions()))),
          _menuItem(context, Icons.science_rounded, 'تحاليلي', '6 فحوصات', () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PatientMedicalHistory()))),
          _menuItem(context, Icons.description_outlined, 'تقاريري', '7 تقارير', () => Navigator.push(context, MaterialPageRoute(builder: (_) => const MedicalReportsScreen()))),
          _menuItem(context, Icons.history, 'سجل الزيارات', '5 زيارات سابقة', () => Navigator.push(context, MaterialPageRoute(builder: (_) => const VisitHistoryScreen()))),
          _menuItem(context, Icons.favorite_outline, 'أطبائي المفضلين', '4 أطباء', () => Navigator.push(context, MaterialPageRoute(builder: (_) => const FavoriteDoctorsScreen()))),
          _menuItem(context, Icons.note_alt_outlined, 'ملاحظاتي', '3 ملاحظات', () => Navigator.push(context, MaterialPageRoute(builder: (_) => const MedicalNotesScreen()))),
          const SizedBox(height: 22),

          // الاشتراكات والدفع
          Text('الاشتراكات والدفع', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(color: AppColors.amber.withOpacity(0.06), borderRadius: BorderRadius.circular(14), border: Border.all(color: AppColors.amber.withOpacity(0.25))),
            child: Row(children: [
              const Icon(Icons.workspace_premium, color: AppColors.amber, size: 32),
              const SizedBox(width: 12),
              const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('الباقة الذهبية', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)), Text('تنتهي في 30 مايو 2026', style: TextStyle(fontSize: 10, color: AppColors.grey))])),
              OutlinedButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SubscriptionsScreen())), child: const Text('ترقية')),
            ]),
          ),
          const SizedBox(height: 8),
          _menuItem(context, Icons.payment, 'طرق الدفع', 'بطاقتان مسجلتان', () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PaymentMethodsScreen()))),
          const SizedBox(height: 22),

          // عام
          Text('عام', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          _menuItem(context, Icons.settings_outlined, 'الإعدادات', 'تفضيلات الحساب', () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsScreen()))),
          _menuItem(context, Icons.help_outline, 'المساعدة والدعم', 'تواصل معنا', () {}),
          _menuItem(context, Icons.share_rounded, 'مشاركة التطبيق', 'انشر الفائدة', () {}),
          _menuItem(context, Icons.star_outline_rounded, 'تقييم التطبيق', 'قيمنا على المتجر', () {}),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () => Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) => const LoginScreen()), (route) => false),
              icon: const Icon(Icons.logout, color: AppColors.error),
              label: const Text('تسجيل الخروج'),
              style: OutlinedButton.styleFrom(foregroundColor: AppColors.error, side: const BorderSide(color: AppColors.error), padding: const EdgeInsets.symmetric(vertical: 12)),
            ),
          ),
          const SizedBox(height: 20),
        ]),
      ),
    );
  }

  Widget _statCard(String label, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(padding: const EdgeInsets.all(14), decoration: BoxDecoration(color: color.withOpacity(0.06), borderRadius: BorderRadius.circular(12)), child: Column(children: [Icon(icon, color: color, size: 24), const SizedBox(height: 6), Text(value, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: color)), Text(label, style: const TextStyle(fontSize: 10, color: AppColors.grey))])),
    );
  }

  Widget _menuItem(BuildContext context, IconData icon, String title, String subtitle, VoidCallback onTap) {
    return Card(
      margin: const EdgeInsets.only(bottom: 4), elevation: 0,
      color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: Container(padding: const EdgeInsets.all(7), decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.08), borderRadius: BorderRadius.circular(8)), child: Icon(icon, color: AppColors.primary, size: 20)),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13)),
        subtitle: Text(subtitle, style: const TextStyle(fontSize: 9, color: AppColors.grey)),
        trailing: const Icon(Icons.arrow_back_ios, size: 12, color: AppColors.grey),
        onTap: onTap,
      ),
    );
  }
}
