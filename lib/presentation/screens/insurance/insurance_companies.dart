import 'package:flutter/material.dart';
import 'package:sehatak/core/constants/app_colors.dart';

class InsuranceCompanies extends StatefulWidget {
  const InsuranceCompanies({super.key});
  @override
  State<InsuranceCompanies> createState() => _InsuranceCompaniesState();
}

class _InsuranceCompaniesState extends State<InsuranceCompanies> {
  String _selectedType = 'All';

  final List<Map<String, dynamic>> _insuranceTypes = [
    {'name': 'All', 'icon': Icons.all_inclusive},
    {'name': 'Health', 'icon': Icons.favorite},
    {'name': 'Family', 'icon': Icons.people},
    {'name': 'Travel', 'icon': Icons.flight},
  ];

  final List<Map<String, dynamic>> _companies = [
    {'name': 'Jubilee Health Insurance', 'type': 'Health', 'coverage': 'Up to Rs. 1,000,000', 'hospitals': '500+', 'rating': 4.7, 'premium': 'From Rs. 2,500/mo', 'logo': '🏥', 'color': AppColors.primary},
    {'name': 'Adamjee Insurance', 'type': 'Health', 'coverage': 'Up to Rs. 800,000', 'hospitals': '400+', 'rating': 4.5, 'premium': 'From Rs. 2,000/mo', 'logo': '🛡️', 'color': AppColors.info},
    {'name': 'Allianz EFU Health', 'type': 'Family', 'coverage': 'Up to Rs. 2,000,000', 'hospitals': '700+', 'rating': 4.8, 'premium': 'From Rs. 3,500/mo', 'logo': '🏦', 'color': AppColors.success},
    {'name': 'IGI General Insurance', 'type': 'Travel', 'coverage': 'Up to Rs. 500,000', 'hospitals': '200+', 'rating': 4.3, 'premium': 'From Rs. 1,500/mo', 'logo': '🏷️', 'color': AppColors.teal},
    {'name': 'TPL Insurance', 'type': 'Health', 'coverage': 'Up to Rs. 1,500,000', 'hospitals': '600+', 'rating': 4.6, 'premium': 'From Rs. 3,000/mo', 'logo': '💳', 'color': AppColors.purple},
    {'name': 'State Life Insurance', 'type': 'Family', 'coverage': 'Up to Rs. 5,000,000', 'hospitals': '1000+', 'rating': 4.9, 'premium': 'From Rs. 5,000/mo', 'logo': '🏛️', 'color': AppColors.orange},
  ];

  List<Map<String, dynamic>> get _filteredCompanies => _selectedType == 'All' ? _companies : _companies.where((c) => c['type'] == _selectedType).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Insurance Plans', style: TextStyle(fontWeight: FontWeight.bold)), actions: [IconButton(icon: const Icon(Icons.compare_arrows), onPressed: () {})]),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(14),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // بطاقة الترحيب
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(gradient: LinearGradient(colors: [AppColors.indigo, AppColors.indigo.withOpacity(0.7)]), borderRadius: BorderRadius.circular(16)),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text('Find the Best\nHealth Insurance', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              const Text('Compare plans & save money', style: TextStyle(color: Colors.white70, fontSize: 13)),
              const SizedBox(height: 12),
              ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: AppColors.indigo), child: const Text('Compare Plans')),
            ]),
          ),
          const SizedBox(height: 20),
          // تصنيفات
          SizedBox(
            height: 45,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: _insuranceTypes.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final t = _insuranceTypes[index];
                final selected = _selectedType == t['name'];
                return ChoiceChip(
                  label: Row(children: [Icon(t['icon'], size: 16), const SizedBox(width: 4), Text(t['name'])]),
                  selected: selected,
                  selectedColor: AppColors.primary,
                  labelStyle: TextStyle(color: selected ? Colors.white : AppColors.darkGrey, fontSize: 12),
                  onSelected: (_) => setState(() => _selectedType = t['name']),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          // شركات التأمين
          ..._filteredCompanies.map((c) => _buildCompanyCard(c)),
          const SizedBox(height: 20),
        ]),
      ),
    );
  }

  Widget _buildCompanyCard(Map<String, dynamic> company) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8)]),
      child: Column(children: [
        Row(children: [
          Container(width: 50, height: 50, decoration: BoxDecoration(color: (company['color'] as Color).withOpacity(0.1), borderRadius: BorderRadius.circular(12)), child: Center(child: Text(company['logo'], style: const TextStyle(fontSize: 24)))),
          const SizedBox(width: 12),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(company['name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            Row(children: [const Icon(Icons.star, color: AppColors.amber, size: 14), const SizedBox(width: 2), Text('${company['rating']}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12))]),
          ])),
          Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: (company['color'] as Color).withOpacity(0.1), borderRadius: BorderRadius.circular(8)), child: Text(company['type'], style: TextStyle(color: company['color'], fontSize: 10, fontWeight: FontWeight.bold))),
        ]),
        const Divider(height: 20),
        Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          _infoColumn(Icons.shield, 'Coverage', company['coverage']),
          _infoColumn(Icons.local_hospital, 'Hospitals', company['hospitals']),
          _infoColumn(Icons.payments, 'Premium', company['premium']),
        ]),
        const SizedBox(height: 12),
        SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, padding: const EdgeInsets.symmetric(vertical: 12)), child: const Text('View Plan Details'))),
      ]),
    );
  }

  Widget _infoColumn(IconData icon, String label, String value) {
    return Column(children: [Icon(icon, color: AppColors.primary, size: 18), const SizedBox(height: 4), Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11)), Text(label, style: const TextStyle(fontSize: 9, color: AppColors.grey))]);
  }
}
