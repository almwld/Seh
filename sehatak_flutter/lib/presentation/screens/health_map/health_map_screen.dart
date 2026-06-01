import 'package:flutter/material.dart';
import 'package:sehatak/core/constants/app_colors.dart';

class HealthMapScreen extends StatefulWidget {
  const HealthMapScreen({super.key});
  @override
  State<HealthMapScreen> createState() => _HealthMapScreenState();
}

class _HealthMapScreenState extends State<HealthMapScreen> {
  String _selectedCategory = 'الكل';

  final List<Map<String, dynamic>> _facilities = [
    // مستشفيات
    {'name': 'مستشفى الثورة العام', 'category': 'مستشفيات', 'address': 'شارع الزبيري، باب اليمن', 'rating': 4.5, 'beds': '500', 'emergency': true, 'phone': '01-222222', 'image': 'https://images.unsplash.com/photo-1587351021759-3e4f1a3c3c3c?w=400', 'icon': '🏥', 'color': AppColors.error},
    {'name': 'مستشفى الكويت الجامعي', 'category': 'مستشفيات', 'address': 'شارع الخمسين، الحصبة', 'rating': 4.7, 'beds': '400', 'emergency': true, 'phone': '01-333333', 'image': 'https://images.unsplash.com/photo-1519494026892-80bbd2d6fd0d?w=400', 'icon': '🏥', 'color': AppColors.error},
    {'name': 'مستشفى السبعين', 'category': 'مستشفيات', 'address': 'السبعين، شارع الأربعين', 'rating': 4.3, 'beds': '300', 'emergency': true, 'phone': '01-444444', 'image': 'https://images.unsplash.com/photo-1538108149393-fbbd81895907?w=400', 'icon': '🏥', 'color': AppColors.error},
    {'name': 'مستشفى آزال', 'category': 'مستشفيات', 'address': 'شارع هائل، التحرير', 'rating': 4.2, 'beds': '150', 'emergency': true, 'phone': '01-555555', 'image': 'https://images.unsplash.com/photo-1586773860418-d37222d8fce3?w=400', 'icon': '🏥', 'color': AppColors.error},
    
    // صيدليات
    {'name': 'صيدلية الشفاء', 'category': 'صيدليات', 'address': 'شارع الزبيري، أمام مستشفى الثورة', 'rating': 4.6, 'hours': '24 ساعة', 'delivery': true, 'phone': '01-123456', 'image': 'https://images.unsplash.com/photo-1585435557343-3b092031a831?w=400', 'icon': '💊', 'color': AppColors.success},
    {'name': 'صيدلية الأمل', 'category': 'صيدليات', 'address': 'شارع هائل، أمام جامعة صنعاء', 'rating': 4.4, 'hours': '24 ساعة', 'delivery': true, 'phone': '01-345678', 'image': 'https://images.unsplash.com/photo-1550572012-edd7b1a7b51c?w=400', 'icon': '💊', 'color': AppColors.success},
    {'name': 'صيدلية الحياة', 'category': 'صيدليات', 'address': 'شارع الزبيري، عمارة النعمان', 'rating': 4.5, 'hours': '24 ساعة', 'delivery': true, 'phone': '01-789012', 'image': 'https://images.unsplash.com/photo-1586015555751-63e2b2f5a25b?w=400', 'icon': '💊', 'color': AppColors.success},
    
    // مختبرات
    {'name': 'المختبر الوطني', 'category': 'مختبرات', 'address': 'شارع الستين، أمام المستشفى العسكري', 'rating': 4.8, 'tests': '650+', 'homeService': true, 'phone': '01-012345', 'image': 'https://images.unsplash.com/photo-1581595220892-b0739db3ba8c?w=400', 'icon': '🔬', 'color': AppColors.info},
    {'name': 'مختبر الثقة', 'category': 'مختبرات', 'address': 'شارع الزبيري، عمارة النعمان', 'rating': 4.7, 'tests': '520+', 'homeService': true, 'phone': '01-123456', 'image': 'https://images.unsplash.com/photo-1579154204601-01588f351e67?w=400', 'icon': '🔬', 'color': AppColors.info},
    {'name': 'مختبر البرج', 'category': 'مختبرات', 'address': 'شارع هائل، جولة كنتاكي', 'rating': 4.6, 'tests': '480+', 'homeService': false, 'phone': '01-234567', 'image': 'https://images.unsplash.com/photo-1583911860205-72f8ac8dee0e?w=400', 'icon': '🔬', 'color': AppColors.info},
    
    // عيادات
    {'name': 'مجمع السلام الطبي', 'category': 'عيادات', 'address': 'شارع الزبيري، بجانب برج زبيدة', 'rating': 4.7, 'specialties': 'عام، أسنان، جلدية', 'phone': '01-456123', 'image': 'https://images.unsplash.com/photo-1629909613654-28e377c37b09?w=400', 'icon': '🏨', 'color': AppColors.purple},
    {'name': 'مركز ابن سينا', 'category': 'عيادات', 'address': 'شارع هائل، أمام البريد', 'rating': 4.8, 'specialties': 'باطنية، قلب، عظام', 'phone': '01-567234', 'image': 'https://images.unsplash.com/photo-1632833239869-a37e7a58066e?w=400', 'icon': '🏨', 'color': AppColors.purple},
    
    // مراكز طبية
    {'name': 'مركز اليمن الدولي', 'category': 'مراكز طبية', 'address': 'شارع الستين، تقاطع هائل', 'rating': 4.6, 'specialties': 'عيون، أعصاب، مسالك', 'phone': '01-789456', 'image': 'https://images.unsplash.com/photo-1519494026892-80bbd2d6fd0d?w=400', 'icon': '🏪', 'color': AppColors.teal},
    {'name': 'مركز الأشعة المتقدم', 'category': 'مراكز طبية', 'address': 'شارع الخمسين، مدينة النور', 'rating': 4.7, 'specialties': 'أشعة، تصوير', 'phone': '01-890123', 'image': 'https://images.unsplash.com/photo-1538108149393-fbbd81895907?w=400', 'icon': '🏪', 'color': AppColors.teal},
  ];

  List<Map<String, dynamic>> get _filtered {
    if (_selectedCategory == 'الكل') return _facilities;
    return _facilities.where((f) => f['category'] == _selectedCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filtered;
    return Scaffold(
      appBar: AppBar(
        title: const Text('خرائط المرافق الصحية 🗺️', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [IconButton(icon: const Icon(Icons.map), onPressed: () {}), IconButton(icon: const Icon(Icons.search), onPressed: () {})],
      ),
      body: Column(children: [
        // تصنيفات
        SizedBox(
          height: 45,
          child: ListView.separated(
            scrollDirection: Axis.horizontal, padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            itemCount: ['الكل', 'مستشفيات', 'صيدليات', 'مختبرات', 'عيادات', 'مراكز طبية'].length,
            separatorBuilder: (_, __) => const SizedBox(width: 6),
            itemBuilder: (context, i) {
              final cat = ['الكل', 'مستشفيات', 'صيدليات', 'مختبرات', 'عيادات', 'مراكز طبية'][i];
              final selected = _selectedCategory == cat;
              return ChoiceChip(label: Text(cat, style: const TextStyle(fontSize: 11)), selected: selected, selectedColor: AppColors.primary, labelStyle: TextStyle(color: selected ? Colors.white : AppColors.darkGrey), onSelected: (v) => setState(() => _selectedCategory = v! ? cat : 'الكل'));
            },
          ),
        ),
        const Divider(height: 1),
        // النتائج
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: filtered.length,
            itemBuilder: (context, idx) {
              final f = filtered[idx];
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8)]),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  // صورة
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                    child: Stack(children: [
                      Container(
                        height: 120,
                        width: double.infinity,
                        color: (f['color'] as Color).withOpacity(0.1),
                        child: f['image'] != null
                            ? Image.network(f['image'], fit: BoxFit.cover, errorBuilder: (_, __, ___) => Center(child: Text(f['icon'], style: const TextStyle(fontSize: 50))))
                            : Center(child: Text(f['icon'], style: const TextStyle(fontSize: 50))),
                      ),
                      Positioned(top: 8, right: 8, child: Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(8)), child: Text(f['category'], style: const TextStyle(color: Colors.white, fontSize: 10)))),
                      Positioned(top: 8, left: 8, child: Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: AppColors.amber, borderRadius: BorderRadius.circular(8)), child: Row(children: [const Icon(Icons.star, color: Colors.white, size: 12), const SizedBox(width: 2), Text('${f['rating']}', style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold))]))),
                    ]),
                  ),
                  // معلومات
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Row(children: [
                        Text(f['icon'], style: const TextStyle(fontSize: 22)),
                        const SizedBox(width: 8),
                        Expanded(child: Text(f['name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15))),
                      ]),
                      const SizedBox(height: 4),
                      Row(children: [const Icon(Icons.location_on, size: 14, color: AppColors.grey), const SizedBox(width: 4), Expanded(child: Text(f['address'], style: const TextStyle(fontSize: 11, color: AppColors.grey)))]),
                      const SizedBox(height: 6),
                      // تفاصيل حسب النوع
                      if (f['category'] == 'مستشفيات') Row(children: [_tag('${f['beds']} سرير', AppColors.primary), const SizedBox(width: 6), if (f['emergency']) _tag('طوارئ 24 ساعة', AppColors.error)]),
                      if (f['category'] == 'صيدليات') Row(children: [_tag(f['hours'], AppColors.success), const SizedBox(width: 6), if (f['delivery']) _tag('توصيل متاح', AppColors.info)]),
                      if (f['category'] == 'مختبرات') Row(children: [_tag('${f['tests']} فحص', AppColors.info), const SizedBox(width: 6), if (f['homeService']) _tag('خدمة منزلية', AppColors.success)]),
                      if (f['category'] == 'عيادات' || f['category'] == 'مراكز طبية') Text(f['specialties'], style: const TextStyle(fontSize: 11, color: AppColors.primary)),
                      const SizedBox(height: 10),
                      Row(children: [
                        Expanded(child: OutlinedButton.icon(onPressed: () {}, icon: const Icon(Icons.call, size: 14), label: Text(f['phone'], style: const TextStyle(fontSize: 11)), style: OutlinedButton.styleFrom(foregroundColor: AppColors.success, padding: const EdgeInsets.symmetric(vertical: 8)))),
                        const SizedBox(width: 8),
                        Expanded(child: ElevatedButton.icon(onPressed: () {}, icon: const Icon(Icons.navigation, size: 14), label: const Text('توجيه', style: TextStyle(fontSize: 11)), style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, padding: const EdgeInsets.symmetric(vertical: 8)))),
                      ]),
                    ]),
                  ),
                ]),
              );
            },
          ),
        ),
      ]),
    );
  }

  Widget _tag(String text, Color color) {
    return Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: color.withOpacity(0.08), borderRadius: BorderRadius.circular(4)), child: Text(text, style: TextStyle(fontSize: 9, color: color, fontWeight: FontWeight.w500)));
  }
}
