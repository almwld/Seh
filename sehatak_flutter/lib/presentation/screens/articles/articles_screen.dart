import 'package:flutter/material.dart';
import 'package:sehatak/core/constants/app_colors.dart';
class ArticlesScreen extends StatelessWidget {
  const ArticlesScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text('مقالات طبية')), body: const Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.article, size: 80, color: AppColors.info), SizedBox(height: 20), Text('مقالات طبية', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)), Text('8 مقالات في 7 تصنيفات')])));
  }
}
