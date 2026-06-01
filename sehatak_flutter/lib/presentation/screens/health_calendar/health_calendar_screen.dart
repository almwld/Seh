import 'package:flutter/material.dart';
import 'package:sehatak/core/constants/app_colors.dart';
import 'package:table_calendar/table_calendar.dart';

class HealthCalendarScreen extends StatefulWidget {
  const HealthCalendarScreen({super.key});
  @override
  State<HealthCalendarScreen> createState() => _HealthCalendarScreenState();
}

class _HealthCalendarScreenState extends State<HealthCalendarScreen> {
  DateTime _selectedDate = DateTime.now();
  DateTime _focusedDate = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.week;

  // بيانات الأحداث لكل يوم
  List<Map<String, String>> _getEventsForDay(DateTime day) {
    final events = <Map<String, String>>[];
    
    // مواعيد ثابتة
    if (day.day == 15 && day.month == 5) {
      events.add({'title': 'موعد د. علي المولد', 'time': '10:30 صباحاً', 'type': 'موعد', 'icon': '👨‍⚕️', 'color': '#4CAF50'});
    }
    if (day.day == 18 && day.month == 5) {
      events.add({'title': 'موعد د. حسن رضا', 'time': '2:00 مساءً', 'type': 'موعد', 'icon': '👨‍⚕️', 'color': '#2196F3'});
    }
    if (day.day == 20 && day.month == 5) {
      events.add({'title': 'فحص دوري شامل', 'time': '8:00 صباحاً', 'type': 'فحص', 'icon': '🩺', 'color': '#FF9800'});
    }
    if (day.day == 22 && day.month == 5) {
      events.add({'title': 'موعد د. فاطمة صديقي', 'time': '9:00 صباحاً', 'type': 'موعد', 'icon': '👩‍⚕️', 'color': '#9C27B0'});
      events.add({'title': 'تذكير: تجديد وصفة', 'time': 'طوال اليوم', 'type': 'تذكير', 'icon': '💊', 'color': '#F44336'});
    }
    if (day.day == 25 && day.month == 5) {
      events.add({'title': 'تحليل دم شامل', 'time': '7:30 صباحاً', 'type': 'تحليل', 'icon': '🩸', 'color': '#00BCD4'});
    }
    
    // تذكيرات أسبوعية
    if (day.weekday == DateTime.saturday) {
      events.add({'title': 'قياس ضغط الدم', 'time': 'صباحاً', 'type': 'تذكير', 'icon': '🩺', 'color': '#FF5722'});
    }
    if (day.weekday == DateTime.sunday || day.weekday == DateTime.wednesday || day.weekday == DateTime.friday) {
      events.add({'title': 'تناول فيتامين د', 'time': '2:00 مساءً', 'type': 'دواء', 'icon': '💊', 'color': '#FFC107'});
    }
    
    // تذكير شهري
    if (day.day == 1) {
      events.add({'title': 'تذكير: تجديد الاشتراك', 'time': 'طوال اليوم', 'type': 'تذكير', 'icon': '💎', 'color': '#E91E63'});
    }
    
    return events;
  }

  // إحصائيات الشهر
  Map<String, int> _getMonthStats(DateTime month) {
    int appointments = 0, reminders = 0, tests = 0, medications = 0;
    final daysInMonth = DateTime(month.year, month.month + 1, 0).day;
    for (int d = 1; d <= daysInMonth; d++) {
      for (var event in _getEventsForDay(DateTime(month.year, month.month, d))) {
        switch (event['type']) {
          case 'موعد': appointments++; break;
          case 'تذكير': reminders++; break;
          case 'تحليل': case 'فحص': tests++; break;
          case 'دواء': medications++; break;
        }
      }
    }
    return {'مواعيد': appointments, 'تذكيرات': reminders, 'فحوصات': tests, 'أدوية': medications};
  }

  @override
  Widget build(BuildContext context) {
    final events = _getEventsForDay(_selectedDate);
    final stats = _getMonthStats(_focusedDate);

    return Scaffold(
      appBar: AppBar(
        title: const Text('التقويم الصحي', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(icon: const Icon(Icons.add), onPressed: () {}, tooltip: 'إضافة حدث'),
          IconButton(icon: const Icon(Icons.today), onPressed: () => setState(() { _selectedDate = DateTime.now(); _focusedDate = DateTime.now(); }), tooltip: 'اليوم'),
        ],
      ),
      body: Column(children: [
        // التقويم
        Container(
          margin: const EdgeInsets.fromLTRB(14, 14, 14, 0),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 6)]),
          child: TableCalendar(
            firstDay: DateTime(2024),
            lastDay: DateTime(2028),
            focusedDay: _focusedDate,
            calendarFormat: _calendarFormat,
            onFormatChanged: (format) => setState(() => _calendarFormat = format),
            selectedDayPredicate: (day) => isSameDay(_selectedDate, day),
            onDaySelected: (selectedDay, focusedDay) => setState(() { _selectedDate = selectedDay; _focusedDate = focusedDay; }),
            onPageChanged: (focusedDay) => setState(() => _focusedDate = focusedDay),
            calendarStyle: CalendarStyle(
              selectedDecoration: BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
              todayDecoration: BoxDecoration(color: AppColors.primary.withOpacity(0.3), shape: BoxShape.circle),
              markerDecoration: const BoxDecoration(color: AppColors.error, shape: BoxShape.circle),
              weekendTextStyle: const TextStyle(color: AppColors.error),
            ),
            headerStyle: HeaderStyle(formatButtonVisible: true, titleCentered: true, formatButtonShowsNext: false, formatButtonDecoration: BoxDecoration(color: AppColors.primary.withOpacity(0.1), borderRadius: BorderRadius.circular(8)), formatButtonTextStyle: const TextStyle(color: AppColors.primary)),
            locale: 'ar',
          ),
        ),

        // إحصائيات الشهر
        Container(
          margin: const EdgeInsets.all(14),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 6)]),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            _statBadge('مواعيد', stats['مواعيد'] ?? 0, AppColors.primary),
            _statBadge('تذكيرات', stats['تذكيرات'] ?? 0, AppColors.warning),
            _statBadge('فحوصات', stats['فحوصات'] ?? 0, AppColors.info),
            _statBadge('أدوية', stats['أدوية'] ?? 0, AppColors.success),
          ]),
        ),

        // عنوان اليوم
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Row(children: [
            Text('${_selectedDate.day} ${_getMonthName(_selectedDate.month)} ${_selectedDate.year}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            const Spacer(),
            Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.08), borderRadius: BorderRadius.circular(12)), child: Text('${events.length} أحداث', style: const TextStyle(fontSize: 12, color: AppColors.primary))),
          ]),
        ),
        const SizedBox(height: 8),

        // أحداث اليوم
        Expanded(
          child: events.isEmpty
              ? Center(
                  child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                    const Icon(Icons.event_busy, size: 60, color: AppColors.grey),
                    const SizedBox(height: 8),
                    const Text('لا توجد أحداث لهذا اليوم', style: TextStyle(color: AppColors.grey, fontSize: 16)),
                    const SizedBox(height: 12),
                    ElevatedButton.icon(onPressed: () {}, icon: const Icon(Icons.add), label: const Text('إضافة حدث'), style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary)),
                  ]),
                )
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  itemCount: events.length,
                  itemBuilder: (context, idx) {
                    final e = events[idx];
                    final color = Color(int.parse(e['color']!.replaceFirst('#', '0xff')));
                    return Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), boxShadow: [BoxShadow(color: color.withOpacity(0.08), blurRadius: 8)]),
                      child: Row(children: [
                        // شريط اللون
                        Container(width: 4, height: 50, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(2))),
                        const SizedBox(width: 12),
                        // الأيقونة
                        Text(e['icon']!, style: const TextStyle(fontSize: 28)),
                        const SizedBox(width: 10),
                        // التفاصيل
                        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text(e['title']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                          const SizedBox(height: 2),
                          Row(children: [
                            Icon(Icons.access_time, size: 12, color: color),
                            const SizedBox(width: 4),
                            Text(e['time']!, style: TextStyle(fontSize: 11, color: color)),
                            const SizedBox(width: 10),
                            Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2), decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(6)), child: Text(e['type']!, style: TextStyle(fontSize: 9, color: color, fontWeight: FontWeight.bold))),
                          ]),
                        ])),
                        // أزرار
                        Column(children: [
                          IconButton(icon: const Icon(Icons.edit, size: 16, color: AppColors.grey), onPressed: () {}, constraints: const BoxConstraints()),
                          const SizedBox(height: 4),
                          IconButton(icon: const Icon(Icons.delete_outline, size: 16, color: AppColors.error), onPressed: () {}, constraints: const BoxConstraints()),
                        ]),
                      ]),
                    );
                  },
                ),
        ),
      ]),
    );
  }

  Widget _statBadge(String label, int count, Color color) {
    return Column(children: [
      Text('$count', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: color)),
      Text(label, style: const TextStyle(fontSize: 10, color: AppColors.grey)),
    ]);
  }

  String _getMonthName(int month) {
    const months = ['', 'يناير', 'فبراير', 'مارس', 'إبريل', 'مايو', 'يونيو', 'يوليو', 'أغسطس', 'سبتمبر', 'أكتوبر', 'نوفمبر', 'ديسمبر'];
    return months[month];
  }
}
