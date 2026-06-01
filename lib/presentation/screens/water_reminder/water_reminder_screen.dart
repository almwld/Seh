import 'package:flutter/material.dart';
import 'package:sehatak/core/constants/app_colors.dart';
class WaterReminderScreen extends StatelessWidget {
  const WaterReminderScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text('تذكير الماء')), body: const Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.water_drop, size: 80, color: Colors.blue), SizedBox(height: 20), Text('تذكير شرب الماء', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)), Text('8 أكواب يومياً'), ElevatedButton(onPressed: null, child: Text('4/8 أكواب اليوم'))])));
  }
}
