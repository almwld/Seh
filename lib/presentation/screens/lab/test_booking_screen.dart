import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_dimensions.dart';

class TestBookingScreen extends StatefulWidget {
  final String testId;
  const TestBookingScreen({super.key, required this.testId});

  @override
  State<TestBookingScreen> createState() => _TestBookingScreenState();
}

class _TestBookingScreenState extends State<TestBookingScreen> {
  DateTime _selectedDate = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  bool _homeVisit = false;
  final List<String> _availableTimes = ['8:00 ص', '9:00 ص', '10:00 ص', '11:00 ص', '12:00 م', '1:00 م', '2:00 م', '3:00 م'];
  String? _selectedTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('حجز تحليل')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppDimensions.paddingL),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: AppColors.info.withOpacity(0.1), borderRadius: BorderRadius.circular(16)),
              child: Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(color: AppColors.info.withOpacity(0.2), borderRadius: BorderRadius.circular(12)),
                    child: const Icon(Icons.science, color: AppColors.info),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('CBC - صورة دم كاملة', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
                        Text('3500 ${AppStrings.currencyYER}', style: Theme.of(context).textTheme.titleSmall?.copyWith(color: AppColors.primary)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Text(AppStrings.selectDate, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3), borderRadius: BorderRadius.circular(16)),
              child: TableCalendar(
                firstDay: DateTime.now(),
                lastDay: DateTime.now().add(const Duration(days: 30)),
                focusedDay: _focusedDay,
                selectedDayPredicate: (day) => isSameDay(_selectedDate, day),
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDate = selectedDay;
                    _focusedDay = focusedDay;
                  });
                },
                calendarFormat: CalendarFormat.week,
                availableCalendarFormats: const {CalendarFormat.week: 'Week'},
                headerStyle: const HeaderStyle(formatButtonVisible: false, titleCentered: true),
                calendarStyle: CalendarStyle(
                  selectedDecoration: const BoxDecoration(color: AppColors.info, shape: BoxShape.circle),
                  todayDecoration: BoxDecoration(color: AppColors.info.withOpacity(0.3), shape: BoxShape.circle),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(AppStrings.selectTime, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _availableTimes.map((time) {
                final isSelected = _selectedTime == time;
                return ChoiceChip(
                  selected: isSelected,
                  label: Text(time),
                  onSelected: (selected) => setState(() => _selectedTime = selected ? time : null),
                  selectedColor: AppColors.info,
                  labelStyle: TextStyle(color: isSelected ? AppColors.white : AppColors.darkGrey, fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),
            SwitchListTile(
              title: const Text('زيارة منزلية'),
              subtitle: const Text('سيصلك فريق المختبر إلى منزلك'),
              value: _homeVisit,
              onChanged: (value) => setState(() => _homeVisit = value),
              activeColor: AppColors.info,
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(AppDimensions.paddingL),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          boxShadow: [BoxShadow(color: AppColors.shadow.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, -2))],
        ),
        child: SafeArea(
          child: ElevatedButton(
            onPressed: _selectedTime != null ? () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.check_circle, color: AppColors.success, size: 80),
                      const SizedBox(height: 16),
                      Text('تم الحجز بنجاح!', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      child: Text(AppStrings.ok),
                    ),
                  ],
                ),
              );
            } : null,
            style: ElevatedButton.styleFrom(backgroundColor: _selectedTime != null ? AppColors.info : AppColors.grey),
            child: Text('تأكيد الحجز - 3500 ${AppStrings.currencyYER}'),
          ),
        ),
      ),
    );
  }
}
