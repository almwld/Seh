import 'package:flutter/material.dart';
import 'package:sehatak/core/constants/app_colors.dart';

class HomeCareScreen extends StatelessWidget {
  const HomeCareScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('خدمات منزلية', style: TextStyle(fontWeight: FontWeight.bold))),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(14),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(gradient: const LinearGradient(colors: [AppColors.primary, AppColors.primaryDark]), borderRadius: BorderRadius.circular(16)),
            child: const Column(children: [Icon(Icons.home, color: Colors.white, size: 40), SizedBox(height: 8), Text('رعاية صحية في منزلك', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)), Text('خدمات طبية تصل إلى باب بيتك', style: TextStyle(color: Colors.white70, fontSize: 12))]),
          ),
          const SizedBox(height: 14),
          GridView.count(
            crossAxisCount: 2, shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), crossAxisSpacing: 10, mainAxisSpacing: 10, childAspectRatio: 0.9,
            children: [
              _card('👩‍⚕️', 'تمريض منزلي', 'رعاية تمريضية متكاملة', '200', 'ساعة', AppColors.primary),
              _card('💪', 'علاج طبيعي', 'جلسات إعادة تأهيل', '300', '45 دقيقة', AppColors.success),
              _card('🩺', 'فحص طبي', 'فحص سريري شامل', '150', '30 دقيقة', AppColors.info),
              _card('💉', 'سحب عينات', 'تحاليل منزلية', '100', '15 دقيقة', AppColors.error),
              _card('👴', 'رعاية مسنين', 'رعاية خاصة 24 ساعة', '500', 'يوم', AppColors.purple),
              _card('🤰', 'متابعة حمل', 'فحص دوري للحامل', '250', '40 دقيقة', AppColors.pink),
              _card('🩹', 'غيار جروح', 'عناية بالجروح', '120', '20 دقيقة', AppColors.warning),
              _card('🚚', 'توصيل أدوية', 'توصيل سريع', 'مجاناً', '30 دقيقة', AppColors.teal),
            ],
          ),
        ]),
      ),
    );
  }

  Widget _card(String icon, String name, String desc, String price, String duration, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 6)]),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(icon, style: const TextStyle(fontSize: 36)),
        const SizedBox(height: 6),
        Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
        Text(desc, style: const TextStyle(fontSize: 9, color: AppColors.grey)),
        const SizedBox(height: 4),
        Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: color.withOpacity(0.08), borderRadius: BorderRadius.circular(4)), child: Text('$price ر.س • $duration', style: TextStyle(fontSize: 9, color: color))),
      ]),
    );
  }
}
