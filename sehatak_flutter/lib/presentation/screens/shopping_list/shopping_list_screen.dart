import 'package:flutter/material.dart';
import 'package:sehatak/core/constants/app_colors.dart';

class ShoppingListScreen extends StatefulWidget {
  const ShoppingListScreen({super.key});
  @override
  State<ShoppingListScreen> createState() => _ShoppingListScreenState();
}

class _ShoppingListScreenState extends State<ShoppingListScreen> {
  final List<Map<String, dynamic>> _items = [
    {'name': 'خبز أسمر', 'category': 'مخبوزات', 'done': true, 'icon': '🍞'},
    {'name': 'حليب قليل الدسم', 'category': 'ألبان', 'done': false, 'icon': '🥛'},
    {'name': 'بيض', 'category': 'بروتين', 'done': true, 'icon': '🥚'},
    {'name': 'دجاج', 'category': 'بروتين', 'done': false, 'icon': '🍗'},
    {'name': 'خضروات مشكلة', 'category': 'خضار', 'done': false, 'icon': '🥬'},
    {'name': 'فواكه', 'category': 'فواكه', 'done': false, 'icon': '🍎'},
    {'name': 'زيت زيتون', 'category': 'زيوت', 'done': true, 'icon': '🫒'},
    {'name': 'مكسرات', 'category': 'وجبات خفيفة', 'done': false, 'icon': '🥜'},
    {'name': 'شوفان', 'category': 'حبوب', 'done': false, 'icon': '🌾'},
  ];

  final TextEditingController _addController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final done = _items.where((i) => i['done']).length;
    return Scaffold(
      appBar: AppBar(title: const Text('قائمة التسوق الصحي', style: TextStyle(fontWeight: FontWeight.bold)), actions: [IconButton(icon: const Icon(Icons.delete_outline), onPressed: () {})]),
      body: Column(children: [
        Container(
          margin: const EdgeInsets.all(14),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(gradient: const LinearGradient(colors: [AppColors.success, AppColors.teal]), borderRadius: BorderRadius.circular(14)),
          child: Row(children: [
            const Icon(Icons.shopping_cart_checkout, color: Colors.white, size: 32),
            const SizedBox(width: 10),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('$done/${_items.length} مكتمل', style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
              LinearProgressIndicator(value: done / _items.length, backgroundColor: Colors.white24, color: Colors.white, minHeight: 4, borderRadius: BorderRadius.circular(2)),
            ])),
          ]),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            itemCount: _items.length,
            itemBuilder: (context, idx) {
              final item = _items[idx];
              return Container(
                margin: const EdgeInsets.only(bottom: 4),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 4)]),
                child: CheckboxListTile(
                  value: item['done'],
                  activeColor: AppColors.success,
                  title: Row(children: [Text(item['icon'], style: const TextStyle(fontSize: 20)), const SizedBox(width: 8), Text(item['name'], style: TextStyle(fontSize: 13, decoration: item['done'] ? TextDecoration.lineThrough : null, color: item['done'] ? AppColors.grey : null))]),
                  subtitle: Text(item['category'], style: const TextStyle(fontSize: 9, color: AppColors.grey)),
                  onChanged: (v) => setState(() => item['done'] = v),
                ),
              );
            },
          ),
        ),
        Container(padding: const EdgeInsets.all(10), color: Colors.white, child: Row(children: [
          Expanded(child: TextField(controller: _addController, textAlign: TextAlign.right, decoration: InputDecoration(hintText: 'أضف منتجاً...', filled: true, fillColor: AppColors.surfaceContainerLow, border: OutlineInputBorder(borderRadius: BorderRadius.circular(24), borderSide: BorderSide.none), contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8)))),
          const SizedBox(width: 6),
          CircleAvatar(backgroundColor: AppColors.success, child: IconButton(icon: const Icon(Icons.add, color: Colors.white), onPressed: () { if (_addController.text.isNotEmpty) { setState(() => _items.add({'name': _addController.text, 'category': 'عام', 'done': false, 'icon': '🛒'})); _addController.clear(); } })),
        ])),
      ]),
    );
  }
}
