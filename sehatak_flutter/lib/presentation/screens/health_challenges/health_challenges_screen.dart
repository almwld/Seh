import 'package:flutter/material.dart';
import 'package:sehatak/core/constants/app_colors.dart';
class HealthChallengesScreen extends StatelessWidget {
  const HealthChallengesScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('تحديات صحية')), body: const Center(child: Text('التحديات الصحية')));
}
