import 'package:flutter/material.dart';
import 'package:sehatak/core/constants/app_colors.dart';

class MedicalReportsScreen extends StatefulWidget {
  const MedicalReportsScreen({super.key});
  @override
  State<MedicalReportsScreen> createState() => _MedicalReportsScreenState();
}

class _MedicalReportsScreenState extends State<MedicalReportsScreen> {
  String _selectedType = 'الكل';

  final List<Map<String, dynamic>> _reports = [
    {
      'name': 'تقرير تحليل CBC الشامل',
      'date': '10 مايو 2026',
      'doctor': 'د. حسن رضا',
      'lab': 'مختبر الثقة',
      'type': 'تحليل دم',
      'size': '245 KB',
      'icon': '🩸',
      'color': AppColors.error,
      'summary': 'جميع النتائج ضمن المعدل الطبيعي. الهيموجلوبين 14.5 g/dL، كريات الدم البيضاء 7,200/µL، الصفائح الدموية 250,000/µL.',
      'status': 'طبيعي',
    },
    {
      'name': 'تقرير أشعة الصدر',
      'date': '5 مايو 2026',
      'doctor': 'د. عثمان خان',
      'lab': 'مركز الأشعة المتقدم',
      'type': 'أشعة',
      'size': '1.2 MB',
      'icon': '🩻',
      'color': AppColors.info,
      'summary': 'صورة شعاعية للصدر: لا يوجد ارتشاح رئوي. القلب بحجم طبيعي. الأضلاع والحجاب الحاجز طبيعية.',
      'status': 'طبيعي',
    },
    {
      'name': 'تقرير وظائف الكبد',
      'date': '1 مايو 2026',
      'doctor': 'د. عائشة ملك',
      'lab': 'المختبر الوطني',
      'type': 'تحليل',
      'size': '320 KB',
      'icon': '🧪',
      'color': AppColors.success,
      'summary': 'ALT: 28 U/L، AST: 32 U/L، ALP: 65 U/L. إنزيمات الكبد ضمن الحدود الطبيعية.',
      'status': 'طبيعي',
    },
    {
      'name': 'تقرير وظائف الكلى',
      'date': '28 أبريل 2026',
      'doctor': 'د. علي المولد',
      'lab': 'مختبر الثقة',
      'type': 'تحليل',
      'size': '280 KB',
      'icon': '🫘',
      'color': AppColors.warning,
      'summary': 'الكرياتينين: 1.2 mg/dL (مرتفع قليلاً). اليوريا: 35 mg/dL. ننصح بشرب الماء بكثرة وإعادة الفحص بعد شهر.',
      'status': 'مرتفع',
    },
    {
      'name': 'تقرير الدهون الثلاثية',
      'date': '25 أبريل 2026',
      'doctor': 'د. عثمان خان',
      'lab': 'مختبر البرج',
      'type': 'تحليل',
      'size': '195 KB',
      'icon': '🧈',
      'color': AppColors.error,
      'summary': 'الكوليسترول الكلي: 220 mg/dL (مرتفع). LDL: 145 mg/dL (مرتفع). HDL: 40 mg/dL (منخفض). الدهون الثلاثية: 180 mg/dL (مرتفع). ننصح بتعديل النظام الغذائي.',
      'status': 'مرتفع',
    },
    {
      'name': 'تقرير السكر التراكمي HbA1c',
      'date': '20 أبريل 2026',
      'doctor': 'د. حسن رضا',
      'lab': 'المختبر الوطني',
      'type': 'تحليل',
      'size': '210 KB',
      'icon': '💉',
      'color': AppColors.info,
      'summary': 'HbA1c: 5.7% (طبيعي). لا توجد مؤشرات لمرحلة ما قبل السكري. استمر في نمط حياتك الصحي.',
      'status': 'طبيعي',
    },
    {
      'name': 'تقرير فيتامين د',
      'date': '15 أبريل 2026',
      'doctor': 'د. عائشة ملك',
      'lab': 'مختبر اليقين',
      'type': 'تحليل',
      'size': '175 KB',
      'icon': '☀️',
      'color': AppColors.warning,
      'summary': 'مستوى فيتامين د: 18 ng/mL (منخفض). ننصح بالتعرض للشمس وتناول مكملات فيتامين د 1000-2000 IU يومياً.',
      'status': 'منخفض',
    },
    {
      'name': 'تقرير الغدة الدرقية',
      'date': '10 أبريل 2026',
      'doctor': 'د. حسن رضا',
      'lab': 'المختبر الوطني',
      'type': 'تحليل',
      'size': '230 KB',
      'icon': '🦋',
      'color': AppColors.success,
      'summary': 'TSH: 2.5 mIU/L، T4: 1.2 ng/dL، T3: 3.1 pg/mL. جميع هرمونات الغدة الدرقية طبيعية.',
      'status': 'طبيعي',
    },
    {
      'name': 'تقرير تخطيط القلب',
      'date': '5 أبريل 2026',
      'doctor': 'د. عثمان خان',
      'lab': 'مستشفى القلب',
      'type': 'تخطيط',
      'size': '450 KB',
      'icon': '💓',
      'color': AppColors.success,
      'summary': 'تخطيط قلب كهربائي: إيقاع جيبي طبيعي. معدل ضربات القلب 72 نبضة/دقيقة. لا توجد اضطرابات نظم أو نقص تروية.',
      'status': 'طبيعي',
    },
    {
      'name': 'تقرير فحص النظر',
      'date': '1 أبريل 2026',
      'doctor': 'د. عمر فاروق',
      'lab': 'مركز العيون',
      'type': 'فحص',
      'size': '180 KB',
      'icon': '👁️',
      'color': AppColors.purple,
      'summary': 'حدة البصر: يمين 6/6، يسار 6/6. ضغط العين: 14 mmHg طبيعي. قاع العين سليم. لا حاجة لنظارة.',
      'status': 'طبيعي',
    },
    {
      'name': 'تقرير فحص الأسنان',
      'date': '25 مارس 2026',
      'doctor': 'د. زهرة طارق',
      'lab': 'عيادة سمايل',
      'type': 'فحص',
      'size': '160 KB',
      'icon': '🦷',
      'color': AppColors.teal,
      'summary': 'فحص شامل للأسنان: تسوس بسيط في الضرس 6. ننصح بحشوة تجميلية. اللثة سليمة. نظافة أسنان جيدة.',
      'status': 'يحتاج علاج',
    },
  ];

  List<Map<String, dynamic>> get _filteredReports {
    if (_selectedType == 'الكل') return _reports;
    return _reports.where((r) => r['type'] == _selectedType).toList();
  }

  void _viewReport(Map<String, dynamic> report) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (_) => DraggableScrollableSheet(
        initialChildSize: 0.75, minChildSize: 0.5, maxChildSize: 0.9,
        expand: false,
        builder: (context, scrollController) => SingleChildScrollView(
          controller: scrollController,
          padding: const EdgeInsets.all(20),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(2)))),
            const SizedBox(height: 16),
            // رأس التقرير
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(gradient: LinearGradient(colors: [(report['color'] as Color).withOpacity(0.1), (report['color'] as Color).withOpacity(0.05)]), borderRadius: BorderRadius.circular(14)),
              child: Row(children: [Text(report['icon'], style: const TextStyle(fontSize: 40)), const SizedBox(width: 12), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(report['name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)), Text('${report['lab']} • ${report['date']}', style: const TextStyle(fontSize: 11, color: AppColors.grey))]))]),
            ),
            const SizedBox(height: 14),
            // تفاصيل التقرير
            _detailRow('الطبيب المعالج', report['doctor'], Icons.person),
            _detailRow('المختبر', report['lab'], Icons.science),
            _detailRow('التاريخ', report['date'], Icons.calendar_today),
            _detailRow('نوع التقرير', report['type'], Icons.category),
            _detailRow('حجم الملف', report['size'], Icons.storage),
            const Divider(height: 20),
            // النتيجة
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: report['status'] == 'طبيعي' ? AppColors.success.withOpacity(0.05) : report['status'] == 'مرتفع' ? AppColors.warning.withOpacity(0.05) : AppColors.info.withOpacity(0.05),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: report['status'] == 'طبيعي' ? AppColors.success.withOpacity(0.2) : report['status'] == 'مرتفع' ? AppColors.warning.withOpacity(0.2) : AppColors.info.withOpacity(0.2)),
              ),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(children: [
                  Icon(report['status'] == 'طبيعي' ? Icons.check_circle : Icons.warning, color: report['status'] == 'طبيعي' ? AppColors.success : AppColors.warning, size: 20),
                  const SizedBox(width: 6),
                  Text('الحالة: ${report['status']}', style: TextStyle(fontWeight: FontWeight.bold, color: report['status'] == 'طبيعي' ? AppColors.success : AppColors.warning)),
                ]),
                const SizedBox(height: 8),
                Text(report['summary'], style: const TextStyle(fontSize: 13, height: 1.6, color: AppColors.darkGrey)),
              ]),
            ),
            const SizedBox(height: 16),
            // أزرار
            Row(children: [
              Expanded(child: ElevatedButton.icon(onPressed: () {}, icon: const Icon(Icons.download), label: const Text('تحميل PDF'), style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, padding: const EdgeInsets.symmetric(vertical: 12)))),
              const SizedBox(width: 8),
              Expanded(child: OutlinedButton.icon(onPressed: () {}, icon: const Icon(Icons.share), label: const Text('مشاركة'), style: OutlinedButton.styleFrom(foregroundColor: AppColors.primary, padding: const EdgeInsets.symmetric(vertical: 12)))),
            ]),
          ]),
        ),
      ),
    );
  }

  Widget _detailRow(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(children: [Icon(icon, size: 14, color: AppColors.grey), const SizedBox(width: 8), Text('$label: ', style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 12)), Text(value, style: const TextStyle(fontSize: 12, color: AppColors.darkGrey))]),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredReports;
    final normal = _reports.where((r) => r['status'] == 'طبيعي').length;
    final abnormal = _reports.where((r) => r['status'] != 'طبيعي').length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('تقاريري الطبية', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
          IconButton(icon: const Icon(Icons.filter_list), onPressed: () {}),
        ],
      ),
      body: Column(children: [
        // إحصائيات
        Container(
          margin: const EdgeInsets.all(14),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 6)]),
          child: Row(children: [
            _statItem('${_reports.length}', 'تقرير', AppColors.primary),
            Container(width: 1, height: 30, color: AppColors.outlineVariant),
            _statItem('$normal', 'طبيعي', AppColors.success),
            Container(width: 1, height: 30, color: AppColors.outlineVariant),
            _statItem('$abnormal', 'يحتاج متابعة', AppColors.warning),
          ]),
        ),

        // تصنيفات
        SizedBox(
          height: 40,
          child: ListView.separated(
            scrollDirection: Axis.horizontal, padding: const EdgeInsets.symmetric(horizontal: 10),
            itemCount: ['الكل', 'تحليل دم', 'تحليل', 'أشعة', 'تخطيط', 'فحص'].length,
            separatorBuilder: (_, __) => const SizedBox(width: 4),
            itemBuilder: (context, i) {
              final t = ['الكل', 'تحليل دم', 'تحليل', 'أشعة', 'تخطيط', 'فحص'][i];
              final selected = _selectedType == t;
              return ChoiceChip(label: Text(t, style: const TextStyle(fontSize: 10)), selected: selected, selectedColor: AppColors.primary, labelStyle: TextStyle(color: selected ? Colors.white : AppColors.darkGrey), onSelected: (v) => setState(() => _selectedType = v! ? t : 'الكل'));
            },
          ),
        ),
        const Divider(height: 1),

        // التقارير
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: filtered.length,
            itemBuilder: (context, i) {
              final r = filtered[i];
              return GestureDetector(
                onTap: () => _viewReport(r),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 6)]),
                  child: Row(children: [
                    Container(width: 48, height: 48, decoration: BoxDecoration(color: (r['color'] as Color).withOpacity(0.06), borderRadius: BorderRadius.circular(12)), child: Center(child: Text(r['icon'], style: const TextStyle(fontSize: 24)))),
                    const SizedBox(width: 12),
                    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(r['name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13), maxLines: 1, overflow: TextOverflow.ellipsis),
                      Text('${r['doctor']} • ${r['date']}', style: const TextStyle(fontSize: 9, color: AppColors.grey)),
                      Row(children: [
                        Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: (r['color'] as Color).withOpacity(0.08), borderRadius: BorderRadius.circular(4)), child: Text(r['type'], style: TextStyle(fontSize: 8, color: r['color']))),
                        const SizedBox(width: 8),
                        Text(r['size'], style: const TextStyle(fontSize: 9, color: AppColors.grey)),
                      ]),
                    ])),
                    Column(children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: r['status'] == 'طبيعي' ? AppColors.success.withOpacity(0.08) : AppColors.warning.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(r['status'], style: TextStyle(fontSize: 9, color: r['status'] == 'طبيعي' ? AppColors.success : AppColors.warning, fontWeight: FontWeight.bold)),
                      ),
                      const SizedBox(height: 8),
                      const Icon(Icons.arrow_back_ios, size: 12, color: AppColors.grey),
                    ]),
                  ]),
                ),
              );
            },
          ),
        ),
      ]),
      floatingActionButton: FloatingActionButton(onPressed: () {}, backgroundColor: AppColors.primary, child: const Icon(Icons.upload_file, color: Colors.white)),
    );
  }

  Widget _statItem(String value, String label, Color color) {
    return Expanded(
      child: Column(children: [Text(value, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: color)), Text(label, style: const TextStyle(fontSize: 9, color: AppColors.grey))]),
    );
  }
}
