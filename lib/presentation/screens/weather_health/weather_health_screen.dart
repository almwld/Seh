import 'package:flutter/material.dart';
import 'package:sehatak/core/constants/app_colors.dart';

class WeatherHealthScreen extends StatelessWidget {
  const WeatherHealthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('الطقس وصحتك', style: TextStyle(fontWeight: FontWeight.bold))),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(14),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // بطاقة الطقس
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(gradient: const LinearGradient(colors: [Color(0xFF4FC3F7), Color(0xFF0288D1)]), borderRadius: BorderRadius.circular(16)),
            child: Column(children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('صنعاء', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)), Text('اليوم، 1 مايو', style: TextStyle(color: Colors.white70, fontSize: 12))]),
                const Column(children: [Text('☀️', style: TextStyle(fontSize: 48)), Text('مشمس', style: TextStyle(color: Colors.white70, fontSize: 12))]),
              ]),
              const SizedBox(height: 10),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                _weatherStat('الحرارة', '28°', '🌡️'),
                _weatherStat('الرطوبة', '45%', '💧'),
                _weatherStat('الرياح', '12 كم/س', '💨'),
                _weatherStat('الأشعة', 'متوسط', '☀️'),
              ]),
            ]),
          ),
          const SizedBox(height: 16),
          // تأثير الطقس على الصحة
          Text('تأثير الطقس على صحتك', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          _healthTip('☀️', 'حرارة مرتفعة', 'اشرب الماء بكثرة وتجنب التعرض للشمس', AppColors.warning),
          _healthTip('💧', 'رطوبة منخفضة', 'استخدم مرطب البشرة واشرب السوائل', AppColors.info),
          _healthTip('🌿', 'حبوب لقاح متوسطة', 'مرضى الحساسية: تناول أدويتك الوقائية', AppColors.success),
          _healthTip('🦟', 'البعوض', 'استخدم طارد الحشرات في المساء', AppColors.error),
          const SizedBox(height: 16),
          // نصائح يومية
          Container(padding: const EdgeInsets.all(14), decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.04), borderRadius: BorderRadius.circular(14)), child: const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('💡 نصائح اليوم', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            SizedBox(height: 8),
            Text('• أفضل وقت للرياضة: قبل 10 صباحاً أو بعد 5 مساءً', style: TextStyle(fontSize: 12)),
            Text('• ارتدِ ملابس قطنية فاتحة اللون', style: TextStyle(fontSize: 12)),
            Text('• احمل زجاجة ماء معك دائماً', style: TextStyle(fontSize: 12)),
            Text('• ضع واقي شمس قبل الخروج بـ 30 دقيقة', style: TextStyle(fontSize: 12)),
          ])),
        ]),
      ),
    );
  }

  Widget _weatherStat(String label, String value, String emoji) {
    return Column(children: [Text(emoji, style: const TextStyle(fontSize: 20)), const SizedBox(height: 2), Text(value, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)), Text(label, style: const TextStyle(color: Colors.white60, fontSize: 9))]);
  }

  Widget _healthTip(String emoji, String title, String desc, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: color.withOpacity(0.05), borderRadius: BorderRadius.circular(10), border: Border.all(color: color.withOpacity(0.15))),
      child: Row(children: [Text(emoji, style: const TextStyle(fontSize: 24)), const SizedBox(width: 10), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: color)), Text(desc, style: const TextStyle(fontSize: 11, color: AppColors.darkGrey))]))]),
    );
  }
}
