import 'package:flutter/material.dart';
import 'package:sehatak/core/constants/app_colors.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});
  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final List<Map<String, dynamic>> _notifications = [
    {'title': 'تذكير موعد', 'message': 'لديك موعد مع د. علي المولد غداً الساعة 10:30 صباحاً', 'time': 'منذ 5 دقائق', 'icon': Icons.calendar_today, 'color': AppColors.primary, 'read': false},
    {'title': 'نتائج تحليل جاهزة', 'message': 'نتائج تحليل CBC جاهزة للاطلاع. اضغط للعرض.', 'time': 'منذ ساعة', 'icon': Icons.science, 'color': AppColors.info, 'read': false},
    {'title': 'تم تجديد الوصفة', 'message': 'د. حسن رضا قام بتجديد وصفتك الطبية لارتفاع ضغط الدم', 'time': 'منذ 3 ساعات', 'icon': Icons.receipt, 'color': AppColors.success, 'read': false},
    {'title': 'نصيحة اليوم', 'message': 'اشرب 8 أكواب من الماء يومياً للحفاظ على صحتك! 💧', 'time': 'منذ 6 ساعات', 'icon': Icons.tips_and_updates, 'color': AppColors.amber, 'read': true},
    {'title': 'عرض خاص', 'message': 'خصم 30% على جميع التحاليل في مختبر الثقة. العرض سارٍ حتى نهاية الأسبوع!', 'time': 'أمس', 'icon': Icons.local_offer, 'color': AppColors.purple, 'read': true},
    {'title': 'تذكير فيديو', 'message': 'استشارة الفيديو مع د. عثمان خان تبدأ بعد 30 دقيقة', 'time': 'أمس', 'icon': Icons.videocam, 'color': AppColors.teal, 'read': true},
    {'title': 'تأكيد حجز', 'message': 'تم تأكيد حجزك في مستشفى الثورة - غرفة 204', 'time': 'منذ يومين', 'icon': Icons.check_circle, 'color': AppColors.success, 'read': true},
    {'title': 'موعد تطعيم', 'message': 'تذكير: موعد تطعيم الكزاز القادم في يونيو 2028', 'time': 'منذ 3 أيام', 'icon': Icons.vaccines, 'color': AppColors.info, 'read': true},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الإشعارات', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          TextButton(onPressed: () => setState(() { for (var n in _notifications) n['read'] = true; }), child: const Text('تحديد الكل مقروء')),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(12),
        itemCount: _notifications.length,
        separatorBuilder: (_, __) => const SizedBox(height: 4),
        itemBuilder: (context, index) {
          final n = _notifications[index];
          return Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: n['read'] ? Colors.transparent : (n['color'] as Color).withOpacity(0.03),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: n['read'] ? AppColors.outlineVariant.withOpacity(0.2) : (n['color'] as Color).withOpacity(0.15)),
            ),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(padding: const EdgeInsets.all(9), decoration: BoxDecoration(color: (n['color'] as Color).withOpacity(0.08), shape: BoxShape.circle), child: Icon(n['icon'], color: n['color'], size: 18)),
              const SizedBox(width: 12),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(children: [
                  if (!n['read']) Container(width: 8, height: 8, decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle)),
                  if (!n['read']) const SizedBox(width: 6),
                  Expanded(child: Text(n['title'], style: TextStyle(fontWeight: n['read'] ? FontWeight.normal : FontWeight.bold, fontSize: 14))),
                  Text(n['time'], style: const TextStyle(fontSize: 9, color: AppColors.grey)),
                ]),
                const SizedBox(height: 4),
                Text(n['message'], style: const TextStyle(fontSize: 12, color: AppColors.darkGrey, height: 1.3)),
              ])),
              PopupMenuButton(icon: const Icon(Icons.more_vert, size: 16, color: AppColors.grey), itemBuilder: (_) => [const PopupMenuItem(value: 'mark', child: Text('تحديد كمقروء')), const PopupMenuItem(value: 'delete', child: Text('حذف', style: TextStyle(color: AppColors.error)))], onSelected: (v) { if (v == 'mark') setState(() => n['read'] = true); if (v == 'delete') setState(() => _notifications.removeAt(index)); }),
            ]),
          );
        },
      ),
    );
  }
}
