import 'package:flutter/material.dart';
import 'package:sehatak/core/constants/app_colors.dart';

class PatientMedicalHistory extends StatefulWidget {
  const PatientMedicalHistory({super.key});
  @override
  State<PatientMedicalHistory> createState() => _PatientMedicalHistoryState();
}

class _PatientMedicalHistoryState extends State<PatientMedicalHistory> {
  String _selectedTab = 'تحاليل';

  final List<Map<String, dynamic>> _labTests = [
    {'name': 'Complete Blood Count (CBC)', 'date': '10 May 2026', 'status': 'مكتمل', 'result': 'Normal', 'doctor': 'Dr. Ayesha Rahman', 'price': '800', 'icon': '🩸'},
    {'name': 'Lipid Profile', 'date': '05 May 2026', 'status': 'مكتمل', 'result': 'High Cholesterol', 'doctor': 'Dr. Usman Khan', 'price': '1200', 'icon': '🧪'},
    {'name': 'Thyroid Panel', 'date': '20 Apr 2026', 'status': 'مكتمل', 'result': 'Normal', 'doctor': 'Dr. Hassan Raza', 'price': '1500', 'icon': '🔬'},
    {'name': 'HbA1c', 'date': '15 Apr 2026', 'status': 'قيد الانتظار', 'result': 'Awaiting', 'doctor': 'Dr. Fatima Siddiqui', 'price': '900', 'icon': '💉'},
    {'name': 'Urine Analysis', 'date': '01 Apr 2026', 'status': 'مكتمل', 'result': 'Normal', 'doctor': 'Dr. Ayesha Rahman', 'price': '500', 'icon': '🧫'},
  ];

  final List<Map<String, dynamic>> _imaging = [
    {'name': 'Chest X-Ray', 'date': '08 May 2026', 'status': 'مكتمل', 'report': 'Clear', 'doctor': 'Dr. Kamran Ahmed', 'price': '600', 'icon': '🩻'},
    {'name': 'MRI Spine', 'date': '25 Apr 2026', 'status': 'مكتمل', 'report': 'Mild Disc Bulge', 'doctor': 'Dr. Kamran Ahmed', 'price': '8000', 'icon': '🔍'},
    {'name': 'Ultrasound Abdomen', 'date': '10 Apr 2026', 'status': 'مكتمل', 'report': 'Normal', 'doctor': 'Dr. Hassan Raza', 'price': '1500', 'icon': '📡'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('التحاليل والأشعة', style: TextStyle(fontWeight: FontWeight.bold)), actions: [IconButton(icon: const Icon(Icons.filter_list), onPressed: () {})]),
      body: Column(children: [
        // تبويبات
        Container(
          margin: const EdgeInsets.all(14),
          decoration: BoxDecoration(color: AppColors.surfaceContainerLow, borderRadius: BorderRadius.circular(12)),
          child: Row(children: [
            _tabButton('تحاليل', _selectedTab == 'تحاليل'),
            _tabButton('أشعة', _selectedTab == 'أشعة'),
          ]),
        ),
        // بطاقات ملخصة
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Row(children: [
            _summaryCard('كل الفحوصات', '8', Icons.science, AppColors.info),
            const SizedBox(width: 10),
            _summaryCard('مكتمل', '6', Icons.check_circle, AppColors.success),
            const SizedBox(width: 10),
            _summaryCard('قيد الانتظار', '2', Icons.pending, AppColors.warning),
          ]),
        ),
        const SizedBox(height: 14),
        // قائمة التحاليل
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            itemCount: _selectedTab == 'تحاليل' ? _labTests.length : _imaging.length,
            itemBuilder: (context, index) {
              final item = _selectedTab == 'تحاليل' ? _labTests[index] : _imaging[index];
              return _buildTestCard(item);
            },
          ),
        ),
      ]),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor: AppColors.primary,
        icon: const Icon(Icons.add),
        label: const Text('احجز فحص'),
      ),
    );
  }

  Widget _tabButton(String title, bool selected) {
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedTab = title),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(color: selected ? AppColors.primary : Colors.transparent, borderRadius: BorderRadius.circular(10)),
          child: Text(title, textAlign: TextAlign.center, style: TextStyle(color: selected ? Colors.white : AppColors.darkGrey, fontWeight: FontWeight.bold, fontSize: 13)),
        ),
      ),
    );
  }

  Widget _summaryCard(String title, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: color.withOpacity(0.08), borderRadius: BorderRadius.circular(12)),
        child: Column(children: [Icon(icon, color: color, size: 22), const SizedBox(height: 4), Text(value, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: color)), Text(title, style: const TextStyle(fontSize: 9, color: AppColors.grey))]),
      ),
    );
  }

  Widget _buildTestCard(Map<String, dynamic> test) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 6)]),
      child: Row(children: [
        Container(width: 45, height: 45, decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.1), borderRadius: BorderRadius.circular(10)), child: Center(child: Text(test['icon'], style: const TextStyle(fontSize: 20)))),
        const SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(test['name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          const SizedBox(height: 2),
          Text('Dr: ${test['doctor']}', style: const TextStyle(fontSize: 11, color: AppColors.darkGrey)),
          Text('${test['date']} • Rs. ${test['price']}', style: const TextStyle(fontSize: 10, color: AppColors.grey)),
        ])),
        Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: test['status'] == 'مكتمل' ? Colors.green.withOpacity(0.1) : Colors.orange.withOpacity(0.1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(test['status'], style: TextStyle(color: test['status'] == 'مكتمل' ? Colors.green : Colors.orange, fontSize: 10, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 4),
          if (test['result'] != null) ...[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: test['result'] == 'Normal' ? Colors.green.withOpacity(0.1) : AppColors.warning.withOpacity(0.1),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(test['result'] ?? test['report'], style: TextStyle(fontSize: 9, color: test['result'] == 'Normal' ? Colors.green : AppColors.warning)),
            ),
          ],
        ]),
        const SizedBox(width: 4),
        const Icon(Icons.arrow_forward_ios, size: 14, color: AppColors.grey),
      ]),
    );
  }
}
