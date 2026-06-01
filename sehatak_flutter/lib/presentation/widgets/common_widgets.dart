import 'package:flutter/material.dart';
import 'package:sehatak/core/constants/app_colors.dart';

class DoctorCard extends StatelessWidget {
  final String name, specialty, experience;
  final double rating;
  final int reviews;
  final VoidCallback onTap;
  const DoctorCard({required this.name, required this.specialty, required this.experience, this.rating = 4.5, this.reviews = 100, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.2), borderRadius: BorderRadius.circular(14), border: Border.all(color: AppColors.outlineVariant.withOpacity(0.4))),
        child: Row(children: [
          CircleAvatar(radius: 26, backgroundColor: AppColors.primary.withOpacity(0.1), child: const Icon(Icons.person, color: AppColors.primary, size: 28)),
          const SizedBox(width: 10),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            Text(specialty, style: const TextStyle(color: AppColors.grey, fontSize: 11)),
            Text(experience, style: const TextStyle(color: AppColors.darkGrey, fontSize: 10)),
            Row(children: [
              const Icon(Icons.star, color: AppColors.amber, size: 13),
              Text(' $rating ($reviews تقييم)', style: const TextStyle(fontSize: 10, color: AppColors.darkGrey)),
            ]),
          ])),
          const Icon(Icons.chevron_left, color: AppColors.grey),
        ]),
      ),
    );
  }
}

class CustomSearchBar extends StatelessWidget {
  final String hint;
  const CustomSearchBar({super.key, this.hint = 'بحث...'});
  @override
  Widget build(BuildContext context) {
    return TextField(
      textAlign: TextAlign.right,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: const Icon(Icons.search, color: AppColors.grey),
        filled: true,
        fillColor: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
        contentPadding: const EdgeInsets.symmetric(vertical: 13),
      ),
    );
  }
}
