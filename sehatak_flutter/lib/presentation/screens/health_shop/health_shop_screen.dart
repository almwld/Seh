import 'package:flutter/material.dart';
import 'package:sehatak/core/constants/app_colors.dart';

class HealthShopScreen extends StatefulWidget {
  const HealthShopScreen({super.key});
  @override
  State<HealthShopScreen> createState() => _HealthShopScreenState();
}

class _HealthShopScreenState extends State<HealthShopScreen> {
  final List<Map<String, dynamic>> _products = const [
    {'name': 'جهاز قياس ضغط', 'price': '150', 'category': 'أجهزة طبية', 'image': '🩺', 'brand': 'Omron', 'rating': 4.8},
    {'name': 'جهاز قياس سكر', 'price': '200', 'category': 'أجهزة طبية', 'image': '💉', 'brand': 'Accu-Chek', 'rating': 4.7},
    {'name': 'ميزان ذكي', 'price': '300', 'category': 'أجهزة طبية', 'image': '⚖️', 'brand': 'Xiaomi', 'rating': 4.9},
    {'name': 'كرسي متحرك', 'price': '800', 'category': 'معدات طبية', 'image': '🦽', 'brand': 'Drive Medical', 'rating': 4.5},
    {'name': 'عكاز طبي', 'price': '90', 'category': 'معدات طبية', 'image': '🦯', 'brand': 'Medline', 'rating': 4.3},
    {'name': 'سماعة طبيب', 'price': '120', 'category': 'أدوات', 'image': '🩺', 'brand': 'Littmann', 'rating': 4.8},
    {'name': 'مكملات بروتين', 'price': '250', 'category': 'مكملات', 'image': '💪', 'brand': 'Optimum', 'rating': 4.9},
    {'name': 'فيتامينات متعددة', 'price': '80', 'category': 'مكملات', 'image': '💊', 'brand': 'Centrum', 'rating': 4.7},
    {'name': 'كمادات حارة/باردة', 'price': '25', 'category': 'إسعافات', 'image': '🧊', 'brand': '3M', 'rating': 4.4},
    {'name': 'حقيبة إسعافات', 'price': '180', 'category': 'إسعافات', 'image': '🎒', 'brand': 'FirstAid', 'rating': 4.6},
    {'name': 'وسادة طبية', 'price': '130', 'category': 'راحة', 'image': '🛏️', 'brand': 'Tempur', 'rating': 4.5},
    {'name': 'مساج كهربائي', 'price': '450', 'category': 'راحة', 'image': '💆', 'brand': 'Beurer', 'rating': 4.7},
    {'name': 'جهاز بخار', 'price': '220', 'category': 'أجهزة طبية', 'image': '💨', 'brand': 'Philips', 'rating': 4.6},
    {'name': 'نظارة طبية', 'price': '350', 'category': 'بصريات', 'image': '👓', 'brand': 'RayBan', 'rating': 4.8},
    {'name': 'عدسات لاصقة', 'price': '160', 'category': 'بصريات', 'image': '👁️', 'brand': 'Acuvue', 'rating': 4.7},
  ];

  String _selectedCategory = 'الكل';
  int _cartCount = 0;

  @override
  Widget build(BuildContext context) {
    final categories = ['الكل', 'أجهزة طبية', 'مكملات', 'معدات طبية', 'إسعافات', 'راحة', 'بصريات'];
    final filtered = _selectedCategory == 'الكل' ? _products : _products.where((p) => p['category'] == _selectedCategory).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('المتجر الصحي'),
        actions: [Stack(children: [IconButton(icon: const Icon(Icons.shopping_cart), onPressed: () {}), if (_cartCount > 0) Positioned(right: 4, top: 4, child: Container(padding: const EdgeInsets.all(3), decoration: const BoxDecoration(color: AppColors.error, shape: BoxShape.circle), child: Text('$_cartCount', style: const TextStyle(color: Colors.white, fontSize: 9))))])],
      ),
      body: Column(children: [
        SizedBox(
          height: 45,
          child: ListView(scrollDirection: Axis.horizontal, padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), children: categories.map((c) => Padding(padding: const EdgeInsets.only(right: 6), child: ChoiceChip(label: Text(c, style: const TextStyle(fontSize: 11)), selected: _selectedCategory == c, selectedColor: AppColors.primary, labelStyle: TextStyle(color: _selectedCategory == c ? Colors.white : AppColors.darkGrey), onSelected: (v) => setState(() => _selectedCategory = c)))).toList()),
        ),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(12),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.68, crossAxisSpacing: 10, mainAxisSpacing: 10),
            itemCount: filtered.length,
            itemBuilder: (context, index) {
              final p = filtered[index];
              return Container(
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 6)]),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Container(height: 90, decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.04), borderRadius: const BorderRadius.vertical(top: Radius.circular(14))), child: Center(child: Text(p['image'], style: const TextStyle(fontSize: 44)))),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(p['brand'], style: const TextStyle(fontSize: 9, color: AppColors.grey)),
                      Text(p['name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11), maxLines: 1, overflow: TextOverflow.ellipsis),
                      Row(children: [const Icon(Icons.star, color: AppColors.amber, size: 12), Text(' ${p['rating']}', style: const TextStyle(fontSize: 10))]),
                      const SizedBox(height: 6),
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text('${p['price']} ر.س', style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary, fontSize: 14)), GestureDetector(onTap: () => setState(() => _cartCount++), child: Container(padding: const EdgeInsets.all(5), decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(6)), child: const Icon(Icons.add_shopping_cart, color: Colors.white, size: 14)))],),
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
}
