import 'package:flutter/material.dart';
import 'package:sehatak/core/constants/app_colors.dart';
class DrugDictionaryScreen extends StatelessWidget {
  const DrugDictionaryScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text('قاموس الأدوية')), body: const Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.medication, size: 80, color: AppColors.primary), SizedBox(height: 20), Text('قاموس الأدوية', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)), Text('12 دواء مع الجرعات')])));
  }
}
