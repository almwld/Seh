import 'package:flutter/material.dart';
import 'package:sehatak/core/constants/app_colors.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('عن التطبيق', style: TextStyle(fontWeight: FontWeight.bold))),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          const SizedBox(height: 20),

          // الشعار
          Container(
            width: 100, height: 100,
            decoration: BoxDecoration(gradient: const LinearGradient(colors: [AppColors.primary, AppColors.primaryDark]), borderRadius: BorderRadius.circular(25), boxShadow: [BoxShadow(color: AppColors.primary.withOpacity(0.3), blurRadius: 20, offset: const Offset(0, 8))]),
            child: const Icon(Icons.health_and_safety, size: 55, color: Colors.white),
          ),
          const SizedBox(height: 16),

          // الاسم والإصدار
          const Text('صحتك', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: AppColors.primary)),
          Container(margin: const EdgeInsets.only(top: 6), padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5), decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.1), borderRadius: BorderRadius.circular(20)), child: const Text('الإصدار 1.0.0', style: TextStyle(fontSize: 13, color: AppColors.primary, fontWeight: FontWeight.w500))),
          const SizedBox(height: 16),

          // الوصف
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3), borderRadius: BorderRadius.circular(16)),
            child: Column(children: [
              const Icon(Icons.format_quote, color: AppColors.primary, size: 28),
              const SizedBox(height: 8),
              const Text('تطبيقك الطبي المتكامل الذي يجمع كل احتياجاتك الصحية في مكان واحد. من استشارة الأطباء إلى طلب الأدوية وحجز المواعيد والتحاليل الطبية.', textAlign: TextAlign.center, style: TextStyle(fontSize: 14, height: 1.7, color: AppColors.darkGrey)),
            ]),
          ),
          const SizedBox(height: 24),

          // مميزات
          _sectionTitle('مميزات التطبيق'),
          const SizedBox(height: 10),
          _featureCard('🩺', 'استشارات طبية', 'تواصل مع أفضل الأطباء عبر المحادثة أو مكالمات الفيديو'),
          _featureCard('💊', 'صيدلية متكاملة', 'اطلب الأدوية واحصل عليها عند باب منزلك'),
          _featureCard('📅', 'حجز المواعيد', 'احجز مواعيدك مع الأطباء بكل سهولة'),
          _featureCard('🔬', 'التحاليل الطبية', 'احجز فحوصاتك المخبرية وتابع نتائجك'),
          _featureCard('📋', 'الملف الصحي', 'سجل طبي كامل لمتابعة حالتك الصحية'),
          _featureCard('🚑', 'الطوارئ والإسعاف', 'أرقام طوارئ وخدمات إسعاف سريعة'),
          _featureCard('🛡️', 'التأمين الصحي', 'قارن واختر أفضل خطط التأمين'),
          _featureCard('🌙', 'الوضع الليلي', 'تصميم مريح للعين في الإضاءة المنخفضة'),
          const SizedBox(height: 24),

          // إحصائيات
          _sectionTitle('بأرقام'),
          const SizedBox(height: 10),
          Row(children: [
            _statCard('500+', 'طبيب', Icons.person, AppColors.primary),
            const SizedBox(width: 8),
            _statCard('1000+', 'دواء', Icons.medication, AppColors.success),
            const SizedBox(width: 8),
            _statCard('50K+', 'مريض', Icons.people, AppColors.info),
          ]),
          const SizedBox(height: 24),

          // فريق التطوير
          _sectionTitle('فريق التطوير'),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 6)]),
            child: const Column(children: [
              _TeamMember(name: 'أحمد المولد', role: 'مطور رئيسي', icon: '👨‍💻'),
              Divider(),
              _TeamMember(name: 'د. علي المولد', role: 'استشاري طبي', icon: '👨‍⚕️'),
            ]),
          ),
          const SizedBox(height: 24),

          // تواصل
          _sectionTitle('تواصل معنا'),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 6)]),
            child: const Column(children: [
              _ContactRow(icon: Icons.email, label: 'البريد الإلكتروني', value: 'info@sehatak.com'),
              Divider(),
              _ContactRow(icon: Icons.phone, label: 'الهاتف', value: '+967 777 123 456'),
              Divider(),
              _ContactRow(icon: Icons.language, label: 'الموقع الإلكتروني', value: 'www.sehatak.com'),
              Divider(),
              _ContactRow(icon: Icons.location_on, label: 'العنوان', value: 'شارع الزبيري، صنعاء، اليمن'),
            ]),
          ),
          const SizedBox(height: 20),

          // مواقع التواصل
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            _socialIcon(Icons.facebook, AppColors.info),
            const SizedBox(width: 14),
            _socialIcon(Icons.camera_alt, AppColors.purple),
            const SizedBox(width: 14),
            _socialIcon(Icons.alternate_email, AppColors.error),
            const SizedBox(width: 14),
            _socialIcon(Icons.play_circle, AppColors.error),
          ]),
          const SizedBox(height: 24),

          // الحقوق
          const Divider(),
          const SizedBox(height: 10),
          const Text('© 2026 صحتك. جميع الحقوق محفوظة.', style: TextStyle(color: AppColors.grey, fontSize: 12)),
          const SizedBox(height: 2),
          const Text('تم التطوير في اليمن 🇾🇪', style: TextStyle(color: AppColors.grey, fontSize: 11)),
          const SizedBox(height: 20),
        ]),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Row(children: [
      Container(width: 4, height: 20, decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(2))),
      const SizedBox(width: 8),
      Text(title, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
    ]);
  }

  Widget _featureCard(String emoji, String title, String desc) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 4)]),
      child: Row(children: [
        Text(emoji, style: const TextStyle(fontSize: 28)),
        const SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)), Text(desc, style: const TextStyle(fontSize: 10, color: AppColors.grey, height: 1.3))])),
      ]),
    );
  }

  Widget _statCard(String value, String label, IconData icon, Color color) {
    return Expanded(
      child: Container(padding: const EdgeInsets.all(14), decoration: BoxDecoration(color: color.withOpacity(0.06), borderRadius: BorderRadius.circular(14)), child: Column(children: [Icon(icon, color: color, size: 28), const SizedBox(height: 6), Text(value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color)), Text(label, style: const TextStyle(fontSize: 10, color: AppColors.grey))])),
    );
  }

  Widget _socialIcon(IconData icon, Color color) {
    return Container(
      width: 48, height: 48,
      decoration: BoxDecoration(color: color.withOpacity(0.08), shape: BoxShape.circle),
      child: IconButton(icon: Icon(icon, color: color, size: 22), onPressed: () {}),
    );
  }
}

class _TeamMember extends StatelessWidget {
  final String name, role, icon;
  const _TeamMember({required this.name, required this.role, required this.icon});
  @override
  Widget build(BuildContext context) {
    return ListTile(leading: Text(icon, style: const TextStyle(fontSize: 32)), title: Text(name, style: const TextStyle(fontWeight: FontWeight.w500)), subtitle: Text(role, style: const TextStyle(fontSize: 10, color: AppColors.grey)));
  }
}

class _ContactRow extends StatelessWidget {
  final IconData icon;
  final String label, value;
  const _ContactRow({required this.icon, required this.label, required this.value});
  @override
  Widget build(BuildContext context) {
    return ListTile(leading: Icon(icon, color: AppColors.primary, size: 22), title: Text(label, style: const TextStyle(fontSize: 12, color: AppColors.grey)), subtitle: Text(value, style: const TextStyle(fontWeight: FontWeight.w500)), contentPadding: EdgeInsets.zero);
  }
}
