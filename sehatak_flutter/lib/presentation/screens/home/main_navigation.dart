import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import 'home_screen.dart';
import '../doctor/doctors_list_screen.dart';
import '../patient/patient_appointments.dart';
import '../patient/patient_dashboard.dart';
import '../settings/settings_screen.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const DoctorsListScreen(),
    const PatientAppointments(),
    const PatientDashboard(),
    const SettingsScreen(),
  ];

  final List<String> _titles = [
    AppStrings.home,
    AppStrings.doctors,
    AppStrings.appointments,
    AppStrings.healthFile,
    AppStrings.more,
  ];

  final List<IconData> _icons = [
    Icons.home_outlined,
    Icons.local_hospital_outlined,
    Icons.calendar_today_outlined,
    Icons.folder_open_outlined,
    Icons.menu_outlined,
  ];

  final List<IconData> _activeIcons = [
    Icons.home,
    Icons.local_hospital,
    Icons.calendar_today,
    Icons.folder_open,
    Icons.menu,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          boxShadow: [
            BoxShadow(
              color: AppColors.shadow.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(_screens.length, (index) {
                final isSelected = _currentIndex == index;
                return GestureDetector(
                  onTap: () => setState(() => _currentIndex = index),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.primary.withOpacity(0.1) : Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          isSelected ? _activeIcons[index] : _icons[index],
                          color: isSelected ? AppColors.primary : AppColors.grey,
                          size: 24,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _titles[index],
                          style: TextStyle(
                            color: isSelected ? AppColors.primary : AppColors.grey,
                            fontSize: 11,
                            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
