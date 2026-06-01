import 'package:flutter/material.dart';
import 'package:sehatak/core/constants/app_colors.dart';

class LabsListScreen extends StatefulWidget {
  const LabsListScreen({super.key});
  @override
  State<LabsListScreen> createState() => _LabsListScreenState();
}

class _LabsListScreenState extends State<LabsListScreen> {
  String _selectedCity = 'الكل';
  String _selectedCategory = 'الكل';

  final List<String> _cities = ['الكل', 'صنعاء', 'عدن', 'تعز', 'الحديدة', 'حضرموت'];
  final List<String> _categories = ['الكل', 'تحاليل دم', 'أشعة', 'هرمونات', 'فيروسات', 'وراثة'];

  final List<Map<String, dynamic>> _labs = [
    {'name': 'المختبر الوطني', 'city': 'صنعاء', 'rating': 4.8, 'tests': '650+', 'accredited': true, 'homeService': true, 'price': 'من 150 ر.س', 'time': '24 ساعة', 'image': '🔬', 'category': 'تحاليل دم'},
    {'name': 'مختبر الثقة', 'city': 'صنعاء', 'rating': 4.7, 'tests': '520+', 'accredited': true, 'homeService': true, 'price': 'من 120 ر.س', 'time': '8 ص - 10 م', 'image': '🧪', 'category': 'تحاليل دم'},
    {'name': 'مختبر البرج', 'city': 'عدن', 'rating': 4.6, 'tests': '480+', 'accredited': true, 'homeService': false, 'price': 'من 200 ر.س', 'time': '24 ساعة', 'image': '🔬', 'category': 'هرمونات'},
    {'name': 'مختبر اليقين', 'city': 'تعز', 'rating': 4.5, 'tests': '350+', 'accredited': true, 'homeService': true, 'price': 'من 100 ر.س', 'time': '9 ص - 9 م', 'image': '🧫', 'category': 'فيروسات'},
    {'name': 'معامل النخبة', 'city': 'صنعاء', 'rating': 4.9, 'tests': '700+', 'accredited': true, 'homeService': true, 'price': 'من 250 ر.س', 'time': '24 ساعة', 'image': '🩸', 'category': 'وراثة'},
    {'name': 'مركز الأشعة المتقدم', 'city': 'صنعاء', 'rating': 4.7, 'tests': '200+', 'accredited': true, 'homeService': false, 'price': 'من 300 ر.س', 'time': '8 ص - 8 م', 'image': '🩻', 'category': 'أشعة'},
    {'name': 'مختبرات الحياة', 'city': 'الحديدة', 'rating': 4.4, 'tests': '300+', 'accredited': false, 'homeService': true, 'price': 'من 80 ر.س', 'time': '10 ص - 10 م', 'image': '🔬', 'category': 'تحاليل دم'},
    {'name': 'مختبر حضرموت', 'city': 'حضرموت', 'rating': 4.6, 'tests': '400+', 'accredited': true, 'homeService': true, 'price': 'من 180 ر.س', 'time': '24 ساعة', 'image': '🧪', 'category': 'هرمونات'},
  ];

  List<Map<String, dynamic>> get _filteredLabs {
    var labs = _labs;
    if (_selectedCity != 'الكل') labs = labs.where((l) => l['city'] == _selectedCity).toList();
    if (_selectedCategory != 'الكل') labs = labs.where((l) => l['category'] == _selectedCategory).toList();
    return labs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('المختبرات والتحاليل', style: TextStyle(fontWeight: FontWeight.bold)), actions: [IconButton(icon: const Icon(Icons.filter_list), onPressed: () {})]),
      body: Column(children: [
        // تصنيفات
        SizedBox(
          height: 42,
          child: ListView.separated(
            scrollDirection: Axis.horizontal, padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            itemCount: _categories.length, separatorBuilder: (_, __) => const SizedBox(width: 4),
            itemBuilder: (context, index) {
              final c = _categories[index];
              final selected = _selectedCategory == c;
              return ChoiceChip(label: Text(c, style: const TextStyle(fontSize: 10)), selected: selected, selectedColor: AppColors.primary, labelStyle: TextStyle(color: selected ? Colors.white : AppColors.darkGrey), onSelected: (v) => setState(() => _selectedCategory = v! ? c : 'الكل'));
            },
          ),
        ),
        // مدن
        SizedBox(
          height: 42,
          child: ListView.separated(
            scrollDirection: Axis.horizontal, padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            itemCount: _cities.length, separatorBuilder: (_, __) => const SizedBox(width: 4),
            itemBuilder: (context, index) {
              final c = _cities[index];
              final selected = _selectedCity == c;
              return ChoiceChip(label: Text(c, style: const TextStyle(fontSize: 10)), selected: selected, selectedColor: AppColors.info, labelStyle: TextStyle(color: selected ? Colors.white : AppColors.darkGrey), onSelected: (v) => setState(() => _selectedCity = v! ? c : 'الكل'));
            },
          ),
        ),
        const Divider(height: 1),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: _filteredLabs.length,
            itemBuilder: (context, index) => _buildLabCard(_filteredLabs[index]),
          ),
        ),
      ]),
      floatingActionButton: FloatingActionButton.extended(onPressed: () {}, backgroundColor: AppColors.primary, icon: const Icon(Icons.add), label: const Text('حجز فحص')),
    );
  }

  Widget _buildLabCard(Map<String, dynamic> lab) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 6)]),
      child: Row(children: [
        Container(width: 50, height: 50, decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.06), borderRadius: BorderRadius.circular(12)), child: Center(child: Text(lab['image'], style: const TextStyle(fontSize: 26)))),
        const SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Text(lab['name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            if (lab['accredited']) ...[const SizedBox(width: 4), const Icon(Icons.verified, color: AppColors.info, size: 16)],
          ]),
          Text(lab['city'], style: const TextStyle(fontSize: 10, color: AppColors.grey)),
          Text(lab['category'], style: TextStyle(fontSize: 10, color: AppColors.primary)),
          Row(children: [
            const Icon(Icons.star, color: AppColors.amber, size: 14), Text(' ${lab['rating']}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
            const SizedBox(width: 8), const Icon(Icons.science, size: 14, color: AppColors.grey), Text(' ${lab['tests']} فحص', style: const TextStyle(fontSize: 10, color: AppColors.grey)),
          ]),
          Row(children: [
            if (lab['homeService']) Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: AppColors.success.withOpacity(0.1), borderRadius: BorderRadius.circular(4)), child: const Text('خدمة منزلية', style: TextStyle(fontSize: 8, color: AppColors.success))),
            const Spacer(),
            Text(lab['price'], style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary, fontSize: 13)),
          ]),
        ])),
        const Icon(Icons.arrow_back_ios, size: 14, color: AppColors.grey),
      ]),
    );
  }
}
