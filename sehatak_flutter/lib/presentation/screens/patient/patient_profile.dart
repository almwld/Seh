import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_dimensions.dart';

class PatientProfile extends StatelessWidget {
  const PatientProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.profile),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(AppStrings.save),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppDimensions.paddingL),
        child: Column(
          children: [
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: AppColors.primary.withOpacity(0.1),
                    child: const Icon(Icons.person, size: 50, color: AppColors.primary),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.camera_alt, color: AppColors.white, size: 18),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            TextField(
              decoration: InputDecoration(
                labelText: AppStrings.fullName,
                prefixIcon: const Icon(Icons.person_outline, color: AppColors.primary),
              ),
              controller: TextEditingController(text: 'أحمد محمد'),
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: AppStrings.phoneNumber,
                prefixIcon: const Icon(Icons.phone_outlined, color: AppColors.primary),
                prefixText: '+967 ',
              ),
              controller: TextEditingController(text: '770123456'),
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: AppStrings.email,
                prefixIcon: const Icon(Icons.email_outlined, color: AppColors.primary),
              ),
              controller: TextEditingController(text: 'ahmed@example.com'),
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: AppStrings.nationalID,
                prefixIcon: const Icon(Icons.badge_outlined, color: AppColors.primary),
              ),
              controller: TextEditingController(text: '123456789'),
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: AppStrings.dateOfBirth,
                prefixIcon: const Icon(Icons.calendar_today, color: AppColors.primary),
              ),
              controller: TextEditingController(text: '1992-01-01'),
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: AppStrings.gender,
                prefixIcon: const Icon(Icons.people_outline, color: AppColors.primary),
              ),
              controller: TextEditingController(text: AppStrings.male),
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'فصيلة الدم',
                prefixIcon: const Icon(Icons.water_drop_outlined, color: AppColors.primary),
              ),
              controller: TextEditingController(text: 'O+'),
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'العنوان',
                prefixIcon: const Icon(Icons.location_on_outlined, color: AppColors.primary),
              ),
              controller: TextEditingController(text: 'صنعاء - شارع الستين'),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
