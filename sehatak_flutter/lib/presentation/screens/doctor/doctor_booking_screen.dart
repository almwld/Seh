import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../bloc/appointment_bloc/appointment_bloc.dart';

class DoctorBookingScreen extends StatefulWidget {
  final String doctorId;
  const DoctorBookingScreen({super.key, required this.doctorId});

  @override
  State<DoctorBookingScreen> createState() => _DoctorBookingScreenState();
}

class _DoctorBookingScreenState extends State<DoctorBookingScreen> {
  DateTime _selectedDate = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  String? _selectedTime;
  final TextEditingController _notesController = TextEditingController();

  final List<String> _availableTimes = [
    '9:00 ص', '9:30 ص', '10:00 ص', '10:30 ص', '11:00 ص', '11:30 ص',
    '2:00 م', '2:30 م', '3:00 م', '3:30 م', '4:00 م', '4:30 م',
  ];

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  void _bookAppointment() {
    if (_selectedTime != null) {
      context.read<AppointmentBloc>().add(BookAppointment(
        doctorId: widget.doctorId,
        date: _selectedDate,
        time: _selectedTime!,
        notes: _notesController.text.isEmpty ? null : _notesController.text,
      ));
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.check_circle, color: AppColors.success, size: 80),
              const SizedBox(height: 16),
              Text(
                AppStrings.appointmentConfirmed,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                'تم حجز موعدك بنجاح',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.grey),
              ),
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
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppStrings.bookNow)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppDimensions.paddingL),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: AppColors.primary.withOpacity(0.2),
                    child: const Icon(Icons.person, color: AppColors.primary),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'د. أحمد علي',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
                        ),
                        Text(
                          'طب القلب',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.grey),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    '5000 ${AppStrings.currencyYER}',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Text(
              AppStrings.selectDate,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
                borderRadius: BorderRadius.circular(16),
              ),
              child: TableCalendar(
                firstDay: DateTime.now(),
                lastDay: DateTime.now().add(const Duration(days: 30)),
                focusedDay: _focusedDay,
                selectedDayPredicate: (day) => isSameDay(_selectedDate, day),
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDate = selectedDay;
                    _focusedDay = focusedDay;
                    _selectedTime = null;
                  });
                },
                calendarFormat: CalendarFormat.week,
                availableCalendarFormats: const {CalendarFormat.week: 'Week'},
                headerStyle: const HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                ),
                calendarStyle: CalendarStyle(
                  selectedDecoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  todayDecoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.3),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              AppStrings.selectTime,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _availableTimes.map((time) {
                final isSelected = _selectedTime == time;
                return ChoiceChip(
                  selected: isSelected,
                  label: Text(time),
                  onSelected: (selected) {
                    setState(() => _selectedTime = selected ? time : null);
                  },
                  selectedColor: AppColors.primary,
                  labelStyle: TextStyle(
                    color: isSelected ? AppColors.white : AppColors.darkGrey,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),
            Text(
              'ملاحظات (اختياري)',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _notesController,
              maxLines: 3,
              decoration: const InputDecoration(
                hintText: 'أضف أي ملاحظات خاصة بالموعد...',
              ),
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
            onPressed: _selectedTime != null ? _bookAppointment : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: _selectedTime != null ? AppColors.primary : AppColors.grey,
            ),
            child: Text(AppStrings.confirmBooking),
          ),
        ),
      ),
    );
  }
}
