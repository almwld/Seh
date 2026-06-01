import 'package:flutter/material.dart';
import 'package:sehatak/core/constants/app_colors.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final List<String> _recentSearches = ['طبيب قلب', 'باراسيتامول', 'مستشفى الثورة', 'تحليل دم'];
  final List<String> _trending = ['كورونا', 'ضغط الدم', 'فيتامين د', 'حساسية', 'سكري', 'تطعيم أطفال'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          autofocus: true,
          textAlign: TextAlign.right,
          decoration: InputDecoration(hintText: 'ابحث عن طبيب، دواء، مستشفى...', border: InputBorder.none, hintStyle: TextStyle(color: Colors.white.withOpacity(0.7))),
          style: const TextStyle(color: Colors.white),
        ),
        actions: [IconButton(icon: const Icon(Icons.mic, color: Colors.white), onPressed: () {})],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // عمليات بحث سابقة
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text('عمليات بحث سابقة', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)), TextButton(onPressed: () {}, child: const Text('مسح الكل'))]),
          Wrap(spacing: 6, children: _recentSearches.map((s) => Chip(label: Text(s), onDeleted: () {}, deleteIcon: const Icon(Icons.close, size: 14))).toList()),
          const SizedBox(height: 20),
          // الأكثر بحثاً
          Text('الأكثر بحثاً', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Wrap(spacing: 6, children: _trending.map((t) => ActionChip(label: Text(t), onPressed: () { print(t); })).toList()),
          const SizedBox(height: 20),
          // فئات
          Text('تصفح حسب', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          GridView.count(crossAxisCount: 2, shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), crossAxisSpacing: 10, mainAxisSpacing: 10, childAspectRatio: 2.5, children: [
            _categoryCard('أطباء', Icons.person_search, AppColors.primary),
            _categoryCard('أدوية', Icons.medication, AppColors.success),
            _categoryCard('مستشفيات', Icons.local_hospital, AppColors.info),
            _categoryCard('تحاليل', Icons.science, AppColors.purple),
            _categoryCard('صيدليات', Icons.local_pharmacy, AppColors.teal),
            _categoryCard('مقالات', Icons.article, AppColors.orange),
          ]),
        ]),
      ),
    );
  }

  Widget _categoryCard(String title, IconData icon, Color color) {
    return Container(
      decoration: BoxDecoration(color: color.withOpacity(0.06), borderRadius: BorderRadius.circular(12)),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(icon, color: color, size: 20), const SizedBox(width: 8), Text(title, style: TextStyle(color: color, fontWeight: FontWeight.w500))]),
    );
  }
}
