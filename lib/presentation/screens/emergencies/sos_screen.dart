import 'package:flutter/material.dart';
import 'dart:async';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';

class SosScreen extends StatefulWidget {
  const SosScreen({super.key});

  @override
  State<SosScreen> createState() => _SosScreenState();
}

class _SosScreenState extends State<SosScreen> {
  int _countdown = 5;
  bool _isActivated = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  void _startCountdown() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_countdown > 0) {
        setState(() => _countdown--);
      } else {
        timer.cancel();
        setState(() => _isActivated = true);
      }
    });
  }

  void _cancelSOS() {
    _timer?.cancel();
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _isActivated ? AppColors.error : AppColors.error.withOpacity(0.95),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (!_isActivated) ...[
                Text(
                  'سيتم إرسال إنذار طوارئ خلال',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.white),
                ),
                const SizedBox(height: 24),
                Text(
                  '$_countdown',
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(color: AppColors.white, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 24),
                TextButton(
                  onPressed: _cancelSOS,
                  style: TextButton.styleFrom(
                    backgroundColor: AppColors.white,
                    foregroundColor: AppColors.error,
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  ),
                  child: const Text('إلغاء الإنذار'),
                ),
              ] else ...[
                const Icon(Icons.warning, size: 100, color: AppColors.white),
                const SizedBox(height: 24),
                Text(
                  'تم إرسال إنذار الطوارئ!',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: AppColors.white, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                Text(
                  'تم إخطار جهات الاتصال في الطوارئ والخدمات الطبية',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.white.withOpacity(0.9)),
                ),
                const SizedBox(height: 32),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.call, size: 20),
                  label: const Text('الاتصال بالإسعاف'),
                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.white, foregroundColor: AppColors.error),
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('إغلاق', style: TextStyle(color: AppColors.white)),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
