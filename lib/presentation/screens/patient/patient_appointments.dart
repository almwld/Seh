import 'package:flutter/material.dart';
import 'package:sehatak/core/constants/app_colors.dart';
import 'package:sehatak/presentation/screens/chat/chat_screen.dart';

class PatientAppointments extends StatefulWidget {
  const PatientAppointments({super.key});
  @override
  State<PatientAppointments> createState() => _PatientAppointmentsState();
}

class _PatientAppointmentsState extends State<PatientAppointments> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, dynamic>> _upcomingAppointments = [
    {
      'doctor': 'د. علي المولد',
      'specialty': 'استشاري باطنية وأطفال',
      'date': '15 مايو 2026',
      'time': '10:30 صباحاً',
      'type': 'مكالمة فيديو',
      'status': 'مؤكد',
      'image': '👨‍⚕️',
      'location': 'عبر الإنترنت',
      'notes': 'متابعة ضغط الدم',
      'duration': '30 دقيقة',
      'fee': '500',
      'reminder': true,
    },
    {
      'doctor': 'د. حسن رضا',
      'specialty': 'طبيب عام',
      'date': '18 مايو 2026',
      'time': '2:00 مساءً',
      'type': 'حضوري',
      'status': 'قيد الانتظار',
      'image': '👨‍⚕️',
      'location': 'مستشفى المدينة الطبي - غرفة 204',
      'notes': 'فحص دوري شامل',
      'duration': '45 دقيقة',
      'fee': '300',
      'reminder': true,
    },
    {
      'doctor': 'د. فاطمة صديقي',
      'specialty': 'طبيبة أطفال',
      'date': '22 مايو 2026',
      'time': '9:00 صباحاً',
      'type': 'مكالمة فيديو',
      'status': 'مؤكد',
      'image': '👩‍⚕️',
      'location': 'عبر الإنترنت',
      'notes': 'استشارة تطعيمات',
      'duration': '20 دقيقة',
      'fee': '600',
      'reminder': false,
    },
  ];

  final List<Map<String, dynamic>> _pastAppointments = [
    {
      'doctor': 'د. عثمان خان',
      'specialty': 'طبيب قلب',
      'date': '28 أبريل 2026',
      'time': '11:00 صباحاً',
      'type': 'حضوري',
      'diagnosis': 'ارتفاع طفيف في الضغط - نصح بالمشي وتقليل الملح',
      'prescription': true,
      'image': '👨‍⚕️',
      'rating': 4.8,
      'fee': '1000',
    },
    {
      'doctor': 'د. عائشة ملك',
      'specialty': 'طبيبة جلدية',
      'date': '15 أبريل 2026',
      'time': '3:30 مساءً',
      'type': 'مكالمة فيديو',
      'diagnosis': 'حساسية جلدية موسمية - وصف مرهم مضاد للحساسية',
      'prescription': true,
      'image': '👩‍⚕️',
      'rating': 4.9,
      'fee': '800',
    },
    {
      'doctor': 'د. كمال أحمد',
      'specialty': 'طبيب عظام',
      'date': '2 أبريل 2026',
      'time': '5:00 مساءً',
      'type': 'حضوري',
      'diagnosis': 'شد عضلي في الظهر - جلسات علاج طبيعي',
      'prescription': false,
      'image': '👨‍⚕️',
      'rating': 4.6,
      'fee': '700',
    },
    {
      'doctor': 'د. سناء طارق',
      'specialty': 'طبيبة نسائية',
      'date': '20 مارس 2026',
      'time': '10:00 صباحاً',
      'type': 'حضوري',
      'diagnosis': 'فحص دوري - جميع النتائج طبيعية',
      'prescription': true,
      'image': '👩‍⚕️',
      'rating': 4.9,
      'fee': '800',
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('مواعيدي', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(icon: const Icon(Icons.calendar_month), onPressed: () {}, tooltip: 'التقويم'),
          IconButton(icon: const Icon(Icons.filter_list), onPressed: () {}, tooltip: 'تصفية'),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppColors.primary,
          labelColor: AppColors.primary,
          unselectedLabelColor: AppColors.grey,
          tabs: const [
            Tab(text: 'القادمة', icon: Icon(Icons.upcoming, size: 18)),
            Tab(text: 'السابقة', icon: Icon(Icons.history, size: 18)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildUpcomingTab(),
          _buildPastTab(),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showBookingSheet(),
        backgroundColor: AppColors.primary,
        icon: const Icon(Icons.add),
        label: const Text('حجز جديد'),
      ),
    );
  }

  // ==================== تبويب القادمة ====================
  Widget _buildUpcomingTab() {
    if (_upcomingAppointments.isEmpty) {
      return Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Icon(Icons.event_busy, size: 80, color: AppColors.grey),
          const SizedBox(height: 16),
          const Text('لا توجد مواعيد قادمة', style: TextStyle(fontSize: 18, color: AppColors.grey)),
          const SizedBox(height: 16),
          ElevatedButton.icon(onPressed: () => _showBookingSheet(), icon: const Icon(Icons.add), label: const Text('احجز موعداً'), style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary)),
        ]),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(14),
      itemCount: _upcomingAppointments.length,
      itemBuilder: (context, idx) => _buildUpcomingCard(_upcomingAppointments[idx], idx),
    );
  }

  Widget _buildUpcomingCard(Map<String, dynamic> apt, int idx) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: Column(children: [
        // رأس البطاقة
        Row(children: [
          Container(
            width: 56, height: 56,
            decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.08), borderRadius: BorderRadius.circular(14)),
            child: Center(child: Text(apt['image'], style: const TextStyle(fontSize: 30))),
          ),
          const SizedBox(width: 12),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(apt['doctor'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            Text(apt['specialty'], style: const TextStyle(color: AppColors.primary, fontSize: 11)),
            const SizedBox(height: 2),
            Row(children: [
              const Icon(Icons.star, color: AppColors.amber, size: 14),
              const Text(' 4.9', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
            ]),
          ])),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: apt['status'] == 'مؤكد' ? Colors.green.withOpacity(0.1) : Colors.orange.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(apt['status'], style: TextStyle(color: apt['status'] == 'مؤكد' ? Colors.green : Colors.orange, fontSize: 10, fontWeight: FontWeight.bold)),
          ),
        ]),
        const Divider(height: 20),

        // تفاصيل الموعد
        Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          _aptInfo(Icons.calendar_today, apt['date'], AppColors.primary),
          _aptInfo(Icons.access_time, apt['time'], AppColors.info),
          _aptInfo(apt['type'] == 'مكالمة فيديو' ? Icons.videocam : Icons.person, apt['type'], AppColors.success),
          _aptInfo(Icons.timer, apt['duration'], AppColors.warning),
        ]),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(color: AppColors.surfaceContainerLow.withOpacity(0.4), borderRadius: BorderRadius.circular(8)),
          child: Row(children: [
            const Icon(Icons.location_on, size: 14, color: AppColors.grey),
            const SizedBox(width: 4),
            Expanded(child: Text(apt['location'], style: const TextStyle(fontSize: 11, color: AppColors.darkGrey))),
          ]),
        ),
        if (apt['notes'] != null) ...[
          const SizedBox(height: 8),
          Row(children: [
            const Icon(Icons.note_alt, size: 14, color: AppColors.grey),
            const SizedBox(width: 4),
            Text(apt['notes'], style: const TextStyle(fontSize: 11, color: AppColors.darkGrey)),
          ]),
        ],
        const SizedBox(height: 12),
        Text('رسوم: ${apt['fee']} ر.س', style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary, fontSize: 14)),

        // أزرار
        const SizedBox(height: 12),
        Row(children: [
          Expanded(
            child: OutlinedButton.icon(
              onPressed: () => _cancelAppointment(idx),
              icon: const Icon(Icons.close, size: 16),
              label: const Text('إلغاء'),
              style: OutlinedButton.styleFrom(foregroundColor: AppColors.error, side: const BorderSide(color: AppColors.error), padding: const EdgeInsets.symmetric(vertical: 10)),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.edit, size: 16),
              label: const Text('تعديل'),
              style: OutlinedButton.styleFrom(foregroundColor: AppColors.info, side: const BorderSide(color: AppColors.info), padding: const EdgeInsets.symmetric(vertical: 10)),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ChatScreen())),
              icon: const Icon(Icons.message, size: 16),
              label: const Text('محادثة'),
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, padding: const EdgeInsets.symmetric(vertical: 10)),
            ),
          ),
        ]),
      ]),
    );
  }

  // ==================== تبويب السابقة ====================
  Widget _buildPastTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(14),
      itemCount: _pastAppointments.length,
      itemBuilder: (context, idx) => _buildPastCard(_pastAppointments[idx]),
    );
  }

  Widget _buildPastCard(Map<String, dynamic> apt) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 6)]),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Container(
            width: 50, height: 50,
            decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.06), borderRadius: BorderRadius.circular(12)),
            child: Center(child: Text(apt['image'], style: const TextStyle(fontSize: 26))),
          ),
          const SizedBox(width: 10),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(apt['doctor'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            Text(apt['specialty'], style: const TextStyle(fontSize: 11, color: AppColors.grey)),
            Text('${apt['date']} • ${apt['time']}', style: const TextStyle(fontSize: 10, color: AppColors.grey)),
          ])),
          Row(children: [const Icon(Icons.star, color: AppColors.amber, size: 16), Text(' ${apt['rating']}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14))]),
        ]),
        const Divider(height: 14),
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('التشخيص: ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
          Expanded(child: Text(apt['diagnosis'], style: const TextStyle(fontSize: 12, color: AppColors.darkGrey))),
        ]),
        const SizedBox(height: 8),
        Row(children: [
          if (apt['prescription']) Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3), decoration: BoxDecoration(color: AppColors.success.withOpacity(0.1), borderRadius: BorderRadius.circular(6)), child: const Text('وصفة طبية', style: TextStyle(fontSize: 9, color: AppColors.success))),
          const Spacer(),
          Text('${apt['fee']} ر.س', style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary)),
        ]),
        const SizedBox(height: 10),
        Row(children: [
          Expanded(child: OutlinedButton(onPressed: () {}, style: OutlinedButton.styleFrom(foregroundColor: AppColors.primary), child: const Text('تقرير'))),
          const SizedBox(width: 8),
          Expanded(child: ElevatedButton(onPressed: () => _showBookingSheet(), style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary), child: const Text('إعادة حجز'))),
        ]),
      ]),
    );
  }

  Widget _aptInfo(IconData icon, String text, Color color) {
    return Column(children: [
      Icon(icon, size: 18, color: color),
      const SizedBox(height: 4),
      Text(text, style: TextStyle(fontSize: 10, color: color, fontWeight: FontWeight.w500)),
    ]);
  }

  void _cancelAppointment(int index) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('إلغاء الموعد'),
        content: const Text('هل أنت متأكد من إلغاء هذا الموعد؟'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('تراجع')),
          ElevatedButton(
            onPressed: () {
              setState(() => _upcomingAppointments.removeAt(index));
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('تم إلغاء الموعد بنجاح'), backgroundColor: AppColors.success));
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
            child: const Text('تأكيد الإلغاء'),
          ),
        ],
      ),
    );
  }

  void _showBookingSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
          Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(2)))),
          const SizedBox(height: 16),
          const Text('حجز موعد جديد', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 14),
          _bookingField('التخصص', Icons.medical_services, 'اختر التخصص'),
          _bookingField('الطبيب', Icons.person, 'اختر الطبيب'),
          _bookingField('التاريخ', Icons.calendar_today, 'اختر التاريخ'),
          _bookingField('الوقت', Icons.access_time, 'اختر الوقت'),
          _bookingField('نوع الموعد', Icons.videocam, 'حضوري / فيديو'),
          const SizedBox(height: 16),
          SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () { Navigator.pop(context); ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('تم الحجز بنجاح! سيتم تأكيد الموعد قريباً'), backgroundColor: AppColors.success)); }, style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, padding: const EdgeInsets.symmetric(vertical: 14)), child: const Text('تأكيد الحجز'))),
        ]),
      ),
    );
  }

  Widget _bookingField(String label, IconData icon, String hint) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(color: AppColors.surfaceContainerLow.withOpacity(0.5), borderRadius: BorderRadius.circular(12)),
      child: Row(children: [Icon(icon, color: AppColors.primary, size: 18), const SizedBox(width: 8), Text(hint, style: const TextStyle(color: AppColors.grey, fontSize: 13)), const Spacer(), const Icon(Icons.arrow_drop_down, color: AppColors.grey)]),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
