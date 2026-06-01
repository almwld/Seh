import 'package:flutter/material.dart';
import 'package:sehatak/core/constants/app_colors.dart';

class DentalCareScreen extends StatefulWidget {
  const DentalCareScreen({super.key});
  @override
  State<DentalCareScreen> createState() => _DentalCareScreenState();
}

class _DentalCareScreenState extends State<DentalCareScreen> {
  final List<Map<String, dynamic>> _services = [
    {'name': 'فحص أسنان', 'price': '100', 'oldPrice': '150', 'discount': '33%', 'time': '30 دقيقة', 'icon': '🦷', 'color': AppColors.primary, 'desc': 'فحص شامل للأسنان واللثة', 'popular': false},
    {'name': 'تنظيف أسنان', 'price': '200', 'oldPrice': '280', 'discount': '28%', 'time': '45 دقيقة', 'icon': '🪥', 'color': AppColors.info, 'desc': 'إزالة الجير والتصبغات', 'popular': true},
    {'name': 'حشو عصب', 'price': '500', 'oldPrice': '650', 'discount': '23%', 'time': '60 دقيقة', 'icon': '🔧', 'color': AppColors.error, 'desc': 'علاج عصب الأسنان', 'popular': false},
    {'name': 'تقويم أسنان', 'price': '5000', 'oldPrice': '6500', 'discount': '23%', 'time': '12-18 شهر', 'icon': '😬', 'color': AppColors.purple, 'desc': 'تقويم معدني وشفاف', 'popular': false},
    {'name': 'تبييض أسنان', 'price': '800', 'oldPrice': '1100', 'discount': '27%', 'time': '45 دقيقة', 'icon': '✨', 'color': AppColors.amber, 'desc': 'تبييض بالليزر', 'popular': true},
    {'name': 'زراعة أسنان', 'price': '3000', 'oldPrice': '4000', 'discount': '25%', 'time': '3-6 أشهر', 'icon': '🏗️', 'color': AppColors.success, 'desc': 'زراعة أسنان دائمة', 'popular': false},
    {'name': 'خلع ضرس', 'price': '300', 'oldPrice': '400', 'discount': '25%', 'time': '30 دقيقة', 'icon': '🦷', 'color': AppColors.warning, 'desc': 'خلع عادي وجراحي', 'popular': false},
    {'name': 'تركيبات', 'price': '1500', 'oldPrice': '2000', 'discount': '25%', 'time': '3 جلسات', 'icon': '👄', 'color': AppColors.teal, 'desc': 'تيجان وجسور', 'popular': false},
    {'name': 'حشو تجميلي', 'price': '350', 'oldPrice': '450', 'discount': '22%', 'time': '40 دقيقة', 'icon': '💎', 'color': AppColors.primary, 'desc': 'حشوة بلون السن', 'popular': false},
    {'name': 'علاج لثة', 'price': '400', 'oldPrice': '550', 'discount': '27%', 'time': '45 دقيقة', 'icon': '🩹', 'color': AppColors.info, 'desc': 'علاج التهابات اللثة', 'popular': false},
  ];

  final List<Map<String, String>> _tips = const [
    {'title': 'نظف أسنانك مرتين يومياً', 'desc': 'استخدم فرشاة ناعمة ومعجون يحتوي على الفلورايد'},
    {'title': 'استخدم خيط الأسنان يومياً', 'desc': 'لإزالة البلاك بين الأسنان'},
    {'title': 'غير فرشاة أسنانك', 'desc': 'كل 3-4 أشهر أو عندما تتآكل الشعيرات'},
    {'title': 'زُر طبيب الأسنان دورياً', 'desc': 'كل 6 أشهر للفحص الدوري'},
    {'title': 'قلل من السكريات', 'desc': 'المشروبات الغازية والحلويات تضر الأسنان'},
    {'title': 'تجنب التدخين', 'desc': 'التدخين يسبب تصبغات وأمراض لثة'},
  ];

  String? _selectedService;
  String? _selectedDate;
  String? _selectedTime;

  void _bookService(Map<String, dynamic> service) {
    setState(() => _selectedService = service['name']);
    _showBookingSheet(service);
  }

  void _showBookingSheet(Map<String, dynamic> service) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (_) => StatefulBuilder(
        builder: (context, setSheetState) => Padding(
          padding: const EdgeInsets.all(20),
          child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
            Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(2)))),
            const SizedBox(height: 16),
            
            // الخدمة المختارة
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(gradient: LinearGradient(colors: [(service['color'] as Color).withOpacity(0.1), (service['color'] as Color).withOpacity(0.05)]), borderRadius: BorderRadius.circular(14)),
              child: Row(children: [
                Text(service['icon'], style: const TextStyle(fontSize: 40)),
                const SizedBox(width: 12),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(service['name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  Text(service['desc'], style: const TextStyle(fontSize: 11, color: AppColors.grey)),
                  Row(children: [
                    Text('${service['price']} ر.س', style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary, fontSize: 20)),
                    const SizedBox(width: 8),
                    Text('${service['oldPrice']} ر.س', style: const TextStyle(fontSize: 12, color: AppColors.grey, decoration: TextDecoration.lineThrough)),
                    const SizedBox(width: 8),
                    Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: AppColors.success.withOpacity(0.1), borderRadius: BorderRadius.circular(4)), child: Text('خصم ${service['discount']}', style: const TextStyle(fontSize: 9, color: AppColors.success))),
                  ]),
                ])),
              ]),
            ),
            const SizedBox(height: 18),

            // اختيار التاريخ
            Text('اختر التاريخ', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            SizedBox(
              height: 70,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: 7,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, i) {
                  final date = DateTime.now().add(Duration(days: i + 1));
                  final dateStr = '${date.day}/${date.month}';
                  final selected = _selectedDate == dateStr;
                  final days = ['أحد', 'إثنين', 'ثلاثاء', 'أربعاء', 'خميس', 'جمعة', 'سبت'];
                  return GestureDetector(
                    onTap: () => setSheetState(() => _selectedDate = dateStr),
                    child: Container(
                      width: 65,
                      decoration: BoxDecoration(color: selected ? AppColors.primary : Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: selected ? AppColors.primary : AppColors.outlineVariant)),
                      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                        Text(days[date.weekday - 1], style: TextStyle(fontSize: 9, color: selected ? Colors.white : AppColors.grey)),
                        Text('${date.day}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: selected ? Colors.white : AppColors.dark)),
                        Text(_getMonth(date.month), style: TextStyle(fontSize: 9, color: selected ? Colors.white70 : AppColors.grey)),
                      ]),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 14),

            // اختيار الوقت
            Text('اختر الوقت', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Wrap(spacing: 8, runSpacing: 8, children: ['9:00 ص', '10:00 ص', '11:00 ص', '1:00 م', '2:00 م', '3:00 م', '4:00 م', '5:00 م'].map((t) => ChoiceChip(
              label: Text(t, style: const TextStyle(fontSize: 11)),
              selected: _selectedTime == t,
              selectedColor: AppColors.primary,
              labelStyle: TextStyle(color: _selectedTime == t ? Colors.white : AppColors.darkGrey),
              onSelected: (v) => setSheetState(() => _selectedTime = v! ? t : null),
            )).toList()),
            const SizedBox(height: 20),

            // زر الحجز
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: (_selectedDate != null && _selectedTime != null) ? () {
                  Navigator.pop(context);
                  _showSuccessDialog(service);
                } : null,
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, padding: const EdgeInsets.symmetric(vertical: 14), disabledBackgroundColor: AppColors.grey.withOpacity(0.3)),
                child: const Text('تأكيد الحجز', style: TextStyle(fontSize: 16)),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  void _showSuccessDialog(Map<String, dynamic> service) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        icon: const Icon(Icons.check_circle, color: AppColors.success, size: 60),
        title: const Text('تم الحجز بنجاح!'),
        content: Column(mainAxisSize: MainAxisSize.min, children: [
          Text('${service['name']} - ${service['price']} ر.س', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 4),
          Text('$_selectedDate الساعة $_selectedTime', style: const TextStyle(color: AppColors.primary)),
          const SizedBox(height: 8),
          Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: AppColors.info.withOpacity(0.05), borderRadius: BorderRadius.circular(10)), child: const Row(children: [Icon(Icons.info, color: AppColors.info, size: 16), SizedBox(width: 6), Expanded(child: Text('سيصلك تأكيد الحجز عبر التطبيق', style: TextStyle(fontSize: 10, color: AppColors.darkGrey)))])),
        ]),
        actions: [TextButton(onPressed: () { Navigator.pop(context); setState(() { _selectedDate = null; _selectedTime = null; }); }, child: const Text('حسناً'))],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('طب الأسنان 🦷', style: TextStyle(fontWeight: FontWeight.bold)), actions: [IconButton(icon: const Icon(Icons.calendar_month), onPressed: () {})]),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(14),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // بطاقة ترحيبية
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.blue.shade200, Colors.blue.shade700]), borderRadius: BorderRadius.circular(16)),
            child: const Row(children: [
              Text('🦷', style: TextStyle(fontSize: 52)),
              SizedBox(width: 12),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('صحة أسنانك', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                Text('ابتسامة صحية = ثقة أكبر', style: TextStyle(color: Colors.white70, fontSize: 13)),
                SizedBox(height: 8),
                Text('🎁 خصم يصل إلى 33% على جميع الخدمات', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500)),
              ])),
            ]),
          ),
          const SizedBox(height: 18),

          // إحصائيات سريعة
          Row(children: [
            _statCard('10', 'خدمة', Icons.medical_services, AppColors.primary),
            const SizedBox(width: 8),
            _statCard('خصم', '33%', Icons.discount, AppColors.success),
            const SizedBox(width: 8),
            _statCard('تقييم', '4.8', Icons.star, AppColors.amber),
          ]),
          const SizedBox(height: 18),

          // الخدمات
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text('خدماتنا', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            TextButton(onPressed: () {}, child: const Text('عرض الكل ›')),
          ]),
          const SizedBox(height: 8),
          ..._services.map((s) => Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: s['popular'] ? Border.all(color: AppColors.amber, width: 2) : null,
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 6)],
            ),
            child: Row(children: [
              Container(width: 50, height: 50, decoration: BoxDecoration(color: (s['color'] as Color).withOpacity(0.08), borderRadius: BorderRadius.circular(12)), child: Center(child: Text(s['icon'], style: const TextStyle(fontSize: 28)))),
              const SizedBox(width: 12),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(children: [
                  Expanded(child: Text(s['name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15))),
                  if (s['popular']) Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: AppColors.amber, borderRadius: BorderRadius.circular(4)), child: const Text('🔥 الأكثر طلباً', style: TextStyle(fontSize: 8, color: Colors.white))),
                ]),
                Text(s['desc'], style: const TextStyle(fontSize: 10, color: AppColors.grey)),
                Row(children: [
                  Text('${s['price']} ر.س', style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary, fontSize: 16)),
                  const SizedBox(width: 6),
                  Text('${s['oldPrice']} ر.س', style: const TextStyle(fontSize: 10, color: AppColors.grey, decoration: TextDecoration.lineThrough)),
                  const SizedBox(width: 6),
                  Text('⏱ ${s['time']}', style: const TextStyle(fontSize: 9, color: AppColors.darkGrey)),
                ]),
              ])),
              ElevatedButton(onPressed: () => _bookService(s), style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10)), child: const Text('احجز', style: TextStyle(fontSize: 12))),
            ]),
          )),
          const SizedBox(height: 18),

          // نصائح
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(14)),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text('🪥 نصائح للعناية بالأسنان', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 8),
              ..._tips.map((t) => Padding(padding: const EdgeInsets.only(bottom: 6), child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [const Text('• ', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary)), Expanded(child: RichText(text: TextSpan(children: [TextSpan(text: '${t['title']}: ', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: AppColors.dark)), TextSpan(text: t['desc']!, style: const TextStyle(fontSize: 12, color: AppColors.darkGrey))])))]))),
            ]),
          ),
        ]),
      ),
    );
  }

  Widget _statCard(String label, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: color.withOpacity(0.06), borderRadius: BorderRadius.circular(12)), child: Row(children: [Icon(icon, color: color, size: 20), const SizedBox(width: 8), Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(value, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: color)), Text(label, style: const TextStyle(fontSize: 9, color: AppColors.grey))])])),
    );
  }

  String _getMonth(int m) {
    const months = ['', 'يناير', 'فبراير', 'مارس', 'إبريل', 'مايو', 'يونيو', 'يوليو', 'أغسطس', 'سبتمبر', 'أكتوبر', 'نوفمبر', 'ديسمبر'];
    return months[m];
  }
}
