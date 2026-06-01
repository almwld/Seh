import 'package:flutter/material.dart';
import 'package:sehatak/core/constants/app_colors.dart';
import 'package:sehatak/presentation/screens/patient/patient_medical_history.dart';
import 'package:sehatak/presentation/screens/patient/patient_prescriptions.dart';
import 'package:sehatak/presentation/screens/patient/patient_appointments.dart';
import 'package:sehatak/presentation/screens/vaccination/vaccination_screen.dart';
import 'package:sehatak/presentation/screens/medical_reports/medical_reports_screen.dart';

class PatientDashboard extends StatefulWidget {
  const PatientDashboard({super.key});
  @override
  State<PatientDashboard> createState() => _PatientDashboardState();
}

class _PatientDashboardState extends State<PatientDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الملف الصحي', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(icon: const Icon(Icons.share), onPressed: () {}),
          IconButton(icon: const Icon(Icons.qr_code), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(14),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // بطاقة المريض
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(gradient: const LinearGradient(colors: [AppColors.primary, AppColors.primaryDark]), borderRadius: BorderRadius.circular(16)),
            child: Column(children: [
              const CircleAvatar(radius: 38, backgroundColor: Colors.white24, child: Text('أح', style: TextStyle(fontSize: 30, color: Colors.white))),
              const SizedBox(height: 10),
              const Text('أحمد محمد', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
              const Text('رقم المريض: SH-2024-0012', style: TextStyle(color: Colors.white70, fontSize: 11)),
              const Text('العمر: 29 سنة • الدم: O+', style: TextStyle(color: Colors.white70, fontSize: 11)),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: Colors.white.withOpacity(0.12), borderRadius: BorderRadius.circular(12)),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                  _vitalStat('🩸', 'الدم', 'O+'),
                  _vitalStat('⚖️', 'الوزن', '72 كجم'),
                  _vitalStat('📏', 'الطول', '175 سم'),
                  _vitalStat('🎂', 'العمر', '29 سنة'),
                ]),
              ),
            ]),
          ),
          const SizedBox(height: 18),

          // نقاط الولاء
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(color: AppColors.amber.withOpacity(0.06), borderRadius: BorderRadius.circular(14), border: Border.all(color: AppColors.amber.withOpacity(0.25))),
            child: Row(children: [
              Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: AppColors.amber.withOpacity(0.15), shape: BoxShape.circle), child: const Icon(Icons.stars, color: AppColors.amber, size: 28)),
              const SizedBox(width: 12),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Text('نقاط الولاء', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                const Text('1,250 نقطة', style: TextStyle(color: AppColors.amber, fontSize: 24, fontWeight: FontWeight.bold)),
                const Text('استخدم نقاطك للحصول على خصومات', style: TextStyle(fontSize: 10, color: AppColors.grey)),
              ])),
              const Icon(Icons.chevron_left),
            ]),
          ),
          const SizedBox(height: 18),

          // وصول سريع
          Text('وصول سريع', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Row(children: [
            _quickAccess(context, 'المواعيد', Icons.calendar_month, AppColors.primary, () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PatientAppointments()))),
            _quickAccess(context, 'الوصفات', Icons.receipt_long, AppColors.success, () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PatientPrescriptions()))),
            _quickAccess(context, 'التحاليل', Icons.science, AppColors.info, () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PatientMedicalHistory()))),
            _quickAccess(context, 'التقارير', Icons.description, AppColors.purple, () => Navigator.push(context, MaterialPageRoute(builder: (_) => const MedicalReportsScreen()))),
            _quickAccess(context, 'التطعيمات', Icons.vaccines, AppColors.teal, () => Navigator.push(context, MaterialPageRoute(builder: (_) => const VaccinationScreen()))),
          ]),
          const SizedBox(height: 18),

          // الأمراض المزمنة
          Text('الأمراض المزمنة', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          _conditionCard('ارتفاع ضغط الدم', 'تم التشخيص: 15 مارس 2023', 'تحت السيطرة', AppColors.error, Icons.favorite_border),
          _conditionCard('الربو', 'تم التشخيص: 10 يناير 2021', 'خفيف', AppColors.warning, Icons.air),
          _conditionCard('التهاب المعدة', 'تم التشخيص: 5 أغسطس 2019', 'تم الشفاء', AppColors.info, Icons.restaurant),
          const SizedBox(height: 18),

          // التطعيمات
          Text('التطعيمات', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 6)]),
            child: Column(children: [
              _vaccineItem('كوفيد-19', 'فايزر • جرعتين', 'آخر: يناير 2025', true),
              const Divider(),
              _vaccineItem('الإنفلونزا', 'سنوي', 'آخر: أكتوبر 2025', true),
              const Divider(),
              _vaccineItem('التهاب الكبد ب', '3 جرعات', 'مكتمل: 2019', true),
              const Divider(),
              _vaccineItem('الكزاز', 'كل 10 سنوات', 'القادم: 2028', false),
            ]),
          ),
          const SizedBox(height: 18),

          // الحساسية
          Text('الحساسية', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Wrap(spacing: 8, runSpacing: 8, children: [
            _allergyChip('🥜', 'فول سوداني', AppColors.error),
            _allergyChip('💊', 'بنسلين', AppColors.warning),
            _allergyChip('🌿', 'حبوب لقاح', AppColors.info),
            _allergyChip('🐱', 'وبر القطط', AppColors.purple),
          ]),
          const SizedBox(height: 25),
        ]),
      ),
    );
  }

  Widget _vitalStat(String emoji, String label, String value) {
    return Column(children: [Text(emoji, style: const TextStyle(fontSize: 20)), const SizedBox(height: 2), Text(value, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)), Text(label, style: const TextStyle(color: Colors.white60, fontSize: 9))]);
  }

  Widget _quickAccess(BuildContext context, String label, IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(children: [
        Container(width: 50, height: 50, decoration: BoxDecoration(color: color.withOpacity(0.08), borderRadius: BorderRadius.circular(12)), child: Icon(icon, color: color, size: 24)),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w500)),
      ]),
    );
  }

  Widget _conditionCard(String name, String diagnosed, String status, Color color, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 4)]),
      child: Row(children: [
        Container(width: 4, height: 40, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(2))),
        const SizedBox(width: 10),
        Icon(icon, color: color, size: 20),
        const SizedBox(width: 10),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(name, style: const TextStyle(fontWeight: FontWeight.w500)), Text(diagnosed, style: const TextStyle(fontSize: 9, color: AppColors.grey))])),
        Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: color.withOpacity(0.08), borderRadius: BorderRadius.circular(8)), child: Text(status, style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.bold))),
      ]),
    );
  }

  Widget _vaccineItem(String name, String description, String date, bool done) {
    return Row(children: [
      Container(width: 32, height: 32, decoration: BoxDecoration(color: done ? AppColors.success.withOpacity(0.1) : AppColors.warning.withOpacity(0.1), shape: BoxShape.circle), child: Icon(done ? Icons.check : Icons.schedule, color: done ? AppColors.success : AppColors.warning, size: 16)),
      const SizedBox(width: 10),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(name, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 12)), Text('$description • $date', style: const TextStyle(fontSize: 9, color: AppColors.grey))])),
    ]);
  }

  Widget _allergyChip(String emoji, String name, Color color) {
    return Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8), decoration: BoxDecoration(color: color.withOpacity(0.06), borderRadius: BorderRadius.circular(20), border: Border.all(color: color.withOpacity(0.15))), child: Row(mainAxisSize: MainAxisSize.min, children: [Text(emoji), const SizedBox(width: 4), Text(name, style: TextStyle(color: color, fontWeight: FontWeight.w500, fontSize: 12))]));
  }
}
