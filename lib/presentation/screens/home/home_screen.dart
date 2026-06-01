import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sehatak/core/constants/app_colors.dart';
import 'package:sehatak/presentation/widgets/common_widgets.dart';
import 'package:sehatak/presentation/screens/doctor/doctors_list_screen.dart';
import 'package:sehatak/presentation/screens/more/more_screen.dart';
import 'package:sehatak/presentation/screens/pharmacy/pharmacy_screen.dart';
import 'package:sehatak/presentation/screens/emergencies/emergency_numbers.dart';
import 'package:sehatak/presentation/screens/consultation/consultation_screen.dart';
import 'package:sehatak/presentation/screens/patient/patient_medical_history.dart';
import 'package:sehatak/presentation/bloc/theme_bloc/theme_bloc.dart';
import 'package:sehatak/presentation/screens/about/about_screen.dart';
import 'package:sehatak/presentation/screens/health_tips/health_tips_screen.dart';
import 'package:sehatak/presentation/screens/health_map/health_map_screen.dart';
import 'package:sehatak/presentation/screens/patient/patient_appointments.dart';
import 'package:sehatak/presentation/screens/patient/patient_dashboard.dart';
import 'package:sehatak/presentation/screens/chat/chat_screen.dart';
import 'package:sehatak/presentation/screens/smart_clinic/smart_clinic_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    _HomeTab(),
    DoctorsListScreen(),
    PharmacyScreen(),
    ChatScreen(),
    PatientAppointments(),
    PatientDashboard(),
    MoreScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? const Color(0xFF1E293B) : Colors.white;

    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: Container(
        height: 68,
        decoration: BoxDecoration(
          color: bgColor,
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.12), blurRadius: 12, offset: const Offset(0, -2))],
        ),
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _navItem(0, Icons.home_rounded, 'الرئيسية'),
              _navItem(1, Icons.person_search_rounded, 'الأطباء'),
              _navItem(2, Icons.local_pharmacy_rounded, 'الصيدلية'),
              // أيقونة الدردشة الوسطى البارزة
              _centerChatButton(),
              _navItem(4, Icons.calendar_month_rounded, 'المواعيد'),
              _navItem(5, Icons.folder_rounded, 'صحتي'),
              _navItem(6, Icons.grid_view_rounded, 'المزيد'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _navItem(int index, IconData icon, String label) {
    final selected = _currentIndex == index;
    final color = selected ? AppColors.primary : Theme.of(context).unselectedWidgetColor ?? AppColors.grey;

    return GestureDetector(
      onTap: () => setState(() => _currentIndex = index),
      child: SizedBox(
        width: 48,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (selected)
              Container(
                width: 32, height: 3,
                margin: const EdgeInsets.only(bottom: 4),
                decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(2)),
              )
            else
              const SizedBox(height: 7),
            Icon(icon, color: color, size: 22),
            const SizedBox(height: 2),
            Text(label, style: TextStyle(fontSize: 9, fontWeight: selected ? FontWeight.w600 : FontWeight.normal, color: color)),
          ],
        ),
      ),
    );
  }

  Widget _centerChatButton() {
    final selected = _currentIndex == 3;
    return GestureDetector(
      onTap: () => setState(() => _currentIndex = 3),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 50,
            height: 50,
            margin: const EdgeInsets.only(bottom: 2),
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [AppColors.primary, AppColors.primaryDark]),
              shape: BoxShape.circle,
              boxShadow: [BoxShadow(color: AppColors.primary.withOpacity(0.45), blurRadius: 14, offset: const Offset(0, 4))],
            ),
            child: const Icon(Icons.chat_rounded, color: Colors.white, size: 26),
          ),
          Text('الدردشة', style: TextStyle(fontSize: 8, fontWeight: selected ? FontWeight.w600 : FontWeight.normal, color: selected ? AppColors.primary : AppColors.grey)),
        ],
      ),
    );
  }
}

class _HomeTab extends StatelessWidget {
  const _HomeTab();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [AppColors.primary, AppColors.primaryDark]),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.smart_toy, color: Colors.white, size: 20),
          ),
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SmartClinicScreen())),
          tooltip: 'المساعد الذكي',
        ),
        title: const Row(children: [Text('👋'), SizedBox(width: 8), Text('صباح الخير، أحمد')]),
        actions: [
          BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, state) {
              bool isDark = false;
              if (state is ThemeLoadedState) isDark = state.themeMode == ThemeMode.dark;
              return IconButton(icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode), onPressed: () => context.read<ThemeBloc>().add(SetThemeEvent(!isDark)), tooltip: isDark ? 'الوضع النهاري' : 'الوضع الليلي');
            },
          ),
          IconButton(icon: const Icon(Icons.notifications_outlined), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(14),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const CustomSearchBar(hint: 'بحث عن خدمات، أطباء، مقالات...'),
          const SizedBox(height: 16),
          Container(
            width: double.infinity, padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(gradient: const LinearGradient(colors: [Color(0xFF00796B), Color(0xFF004D40)]), borderRadius: BorderRadius.circular(16)),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text('صحتك، أولويتنا', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              const Text('رعاية موثوقة في أي وقت وأي مكان', style: TextStyle(color: Colors.white70, fontSize: 14)),
              const SizedBox(height: 14),
              ElevatedButton.icon(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AboutScreen())), icon: const Icon(Icons.explore), label: const Text('استكشف الآن'), style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: AppColors.primary, padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12))),
            ]),
          ),
          const SizedBox(height: 22),
          Text('خدمات سريعة', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            _quickService(context, Icons.local_pharmacy, 'الصيدلية', AppColors.success, () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PharmacyScreen()))),
            _quickService(context, Icons.emergency, 'الطوارئ', AppColors.error, () => Navigator.push(context, MaterialPageRoute(builder: (_) => const EmergencyNumbers()))),
            _quickService(context, Icons.map, 'الخرائط', AppColors.teal, () => Navigator.push(context, MaterialPageRoute(builder: (_) => const HealthMapScreen()))),
            _quickService(context, Icons.video_call, 'استشارات', AppColors.info, () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ConsultationScreen()))),
            _quickService(context, Icons.science, 'التحاليل', AppColors.purple, () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PatientMedicalHistory()))),
          ]),
          const SizedBox(height: 22),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text('أفضل الأطباء', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            TextButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const DoctorsListScreen())), child: const Text('عرض الكل ›')),
          ]),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(gradient: LinearGradient(colors: [AppColors.primary.withOpacity(0.05), AppColors.primary.withOpacity(0.02)]), borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.primary.withOpacity(0.2))),
            child: Row(children: [
              Container(width: 65, height: 65, decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.1), borderRadius: BorderRadius.circular(16)), child: const Center(child: Text('👨‍⚕️', style: TextStyle(fontSize: 34)))),
              const SizedBox(width: 12),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Row(children: [Text('د. علي المولد', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)), SizedBox(width: 6), Icon(Icons.verified, color: AppColors.info, size: 18)]),
                const Text('استشاري باطنية وأطفال', style: TextStyle(fontSize: 12, color: AppColors.primary)),
                const Text('خبرة 20+ سنة', style: TextStyle(fontSize: 11, color: AppColors.darkGrey)),
                Row(children: [const Icon(Icons.star, color: AppColors.amber, size: 16), const Text(' 4.9', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)), const Text(' (328 تقييم)', style: TextStyle(fontSize: 10, color: AppColors.grey)), const SizedBox(width: 10), Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: Colors.green.withOpacity(0.1), borderRadius: BorderRadius.circular(4)), child: const Text('متاح اليوم', style: TextStyle(fontSize: 9, color: Colors.green)))]),
              ])),
            ]),
          ),
          const SizedBox(height: 8),
          DoctorCard(name: 'د. حسن رضا', specialty: 'طبيب عام', experience: 'خبرة 8+ سنوات', rating: 4.8, reviews: 235, onTap: () {}),
          const SizedBox(height: 6),
          DoctorCard(name: 'د. عائشة ملك', specialty: 'طبيبة جلدية', experience: 'خبرة 6+ سنوات', rating: 4.9, reviews: 189, onTap: () {}),
          const SizedBox(height: 22),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text('نصائح ومقالات', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)), TextButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const HealthTipsScreen())), child: const Text('المزيد ›'))]),
          const SizedBox(height: 8),
          Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.amber.shade100, Colors.orange.shade100]), borderRadius: BorderRadius.circular(16)), child: Row(children: [Container(width: 50, height: 50, decoration: BoxDecoration(color: AppColors.amber.withOpacity(0.3), shape: BoxShape.circle), child: const Center(child: Text('💡', style: TextStyle(fontSize: 28)))), const SizedBox(width: 12), const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('نصيحة اليوم', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)), Text('اشرب 8 أكواب من الماء يومياً للحفاظ على صحة الكلى والجسم', style: TextStyle(fontSize: 12, color: AppColors.darkGrey, height: 1.4))]))])),
          const SizedBox(height: 22),
          Text('السجل الطبي', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          _historyItem(context, 'ارتفاع ضغط الدم', 'تم التشخيص: 15 مارس 2023', AppColors.error),
          _historyItem(context, 'الربو', 'تم التشخيص: 10 يناير 2021', AppColors.warning),
          _historyItem(context, 'التهاب المعدة', 'تم التشخيص: 5 أغسطس 2019', AppColors.info),
          const SizedBox(height: 80),
        ]),
      ),
    );
  }

  Widget _quickService(BuildContext context, IconData icon, String label, Color color, VoidCallback onTap) {
    return GestureDetector(onTap: onTap, child: Column(children: [Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: color.withOpacity(0.08), shape: BoxShape.circle), child: Icon(icon, color: color, size: 24)), const SizedBox(height: 4), Text(label, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w500))]));
  }

  Widget _historyItem(BuildContext context, String title, String subtitle, Color color) {
    return Container(margin: const EdgeInsets.only(bottom: 6), padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.2), borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.outlineVariant.withOpacity(0.4))), child: Row(children: [Container(width: 4, height: 38, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(2))), const SizedBox(width: 10), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(fontWeight: FontWeight.w500)), Text(subtitle, style: const TextStyle(fontSize: 10, color: AppColors.grey))])), const Icon(Icons.chevron_left, color: AppColors.grey)]));
  }
}
