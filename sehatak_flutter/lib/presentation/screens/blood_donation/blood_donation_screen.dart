import 'package:flutter/material.dart';
import 'package:sehatak/core/constants/app_colors.dart';
class BloodDonationScreen extends StatelessWidget {
  const BloodDonationScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text('التبرع بالدم')), body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [const Icon(Icons.bloodtype, size: 80, color: AppColors.error), const SizedBox(height: 20), const Text('بنك الدم', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)), const SizedBox(height: 8), const Text('أنقذ حياة.. تبرع بالدم'), ElevatedButton(onPressed: (){}, child: const Text('سجل كمتبرع'))])));
  }
}
