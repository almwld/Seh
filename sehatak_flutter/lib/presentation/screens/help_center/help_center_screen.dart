import 'package:flutter/material.dart';
import 'package:sehatak/core/constants/app_colors.dart';

class HelpCenterScreen extends StatelessWidget {
  const HelpCenterScreen({super.key});

  final List<Map<String, dynamic>> _faqs = const [
    {
      'question': 'كيف أحجز موعداً مع طبيب؟',
      'answer': 'اذهب إلى قسم الأطباء، اختر التخصص والطبيب المناسب، ثم اضغط على زر "احجز موعداً". اختر التاريخ والوقت ونوع الموعد (حضوري/فيديو).',
      'icon': '📅',
      'color': AppColors.primary,
    },
    {
      'question': 'كيف أطلب دواء من الصيدلية؟',
      'answer': 'اذهب إلى قسم الصيدلية، ابحث عن الدواء أو تصفح التصنيفات. أضف الدواء للسلة ثم أكمل عملية الشراء.',
      'icon': '💊',
      'color': AppColors.success,
    },
    {
      'question': 'هل يمكنني إلغاء موعد؟',
      'answer': 'نعم، يمكنك إلغاء الموعد قبل 24 ساعة من موعده. اذهب إلى "مواعيدي" واضغط على زر الإلغاء.',
      'icon': '❌',
      'color': AppColors.error,
    },
    {
      'question': 'كيف أضيف دواء للتذكير؟',
      'answer': 'اذهب إلى "تذكير الأدوية" واضغط على +. أدخل اسم الدواء والجرعة والوقت والتكرار.',
      'icon': '⏰',
      'color': AppColors.warning,
    },
    {
      'question': 'هل بياناتي الطبية آمنة؟',
      'answer': 'نعم، جميع بياناتك مشفرة ومحمية بأعلى معايير الأمان. لا نشارك بياناتك مع أي طرف ثالث بدون موافقتك.',
      'icon': '🔒',
      'color': AppColors.info,
    },
    {
      'question': 'كيف أشارك ملفي الصحي مع طبيبي؟',
      'answer': 'اذهب إلى "مشاركة الملف الصحي"، اختر البيانات المراد مشاركتها، وأدخل بريد الطبيب الإلكتروني.',
      'icon': '📤',
      'color': AppColors.purple,
    },
    {
      'question': 'كم تكلفة الاشتراك في الباقات؟',
      'answer': 'الباقة المجانية: 0 ر.س، الذهبية: 99 ر.س/شهر، البلاتينية: 249 ر.س/شهر، العائلية: 399 ر.س/شهر.',
      'icon': '💎',
      'color': AppColors.amber,
    },
    {
      'question': 'كيف أتتبع ضغط الدم والسكر؟',
      'answer': 'اذهب إلى "المؤشرات الحيوية" واختر ضغط الدم أو السكر. يمكنك إضافة قراءاتك اليومية ومتابعة التغيرات.',
      'icon': '📊',
      'color': AppColors.teal,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('مركز المساعدة', style: TextStyle(fontWeight: FontWeight.bold))),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(14),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // شريط بحث
          TextField(
            textAlign: TextAlign.right,
            decoration: InputDecoration(
              hintText: 'ابحث في الأسئلة الشائعة...',
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: AppColors.surfaceContainerLow.withOpacity(0.3),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
            ),
          ),
          const SizedBox(height: 18),

          // أقسام سريعة
          Text('أقسام المساعدة', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Row(children: [
            _categoryCard('الحساب', Icons.person, AppColors.primary),
            _categoryCard('المواعيد', Icons.calendar_today, AppColors.success),
            _categoryCard('الأدوية', Icons.medication, AppColors.warning),
            _categoryCard('التقنية', Icons.devices, AppColors.info),
          ]),
          const SizedBox(height: 18),

          // أسئلة شائعة
          Text('الأسئلة الشائعة', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          ..._faqs.map((faq) => Container(
            margin: const EdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 4)]),
            child: ExpansionTile(
              leading: Text(faq['icon'], style: const TextStyle(fontSize: 24)),
              title: Text(faq['question'], style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13)),
              children: [Padding(padding: const EdgeInsets.fromLTRB(16, 0, 16, 14), child: Text(faq['answer'], style: const TextStyle(fontSize: 12, color: AppColors.darkGrey, height: 1.5)))],
            ),
          )),
          const SizedBox(height: 20),

          // لم تجد إجابة؟
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(gradient: const LinearGradient(colors: [AppColors.primary, AppColors.primaryDark]), borderRadius: BorderRadius.circular(16)),
            child: Column(children: [
              const Icon(Icons.headset_mic, color: Colors.white, size: 40),
              const SizedBox(height: 8),
              const Text('لم تجد إجابتك؟', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
              const Text('فريق الدعم جاهز لمساعدتك', style: TextStyle(color: Colors.white70, fontSize: 12)),
              const SizedBox(height: 12),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                _contactButton('اتصل بنا', Icons.call, () {}),
                _contactButton('راسلنا', Icons.email, () {}),
                _contactButton('دردشة', Icons.chat, () {}),
              ]),
            ]),
          ),
        ]),
      ),
    );
  }

  Widget _categoryCard(String title, IconData icon, Color color) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 3),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: color.withOpacity(0.05), borderRadius: BorderRadius.circular(10)),
        child: Column(children: [Icon(icon, color: color, size: 24), const SizedBox(height: 4), Text(title, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500, color: color))]),
      ),
    );
  }

  Widget _contactButton(String label, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(children: [Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), shape: BoxShape.circle), child: Icon(icon, color: Colors.white, size: 20)), const SizedBox(height: 4), Text(label, style: const TextStyle(color: Colors.white, fontSize: 10))]),
    );
  }
}
