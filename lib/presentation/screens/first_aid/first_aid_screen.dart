import 'package:flutter/material.dart';
import 'package:sehatak/core/constants/app_colors.dart';
class FirstAidScreen extends StatelessWidget {
  const FirstAidScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text('إسعافات أولية')), body: const Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.medical_services, size: 80, color: AppColors.error), SizedBox(height: 20), Text('دليل الإسعافات', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)), Text('8 أدلة طوارئ')])));
  }
}
