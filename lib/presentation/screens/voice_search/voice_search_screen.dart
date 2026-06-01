import 'package:flutter/material.dart';
import 'package:sehatak/core/constants/app_colors.dart';
class VoiceSearchScreen extends StatelessWidget {
  const VoiceSearchScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('بحث صوتي')), body: const Center(child: Icon(Icons.mic, size: 80, color: AppColors.primary)));
}
