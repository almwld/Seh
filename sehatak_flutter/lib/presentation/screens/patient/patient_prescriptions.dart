import 'package:flutter/material.dart';
import 'package:sehatak/core/constants/app_colors.dart';

class PatientPrescriptions extends StatefulWidget {
  const PatientPrescriptions({super.key});
  @override
  State<PatientPrescriptions> createState() => _PatientPrescriptionsState();
}

class _PatientPrescriptionsState extends State<PatientPrescriptions> {
  String _selectedTab = 'نشطة';

  final List<Map<String, dynamic>> _activePrescriptions = [
    {'doctor': 'د. علي المولد', 'date': '1 مايو 2026', 'diagnosis': 'ارتفاع ضغط الدم', 'medicines': ['أملوديبين 5mg - حبة يومياً', 'هيدروكلوروثيازيد 25mg - حبة يومياً'], 'duration': '3 أشهر', 'notes': 'تجنب الأطعمة المالحة', 'image': '👨‍⚕️'},
    {'doctor': 'د. عائشة ملك', 'date': '25 أبريل 2026', 'diagnosis': 'حساسية جلدية', 'medicines': ['سيتريزين 10mg - حبة عند اللزوم', 'مرهم هيدروكورتيزون - مرتين يومياً'], 'duration': 'أسبوعين', 'notes': 'تجنب التعرض للغبار', 'image': '👩‍⚕️'},
    {'doctor': 'د. فاطمة صديقي', 'date': '18 أبريل 2026', 'diagnosis': 'التهاب حلق', 'medicines': ['أموكسيسيلين 500mg - كل 8 ساعات', 'باراسيتامول 500mg - عند الحاجة'], 'duration': '7 أيام', 'notes': 'أكمل الكورس كاملاً', 'image': '👩‍⚕️'},
  ];

  final List<Map<String, dynamic>> _pastPrescriptions = [
    {'doctor': 'د. حسن رضا', 'date': '10 مارس 2026', 'diagnosis': 'التهاب معوي', 'medicines': ['ميترونيدازول 500mg', 'معالجة جفاف'], 'duration': '5 أيام', 'image': '👨‍⚕️'},
    {'doctor': 'د. عثمان خان', 'date': '5 فبراير 2026', 'diagnosis': 'خفقان قلب', 'medicines': ['بروبرانولول 40mg', 'فحوصات دورية'], 'duration': 'شهر', 'image': '👨‍⚕️'},
    {'doctor': 'د. كمال أحمد', 'date': '20 يناير 2026', 'diagnosis': 'آلام ظهر', 'medicines': ['ديكلوفيناك 50mg', 'جلسات علاج طبيعي'], 'duration': '10 أيام', 'image': '👨‍⚕️'},
  ];

  @override
  Widget build(BuildContext context) {
    final prescriptions = _selectedTab == 'نشطة' ? _activePrescriptions : _pastPrescriptions;

    return Scaffold(
      appBar: AppBar(title: const Text('الوصفات الطبية', style: TextStyle(fontWeight: FontWeight.bold)), actions: [IconButton(icon: const Icon(Icons.search), onPressed: () {})]),
      body: Column(children: [
        Container(
          margin: const EdgeInsets.all(12),
          decoration: BoxDecoration(color: AppColors.surfaceContainerLow, borderRadius: BorderRadius.circular(12)),
          child: Row(children: [
            _tabButton('نشطة', _selectedTab == 'نشطة'),
            _tabButton('سابقة', _selectedTab == 'سابقة'),
          ]),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            itemCount: prescriptions.length,
            itemBuilder: (context, index) => _buildPrescriptionCard(prescriptions[index]),
          ),
        ),
      ]),
    );
  }

  Widget _tabButton(String title, bool selected) {
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedTab = title),
        child: Container(padding: const EdgeInsets.symmetric(vertical: 10), decoration: BoxDecoration(color: selected ? AppColors.primary : Colors.transparent, borderRadius: BorderRadius.circular(10)), child: Text(title, textAlign: TextAlign.center, style: TextStyle(color: selected ? Colors.white : AppColors.darkGrey, fontWeight: FontWeight.bold, fontSize: 13))),
      ),
    );
  }

  Widget _buildPrescriptionCard(Map<String, dynamic> p) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8)]),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          CircleAvatar(radius: 24, backgroundColor: AppColors.primary.withOpacity(0.08), child: Text(p['image'], style: const TextStyle(fontSize: 24))),
          const SizedBox(width: 10),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(p['doctor'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            Text('${p['date']} • ${p['duration']}', style: const TextStyle(fontSize: 10, color: AppColors.grey)),
          ])),
          Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: _selectedTab == 'نشطة' ? AppColors.success.withOpacity(0.1) : AppColors.grey.withOpacity(0.1), borderRadius: BorderRadius.circular(8)), child: Text(_selectedTab == 'نشطة' ? 'نشطة' : 'منتهية', style: TextStyle(fontSize: 9, color: _selectedTab == 'نشطة' ? AppColors.success : AppColors.grey, fontWeight: FontWeight.bold))),
        ]),
        const Divider(height: 16),
        Text('التشخيص: ${p['diagnosis']}', style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 12)),
        const SizedBox(height: 8),
        ...(p['medicines'] as List).map((m) => Container(
          margin: const EdgeInsets.only(bottom: 4),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.04), borderRadius: BorderRadius.circular(8)),
          child: Row(children: [const Icon(Icons.medication, size: 14, color: AppColors.primary), const SizedBox(width: 6), Expanded(child: Text(m, style: const TextStyle(fontSize: 11)))])),
        ),
        if (p['notes'] != null) ...[
          const SizedBox(height: 8),
          Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: AppColors.warning.withOpacity(0.06), borderRadius: BorderRadius.circular(8)), child: Row(children: [const Icon(Icons.info, size: 14, color: AppColors.warning), const SizedBox(width: 6), Text(p['notes'], style: const TextStyle(fontSize: 10, color: AppColors.warning))])),
        ],
        const SizedBox(height: 10),
        Row(children: [
          Expanded(child: OutlinedButton.icon(onPressed: () {}, icon: const Icon(Icons.download, size: 14), label: const Text('تحميل PDF'), style: OutlinedButton.styleFrom(foregroundColor: AppColors.primary, padding: const EdgeInsets.symmetric(vertical: 8)))),
          const SizedBox(width: 8),
          Expanded(child: ElevatedButton.icon(onPressed: () {}, icon: const Icon(Icons.local_pharmacy, size: 14), label: const Text('طلب الأدوية'), style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, padding: const EdgeInsets.symmetric(vertical: 8)))),
        ]),
      ]),
    );
  }
}
