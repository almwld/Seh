import 'package:flutter/material.dart';
import 'package:sehatak/core/constants/app_colors.dart';
import 'package:sehatak/presentation/screens/vision_test/vision_test_screen.dart';

class EyeCareScreen extends StatefulWidget {
  const EyeCareScreen({super.key});
  @override
  State<EyeCareScreen> createState() => _EyeCareScreenState();
}

class _EyeCareScreenState extends State<EyeCareScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('طب العيون 👁️', style: TextStyle(fontWeight: FontWeight.bold))),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(14),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // بطاقة ترحيبية
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.indigo.shade300, Colors.indigo.shade700]), borderRadius: BorderRadius.circular(16)),
            child: Column(children: [
              const Text('👁️', style: TextStyle(fontSize: 56)),
              const SizedBox(height: 8),
              const Text('صحة عيونك', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
              const Text('الفحص الدوري يحمي بصرك', style: TextStyle(color: Colors.white70, fontSize: 13)),
              const SizedBox(height: 12),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                _eyeStat('رؤية', '6/6', 'ممتازة'),
                _eyeStat('ضغط', '14', 'طبيعي'),
                _eyeStat('فحص', 'مايو 2026', 'القادم'),
              ]),
            ]),
          ),
          const SizedBox(height: 20),

          // ========== اختبارات العين ==========
          Text('اختبارات العين', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          _testCard(
            'اختبار حدة البصر',
            'اختبر قوة نظرك واكتشف إذا كنت بحاجة لنظارة',
            '👁️',
            AppColors.primary,
            Icons.visibility,
            '3 دقائق',
            () => Navigator.push(context, MaterialPageRoute(builder: (_) => const VisionTestScreen())),
          ),
          _testCard(
            'اختبار عمى الألوان',
            'اكتشف إذا كنت تعاني من صعوبة في تمييز الألوان',
            '🎨',
            AppColors.purple,
            Icons.palette,
            '2 دقيقة',
            () => _startColorBlindTest(),
          ),
          _testCard(
            'اختبار الاستجماتيزم',
            'فحص سريع للانحراف البصري (Astigmatism)',
            '🔍',
            AppColors.info,
            Icons.blur_on,
            '1 دقيقة',
            () => _startAstigmatismTest(),
          ),
          _testCard(
            'فحص المجال البصري',
            'اختبر مدى الرؤية المحيطية لعينيك',
            '👀',
            AppColors.warning,
            Icons.panorama_fish_eye,
            '2 دقيقة',
            () => _startVisualFieldTest(),
          ),
          _testCard(
            'فحص جفاف العين',
            'اكتشف إذا كنت تعاني من متلازمة جفاف العين',
            '💧',
            AppColors.teal,
            Icons.water_drop,
            '1 دقيقة',
            () => _startDryEyeTest(),
          ),
          const SizedBox(height: 20),

          // ========== خدمات العيون ==========
          Text('خدمات العيون', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          GridView.count(crossAxisCount: 2, shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), crossAxisSpacing: 10, mainAxisSpacing: 10, childAspectRatio: 1.2,
            children: [
              _serviceCard('فحص شامل', 'فحص كامل للعين', '🩺', AppColors.primary),
              _serviceCard('نظارات طبية', 'عدسات وإطارات', '👓', AppColors.success),
              _serviceCard('عدسات لاصقة', 'يومية وشهرية', '🔵', AppColors.info),
              _serviceCard('جراحة ليزك', 'تصحيح البصر', '⚡', AppColors.warning),
              _serviceCard('علاج مياه', 'الجلوكوما', '💧', AppColors.teal),
              _serviceCard('شبكية', 'فحص الشبكية', '📸', AppColors.purple),
            ],
          ),
          const SizedBox(height: 20),

          // ========== نصائح ==========
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.indigo.shade50, borderRadius: BorderRadius.circular(14)),
            child: const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('👓 نصائح للعناية بالعيون', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              SizedBox(height: 10),
              _TipRow('قاعدة 20-20-20', 'كل 20 دقيقة، انظر لمسافة 20 قدماً لمدة 20 ثانية'),
              _TipRow('نظارات شمسية', 'ارتدِ نظارات واقية من الأشعة فوق البنفسجية'),
              _TipRow('إضاءة مناسبة', 'حافظ على إضاءة جيدة عند القراءة'),
              _TipRow('تغذية', 'تناول أطعمة غنية بفيتامين A والأوميغا 3'),
              _TipRow('فحص دوري', 'افحص عينيك سنوياً عند طبيب العيون'),
              _TipRow('شاشات', 'خفف سطوع الشاشات واستخدم الوضع الليلي'),
            ]),
          ),
        ]),
      ),
    );
  }

  Widget _eyeStat(String label, String value, String status) {
    return Column(children: [
      Text(value, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
      Text(label, style: const TextStyle(color: Colors.white60, fontSize: 10)),
      Text(status, style: const TextStyle(color: Colors.white70, fontSize: 9)),
    ]);
  }

  Widget _testCard(String title, String desc, String emoji, Color color, IconData icon, String duration, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 6)]),
        child: Row(children: [
          Container(width: 50, height: 50, decoration: BoxDecoration(color: color.withOpacity(0.08), borderRadius: BorderRadius.circular(12)), child: Center(child: Text(emoji, style: const TextStyle(fontSize: 28)))),
          const SizedBox(width: 12),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            Text(desc, style: const TextStyle(fontSize: 10, color: AppColors.grey, height: 1.3)),
            Row(children: [Icon(Icons.timer, size: 12, color: color), const SizedBox(width: 4), Text(duration, style: TextStyle(fontSize: 10, color: color))]),
          ])),
          const Icon(Icons.play_circle_fill, color: AppColors.primary, size: 32),
        ]),
      ),
    );
  }

  Widget _serviceCard(String title, String desc, String emoji, Color color) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 6)]),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(emoji, style: const TextStyle(fontSize: 36)),
        const SizedBox(height: 6),
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
        Text(desc, style: const TextStyle(fontSize: 9, color: AppColors.grey)),
      ]),
    );
  }

  // ========== اختبار عمى الألوان ==========
  void _startColorBlindTest() {
    int score = 0;
    final List<Map<String, String>> plates = [
      {'plate': '🟢🔴🟢', 'answer': '3', 'question': 'كم عدد الدوائر الخضراء؟'},
      {'plate': '🔵🟡🔵🟡🔵', 'answer': '3', 'question': 'كم عدد الدوائر الزرقاء؟'},
      {'plate': '🟠🟤🟠🟤🟠🟤', 'answer': '3', 'question': 'كم عدد الدوائر البرتقالية؟'},
      {'plate': '🟣🔵🟣🔵', 'answer': '2', 'question': 'كم عدد الدوائر البنفسجية؟'},
      {'plate': '🔴🟢🔴🟢🔴', 'answer': '3', 'question': 'كم عدد الدوائر الحمراء؟'},
    ];

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setDialogState) {
          int current = 0;
          String? selected;
          
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            title: Text('سؤال ${current + 1}/${plates.length}'),
            content: Column(mainAxisSize: MainAxisSize.min, children: [
              Text(plates[current]['question']!, style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 12),
              Text(plates[current]['plate']!, style: const TextStyle(fontSize: 48)),
              const SizedBox(height: 12),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: ['1', '2', '3', '4', '5'].map((n) => ChoiceChip(
                label: Text(n),
                selected: selected == n,
                selectedColor: AppColors.primary,
                onSelected: (v) => setDialogState(() => selected = n),
              )).toList()),
            ]),
            actions: [
              TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('خروج')),
              ElevatedButton(onPressed: () {
                if (selected == plates[current]['answer']) score++;
                if (current < plates.length - 1) {
                  setDialogState(() { current++; selected = null; });
                } else {
                  Navigator.pop(ctx);
                  _showColorBlindResult(score, plates.length);
                }
              }, child: Text(current < plates.length - 1 ? 'التالي' : 'النتيجة')),
            ],
          );
        },
      ),
    );
  }

  void _showColorBlindResult(int score, int total) {
    final pass = score >= 4;
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        icon: Icon(pass ? Icons.check_circle : Icons.warning, color: pass ? AppColors.success : AppColors.warning, size: 56),
        title: Text(pass ? 'طبيعي' : 'يحتاج فحص'),
        content: Text('النتيجة: $score/$total\n${pass ? "لا توجد علامات لعمى الألوان" : "ننصح بزيارة طبيب العيون"}'),
        actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('حسناً'))],
      ),
    );
  }

  // ========== اختبار الاستجماتيزم ==========
  void _startAstigmatismTest() {
    int score = 0;
    final questions = [
      {'q': 'هل ترى خطوطاً مشوشة أو مزدوجة؟', 'weight': 2},
      {'q': 'هل تعاني من صداع بعد القراءة؟', 'weight': 1},
      {'q': 'هل تغمض عينيك جزئياً للرؤية بوضوح؟', 'weight': 2},
      {'q': 'هل تجد صعوبة في القيادة ليلاً؟', 'weight': 2},
      {'q': 'هل تشعر بإجهاد في العين سريعاً؟', 'weight': 1},
    ];

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setDialogState) {
          int current = 0;
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            title: Text('سؤال ${current + 1}/${questions.length}'),
            content: Text((questions[current]['q'] as String), style: const TextStyle(fontSize: 15)),
            actions: [
              TextButton(onPressed: () { if (current < questions.length - 1) { setDialogState(() => current++); } else { Navigator.pop(ctx); _showAstigmatismResult(score); } }, child: const Text('لا')),
              ElevatedButton(onPressed: () { score += questions[current]['weight'] as int; if (current < questions.length - 1) { setDialogState(() => current++); } else { Navigator.pop(ctx); _showAstigmatismResult(score); } }, style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary), child: const Text('نعم')),
            ],
          );
        },
      ),
    );
  }

  void _showAstigmatismResult(int score) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        icon: Icon(score >= 4 ? Icons.warning : Icons.check_circle, color: score >= 4 ? AppColors.warning : AppColors.success, size: 56),
        title: Text(score >= 4 ? 'احتمال استجماتيزم' : 'طبيعي'),
        content: Text(score >= 4 ? 'ننصح بزيارة طبيب العيون للفحص' : 'لا تظهر علامات استجماتيزم'),
        actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('حسناً'))],
      ),
    );
  }

  // ========== اختبار المجال البصري ==========
  void _startVisualFieldTest() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('اختبار المجال البصري'),
        content: const Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('ركز على النقطة المركزية 👁️', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          SizedBox(height: 12),
          Text('• غطِّ عينك اليسرى بيدك'),
          Text('• ركز على النقطة الحمراء أدناه'),
          Text('• هل ترى كل المربعات بوضوح؟'),
          Text('• كرر مع العين اليسرى'),
        ]),
        actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('حسناً'))],
      ),
    );
  }

  // ========== اختبار جفاف العين ==========
  void _startDryEyeTest() {
    int score = 0;
    final questions = [
      {'q': 'هل تشعر بحرقة أو حكة في العين؟', 'weight': 2},
      {'q': 'هل تشعر بوجود رمل في عينيك؟', 'weight': 2},
      {'q': 'هل تدمع عيناك بشكل مفرط؟', 'weight': 1},
      {'q': 'هل تشعر بجفاف بعد استخدام الشاشات؟', 'weight': 2},
      {'q': 'هل تستخدم قطرات مرطبة باستمرار؟', 'weight': 1},
    ];

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setDialogState) {
          int current = 0;
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            title: Text('سؤال ${current + 1}/${questions.length}'),
            content: Text((questions[current]['q'] as String), style: const TextStyle(fontSize: 15)),
            actions: [
              TextButton(onPressed: () { if (current < questions.length - 1) { setDialogState(() => current++); } else { Navigator.pop(ctx); _showDryEyeResult(score); } }, child: const Text('لا')),
              ElevatedButton(onPressed: () { score += questions[current]['weight'] as int; if (current < questions.length - 1) { setDialogState(() => current++); } else { Navigator.pop(ctx); _showDryEyeResult(score); } }, style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary), child: const Text('نعم')),
            ],
          );
        },
      ),
    );
  }

  void _showDryEyeResult(int score) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        icon: Icon(score >= 4 ? Icons.water_drop : Icons.check_circle, color: score >= 4 ? AppColors.teal : AppColors.success, size: 56),
        title: Text(score >= 4 ? 'احتمال جفاف العين' : 'طبيعي'),
        content: Text(score >= 4 ? 'ننصح باستخدام قطرات مرطبة وزيارة الطبيب' : 'لا تظهر أعراض جفاف العين'),
        actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('حسناً'))],
      ),
    );
  }
}

class _TipRow extends StatelessWidget {
  final String title, desc;
  const _TipRow(this.title, this.desc);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('• ', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary)),
        Expanded(child: RichText(text: TextSpan(children: [TextSpan(text: '$title: ', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: AppColors.dark)), TextSpan(text: desc, style: const TextStyle(fontSize: 12, color: AppColors.darkGrey))]))),
      ]),
    );
  }
}
