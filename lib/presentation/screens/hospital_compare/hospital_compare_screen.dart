import 'package:flutter/material.dart';
import 'package:sehatak/core/constants/app_colors.dart';

class HospitalCompareScreen extends StatefulWidget {
  const HospitalCompareScreen({super.key});
  @override
  State<HospitalCompareScreen> createState() => _HospitalCompareScreenState();
}

class _HospitalCompareScreenState extends State<HospitalCompareScreen> {
  final List<Map<String, dynamic>> _hospitals = const [
    {'name': 'مستشفى الثورة', 'beds': '500', 'doctors': '200', 'emergency': true, 'icu': true, 'ambulance': true, 'rating': 4.5, 'price': 'مرتفع', 'city': 'صنعاء', 'image': '🏥'},
    {'name': 'مستشفى الكويت', 'beds': '400', 'doctors': '180', 'emergency': true, 'icu': true, 'ambulance': true, 'rating': 4.7, 'price': 'متوسط', 'city': 'صنعاء', 'image': '🏥'},
    {'name': 'مستشفى آزال', 'beds': '150', 'doctors': '80', 'emergency': true, 'icu': false, 'ambulance': false, 'rating': 4.2, 'price': 'منخفض', 'city': 'صنعاء', 'image': '🏥'},
    {'name': 'المستشفى العسكري', 'beds': '600', 'doctors': '250', 'emergency': true, 'icu': true, 'ambulance': true, 'rating': 4.8, 'price': 'متوسط', 'city': 'صنعاء', 'image': '🏥'},
  ];

  Set<int> _selectedIndices = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('مقارنة المستشفيات')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(14),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // جدول المقارنة
          if (_selectedIndices.length >= 2)
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columnSpacing: 20,
                columns: [
                  const DataColumn(label: Text('الميزة', style: TextStyle(fontWeight: FontWeight.bold))),
                  ..._selectedIndices.map((i) => DataColumn(label: Text(_hospitals[i]['name'], style: const TextStyle(fontWeight: FontWeight.bold)))),
                ],
                rows: [
                  _buildRow('التقييم', 'rating', Icons.star),
                  _buildRow('الأسرة', 'beds', Icons.bed),
                  _buildRow('الأطباء', 'doctors', Icons.person),
                  _buildRow('طوارئ', 'emergency', Icons.warning, isBool: true),
                  _buildRow('عناية', 'icu', Icons.monitor_heart, isBool: true),
                  _buildRow('إسعاف', 'ambulance', Icons.local_shipping, isBool: true),
                  _buildRow('المدينة', 'city', Icons.location_city, isString: true),
                  _buildRow('التكلفة', 'price', Icons.money),
                ],
              ),
            ),
          const SizedBox(height: 16),
          Text(_selectedIndices.length < 2 ? 'اختر مستشفيين للمقارنة (${_selectedIndices.length}/2)' : 'اختر للمقارنة', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          ..._hospitals.asMap().entries.map((e) {
            final h = e.value;
            final selected = _selectedIndices.contains(e.key);
            return Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: selected ? AppColors.primary : Colors.transparent, width: 2), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 4)]),
              child: Row(children: [
                Text(h['image'], style: const TextStyle(fontSize: 32)),
                const SizedBox(width: 10),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(h['name'], style: const TextStyle(fontWeight: FontWeight.bold)), Text('${h['beds']} سرير • ${h['doctors']} طبيب', style: const TextStyle(fontSize: 10, color: AppColors.grey)), Row(children: [const Icon(Icons.star, color: AppColors.amber, size: 14), Text(' ${h['rating']}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12))])])),
                Checkbox(value: selected, activeColor: AppColors.primary, onChanged: (v) => setState(() { if (v!) { if (_selectedIndices.length < 3) _selectedIndices.add(e.key); } else { _selectedIndices.remove(e.key); } })),
              ]),
            );
          }),
        ]),
      ),
    );
  }

  DataRow _buildRow(String label, String key, IconData icon, {bool isBool = false, bool isString = false}) {
    return DataRow(cells: [
      DataCell(Row(children: [Icon(icon, size: 16, color: AppColors.primary), const SizedBox(width: 6), Text(label, style: const TextStyle(fontSize: 12))])),
      ..._selectedIndices.map((i) {
        final val = _hospitals[i][key];
        if (isBool) return DataCell(Icon(val == true ? Icons.check : Icons.close, color: val == true ? AppColors.success : AppColors.error, size: 18));
        return DataCell(Text(val.toString(), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)));
      }),
    ]);
  }
}
