import 'package:flutter/material.dart';
import 'package:sehatak/core/constants/app_colors.dart';

class PersonalMedicScreen extends StatefulWidget {
  const PersonalMedicScreen({super.key});
  @override
  State<PersonalMedicScreen> createState() => _PersonalMedicScreenState();
}

class _PersonalMedicScreenState extends State<PersonalMedicScreen> {
  final List<Map<String, String>> _messages = [
    {'role': 'assistant', 'text': 'مرحباً! أنا مسعفك الشخصي. كيف يمكنني مساعدتك؟'},
  ];
  final TextEditingController _controller = TextEditingController();

  String _reply(String q) {
    if (q.contains('صداع')) return 'خذ قسطاً من الراحة. ضع كمادات باردة. اشرب الماء. راجع الطبيب إذا استمر.';
    if (q.contains('جرح')) return 'اغسل الجرح بماء نظيف. اضغط لوقف النزيف. طهره وغطه بضمادة.';
    if (q.contains('حرق')) return 'ضع تحت ماء بارد 20 دقيقة. لا تضع معجون أسنان. غط بضمادة معقمة.';
    if (q.contains('حمى')) return 'قس حرارتك. اشرب سوائل. خذ باراسيتامول فوق 38.5. راجع طبيب إذا استمرت 3 أيام.';
    if (q.contains('إسهال')) return 'اشرب محاليل الجفاف. تجنب الألبان. كل الموز والأرز. راجع طبيب بعد يومين.';
    if (q.contains('تقيؤ')) return 'توقف عن الأكل ساعتين. ابدأ برشفات ماء. تناول البسكويت المالح.';
    if (q.contains('حساسية')) return 'تجنب المسبب. خذ مضاد هيستامين. إذا تورم الوجه أو صعوبة تنفس: اتجه للطوارئ!';
    if (q.contains('لدغة')) return 'اغسل المكان. ضع كمادات باردة. لا تحك. راقب علامات التحسس.';
    return 'يرجى استشارة الطبيب للتشخيص الدقيق.';
  }

  void _ask(String q) {
    setState(() => _messages.add({'role': 'user', 'text': q}));
    _controller.clear();
    Future.delayed(const Duration(seconds: 1), () {
      setState(() => _messages.add({'role': 'assistant', 'text': _reply(q)}));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('المسعف الشخصي'), backgroundColor: AppColors.teal, foregroundColor: Colors.white),
      body: Column(children: [
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: _messages.length,
            itemBuilder: (context, i) {
              final m = _messages[i];
              final isUser = m['role'] == 'user';
              return Align(
                alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                child: Container(
                  margin: const EdgeInsets.only(bottom: 8), padding: const EdgeInsets.all(12),
                  constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.78),
                  decoration: BoxDecoration(color: isUser ? AppColors.teal : AppColors.surfaceContainerLow, borderRadius: BorderRadius.circular(12)),
                  child: Text(m['text']!, style: TextStyle(color: isUser ? Colors.white : Colors.black87, fontSize: 12)),
                ),
              );
            },
          ),
        ),
        Container(
          height: 45, padding: const EdgeInsets.symmetric(horizontal: 8),
          child: ListView(scrollDirection: Axis.horizontal, children: ['صداع','جرح','حرق','حمى','إسهال','تقيؤ','حساسية','لدغة'].map((k) => Padding(padding: const EdgeInsets.only(right: 6), child: ActionChip(label: Text(k, style: const TextStyle(fontSize: 10)), onPressed: () => _ask(k)))).toList()),
        ),
        Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 4)]), child: Row(children: [
          Expanded(child: TextField(controller: _controller, textAlign: TextAlign.right, decoration: InputDecoration(hintText: 'صف حالتك...', filled: true, fillColor: AppColors.surfaceContainerLow, border: OutlineInputBorder(borderRadius: BorderRadius.circular(24), borderSide: BorderSide.none), contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8)))),
          const SizedBox(width: 4),
          CircleAvatar(backgroundColor: AppColors.teal, child: IconButton(icon: const Icon(Icons.send, color: Colors.white, size: 16), onPressed: () => _controller.text.isNotEmpty ? _ask(_controller.text) : null)),
        ])),
      ]),
    );
  }
}
