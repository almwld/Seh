import 'package:flutter/material.dart';
import 'package:sehatak/core/constants/app_colors.dart';

class CalorieCalculatorScreen extends StatefulWidget {
  const CalorieCalculatorScreen({super.key});
  @override
  State<CalorieCalculatorScreen> createState() => _CalorieCalculatorScreenState();
}

class _CalorieCalculatorScreenState extends State<CalorieCalculatorScreen> {
  final List<Map<String, dynamic>> _meals = [
    {'name': 'رز أبيض (كوب)', 'calories': 206, 'protein': '4.2g', 'carbs': '44.5g', 'fat': '0.4g', 'icon': '🍚'},
    {'name': 'دجاج مشوي (صدر)', 'calories': 165, 'protein': '31g', 'carbs': '0g', 'fat': '3.6g', 'icon': '🍗'},
    {'name': 'خبز (رغيف)', 'calories': 275, 'protein': '9g', 'carbs': '55g', 'fat': '1.2g', 'icon': '🍞'},
    {'name': 'بيض مسلوق', 'calories': 78, 'protein': '6g', 'carbs': '0.6g', 'fat': '5g', 'icon': '🥚'},
    {'name': 'موز', 'calories': 105, 'protein': '1.3g', 'carbs': '27g', 'fat': '0.4g', 'icon': '🍌'},
    {'name': 'تفاح', 'calories': 95, 'protein': '0.5g', 'carbs': '25g', 'fat': '0.3g', 'icon': '🍎'},
    {'name': 'لبن (كوب)', 'calories': 61, 'protein': '3.5g', 'carbs': '5g', 'fat': '3.3g', 'icon': '🥛'},
    {'name': 'جبنة بيضاء', 'calories': 80, 'protein': '6g', 'carbs': '1g', 'fat': '6g', 'icon': '🧀'},
    {'name': 'تمر (حبة)', 'calories': 23, 'protein': '0.2g', 'carbs': '6g', 'fat': '0g', 'icon': '🌴'},
    {'name': 'عسل (ملعقة)', 'calories': 64, 'protein': '0g', 'carbs': '17g', 'fat': '0g', 'icon': '🍯'},
    {'name': 'مكسرات (حفنة)', 'calories': 173, 'protein': '5g', 'carbs': '6g', 'fat': '15g', 'icon': '🥜'},
    {'name': 'سمك مشوي', 'calories': 200, 'protein': '39g', 'carbs': '0g', 'fat': '4.5g', 'icon': '🐟'},
    {'name': 'شوربة عدس', 'calories': 150, 'protein': '9g', 'carbs': '22g', 'fat': '3g', 'icon': '🍜'},
    {'name': 'سلطة خضراء', 'calories': 35, 'protein': '2g', 'carbs': '6g', 'fat': '0.5g', 'icon': '🥗'},
    {'name': 'بطاطس مسلوقة', 'calories': 161, 'protein': '4.3g', 'carbs': '36g', 'fat': '0.2g', 'icon': '🥔'},
    {'name': 'شاي (بدون سكر)', 'calories': 2, 'protein': '0g', 'carbs': '0g', 'fat': '0g', 'icon': '🍵'},
    {'name': 'عصير برتقال', 'calories': 112, 'protein': '2g', 'carbs': '26g', 'fat': '0.5g', 'icon': '🍊'},
    {'name': 'كينوا (كوب)', 'calories': 222, 'protein': '8g', 'carbs': '39g', 'fat': '3.5g', 'icon': '🌾'},
  ];

  List<Map<String, dynamic>> _selectedMeals = [];
  String _searchQuery = '';

  int get _totalCalories => _selectedMeals.fold(0, (sum, m) => sum + (m['calories'] as int));

  @override
  Widget build(BuildContext context) {
    final filtered = _searchQuery.isEmpty ? _meals : _meals.where((m) => (m['name'] as String).contains(_searchQuery)).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('حاسبة السعرات')),
      body: Column(children: [
        // النتيجة
        Container(
          margin: const EdgeInsets.all(14),
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(gradient: const LinearGradient(colors: [AppColors.success, AppColors.teal]), borderRadius: BorderRadius.circular(16)),
          child: Column(children: [
            const Text('إجمالي السعرات', style: TextStyle(color: Colors.white70, fontSize: 14)),
            Text('$_totalCalories', style: const TextStyle(color: Colors.white, fontSize: 42, fontWeight: FontWeight.bold)),
            const Text('سعرة حرارية', style: TextStyle(color: Colors.white70, fontSize: 14)),
            const SizedBox(height: 8),
            LinearProgressIndicator(value: _totalCalories / 2000, backgroundColor: Colors.white24, color: Colors.white, minHeight: 6, borderRadius: BorderRadius.circular(3)),
          ]),
        ),
        // بحث
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: TextField(
            onChanged: (v) => setState(() => _searchQuery = v),
            decoration: InputDecoration(hintText: 'ابحث عن طعام...', prefixIcon: const Icon(Icons.search), filled: true, fillColor: AppColors.surfaceContainerLow, border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none)),
          ),
        ),
        // الوجبات المختارة
        if (_selectedMeals.isNotEmpty) ...[
          Padding(padding: const EdgeInsets.all(14), child: Wrap(spacing: 6, runSpacing: 6, children: _selectedMeals.map((m) => Chip(label: Text('${m['name']} (${m['calories']})'), deleteIcon: const Icon(Icons.close, size: 14), onDeleted: () => setState(() => _selectedMeals.remove(m)))).toList())),
        ],
        // قائمة الأطعمة
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            itemCount: filtered.length,
            itemBuilder: (context, index) {
              final m = filtered[index];
              return ListTile(
                leading: Text(m['icon'], style: const TextStyle(fontSize: 30)),
                title: Text(m['name'], style: const TextStyle(fontWeight: FontWeight.w500)),
                subtitle: Text('${m['calories']} سعرة | بروتين: ${m['protein']} | كارب: ${m['carbs']}'),
                trailing: ElevatedButton(onPressed: () => setState(() => _selectedMeals.add(m)), style: ElevatedButton.styleFrom(backgroundColor: AppColors.success), child: const Text('+', style: TextStyle(fontSize: 18))),
              );
            },
          ),
        ),
      ]),
    );
  }
}
