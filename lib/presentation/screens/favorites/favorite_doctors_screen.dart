import 'package:flutter/material.dart';
import 'package:sehatak/core/constants/app_colors.dart';
class FavoriteDoctorsScreen extends StatelessWidget {
  const FavoriteDoctorsScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('أطبائي المفضلين')), body: const Center(child: Text('قائمة الأطباء المفضلين')));
}
