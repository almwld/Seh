import 'package:flutter/material.dart';
import 'package:sehatak/core/constants/app_colors.dart';
import 'package:sehatak/presentation/screens/chat/chat_screen.dart';

class DoctorDetailsScreen extends StatelessWidget {
  final String? doctorId;
  const DoctorDetailsScreen({super.key, this.doctorId});

  // بيانات الأطباء
  final Map<String, Map<String, dynamic>> _doctorsData = const {
    '1': {
      'name': 'د. علي المولد', 'specialty': 'استشاري باطنية وأطفال', 'qualification': 'بكالوريوس طب، زمالة الباطنية، البورد العربي',
      'experience': '20+ سنة', 'rating': 4.9, 'reviews': 328, 'patients': '15,000+',
      'fee': '500', 'available': true, 'online': true, 'image': '👨‍⚕️',
      'languages': 'عربي، إنجليزي', 'hospital': 'مستشفى الثورة العام',
      'about': 'استشاري باطنية وأطفال مع خبرة واسعة في تشخيص وعلاج الأمراض الباطنية للأطفال والكبار. حاصل على البورد العربي في الطب الباطني.',
      'education': ['بكالوريوس طب وجراحة - جامعة صنعاء', 'زمالة الطب الباطني - المجلس العربي', 'دبلوم طب الأطفال - جامعة القاهرة'],
      'services': ['استشارة باطنية', 'استشارة أطفال', 'فحص شامل', 'متابعة أمراض مزمنة'],
      'availability': ['السبت - الأربعاء: 9 ص - 5 م', 'الخميس: 9 ص - 1 م', 'الجمعة: إجازة'],
    },
    '2': {
      'name': 'د. حسن رضا', 'specialty': 'طبيب عام', 'qualification': 'بكالوريوس طب، ماجستير طب أسرة',
      'experience': '8+ سنة', 'rating': 4.8, 'reviews': 235, 'patients': '8,000+',
      'fee': '300', 'available': true, 'online': true, 'image': '👨‍⚕️',
      'languages': 'عربي، إنجليزي', 'hospital': 'عيادة الصحة بلس',
      'about': 'طبيب عام متخصص في طب الأسرة. أقدم رعاية صحية شاملة لجميع أفراد الأسرة.',
      'education': ['بكالوريوس طب - جامعة تعز', 'ماجستير طب أسرة - جامعة صنعاء'],
      'services': ['استشارة عامة', 'فحص دوري', 'تطعيمات', 'متابعة ضغط وسكر'],
      'availability': ['الأحد - الخميس: 8 ص - 4 م', 'السبت: 9 ص - 2 م'],
    },
  };

  Map<String, dynamic> get _doctor {
    return _doctorsData[doctorId] ?? _doctorsData['1']!;
  }

  @override
  Widget build(BuildContext context) {
    final doc = _doctor;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // AppBar مع صورة
          SliverAppBar(
            expandedHeight: 180,
            pinned: true,
            backgroundColor: AppColors.primary,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(gradient: LinearGradient(colors: [AppColors.primary, AppColors.primaryDark])),
                child: Center(child: Text(doc['image'], style: const TextStyle(fontSize: 70))),
              ),
            ),
            title: Text(doc['name'], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            actions: [
              IconButton(icon: const Icon(Icons.share), onPressed: () {}),
              IconButton(icon: const Icon(Icons.favorite_border), onPressed: () {}),
            ],
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                // الاسم والتخصص
                Row(children: [
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(doc['name'], style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 2),
                    Text(doc['specialty'], style: const TextStyle(fontSize: 14, color: AppColors.primary, fontWeight: FontWeight.w500)),
                    const SizedBox(height: 2),
                    Text(doc['qualification'], style: const TextStyle(fontSize: 11, color: AppColors.grey)),
                  ])),
                  Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), decoration: BoxDecoration(color: doc['available'] ? AppColors.success.withOpacity(0.1) : AppColors.error.withOpacity(0.1), borderRadius: BorderRadius.circular(10)), child: Text(doc['available'] ? 'متاح' : 'مشغول', style: TextStyle(color: doc['available'] ? AppColors.success : AppColors.error, fontWeight: FontWeight.bold))),
                ]),
                const SizedBox(height: 12),

                // تقييم وخبرة
                Row(children: [
                  _statBadge(Icons.star, '${doc['rating']} (${doc['reviews']} تقييم)', AppColors.amber),
                  const SizedBox(width: 12),
                  _statBadge(Icons.work, doc['experience'], AppColors.info),
                  const SizedBox(width: 12),
                  _statBadge(Icons.people, doc['patients'], AppColors.success),
                ]),
                const SizedBox(height: 14),

                // معلومات سريعة
                Row(children: [
                  _infoChip(Icons.local_hospital, doc['hospital']),
                  const SizedBox(width: 8),
                  _infoChip(Icons.language, doc['languages']),
                ]),
                const SizedBox(height: 8),
                Text('الرسوم: ${doc['fee']} ر.س', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: AppColors.primary)),
                const SizedBox(height: 14),

                // أزرار الإجراء
                Row(children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ChatScreen())),
                      icon: const Icon(Icons.chat, size: 18),
                      label: const Text('دردشة'),
                      style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 12)),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.videocam, size: 18),
                      label: const Text('فيديو'),
                      style: OutlinedButton.styleFrom(foregroundColor: AppColors.primary, padding: const EdgeInsets.symmetric(vertical: 12)),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.call, size: 18),
                      label: const Text('اتصال'),
                      style: OutlinedButton.styleFrom(foregroundColor: AppColors.success, padding: const EdgeInsets.symmetric(vertical: 12)),
                    ),
                  ),
                ]),
                const SizedBox(height: 20),

                // نبذة
                Text('نبذة عن الطبيب', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 6),
                Text(doc['about'], style: const TextStyle(fontSize: 13, height: 1.6, color: AppColors.darkGrey)),
                const SizedBox(height: 16),

                // التعليم
                Text('التعليم', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 6),
                ...(doc['education'] as List).map((e) => Container(margin: const EdgeInsets.only(bottom: 4), padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3), borderRadius: BorderRadius.circular(8)), child: Row(children: [const Icon(Icons.school, size: 16, color: AppColors.primary), const SizedBox(width: 8), Expanded(child: Text(e, style: const TextStyle(fontSize: 12)))]))),
                const SizedBox(height: 16),

                // الخدمات
                Text('الخدمات', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 6),
                Wrap(spacing: 6, runSpacing: 6, children: (doc['services'] as List).map((s) => Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8), decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.06), borderRadius: BorderRadius.circular(20), border: Border.all(color: AppColors.primary.withOpacity(0.2))), child: Text(s, style: const TextStyle(fontSize: 11, color: AppColors.primary)))).toList()),
                const SizedBox(height: 16),

                // أوقات الدوام
                Text('أوقات الدوام', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 6),
                ...(doc['availability'] as List).map((a) => Container(margin: const EdgeInsets.only(bottom: 4), padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3), borderRadius: BorderRadius.circular(8)), child: Row(children: [const Icon(Icons.access_time, size: 16, color: AppColors.info), const SizedBox(width: 8), Expanded(child: Text(a, style: const TextStyle(fontSize: 12)))]))),
                const SizedBox(height: 20),

                // حجز موعد
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.calendar_today),
                    label: const Text('حجز موعد'),
                    style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 16), textStyle: const TextStyle(fontSize: 16)),
                  ),
                ),
                const SizedBox(height: 30),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _statBadge(IconData icon, String text, Color color) {
    return Row(children: [Icon(icon, size: 15, color: color), const SizedBox(width: 4), Text(text, style: TextStyle(fontSize: 11, color: color, fontWeight: FontWeight.w500))]);
  }

  Widget _infoChip(IconData icon, String text) {
    return Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.05), borderRadius: BorderRadius.circular(8)), child: Row(children: [Icon(icon, size: 12, color: AppColors.primary), const SizedBox(width: 4), Text(text, style: const TextStyle(fontSize: 10, color: AppColors.primary))]));
  }
}
