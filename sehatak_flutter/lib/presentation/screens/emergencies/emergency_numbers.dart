import 'package:flutter/material.dart';
import 'package:sehatak/core/constants/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';

class EmergencyNumbers extends StatelessWidget {
  const EmergencyNumbers({super.key});

  final List<Map<String, dynamic>> _emergencyNumbers = const [
    {'name': 'Ambulance', 'number': '1122', 'icon': '🚑', 'color': AppColors.error},
    {'name': 'Police', 'number': '15', 'icon': '🚔', 'color': AppColors.info},
    {'name': 'Fire Brigade', 'number': '16', 'icon': '🚒', 'color': AppColors.orange},
    {'name': 'Rescue 1122', 'number': '1122', 'icon': '🛟', 'color': AppColors.teal},
    {'name': 'Edhi Ambulance', 'number': '115', 'icon': '🚨', 'color': AppColors.purple},
    {'name': 'Chhipa Ambulance', 'number': '1020', 'icon': '🏥', 'color': AppColors.success},
  ];

  final List<Map<String, dynamic>> _hospitalNumbers = const [
    {'name': 'Aga Khan University Hospital', 'number': '021-111-911-911', 'city': 'Karachi', 'icon': '🏥'},
    {'name': 'Jinnah Postgraduate Medical Center', 'number': '021-99201300', 'city': 'Karachi', 'icon': '🏥'},
    {'name': 'Mayo Hospital', 'number': '042-99211100', 'city': 'Lahore', 'icon': '🏥'},
    {'name': 'PIMS Hospital', 'number': '051-9261170', 'city': 'Islamabad', 'icon': '🏥'},
    {'name': 'Lady Reading Hospital', 'number': '091-9211430', 'city': 'Peshawar', 'icon': '🏥'},
    {'name': 'Civil Hospital', 'number': '021-99215740', 'city': 'Karachi', 'icon': '🏥'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Emergency', style: TextStyle(fontWeight: FontWeight.bold))),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(14),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // SOS Button
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(gradient: const LinearGradient(colors: [Color(0xFFD32F2F), Color(0xFFB71C1C)]), borderRadius: BorderRadius.circular(16)),
            child: Column(children: [
              const Icon(Icons.warning_amber_rounded, color: Colors.white, size: 50),
              const SizedBox(height: 8),
              const Text('EMERGENCY SOS', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              const Text('Press and hold for 3 seconds', style: TextStyle(color: Colors.white70, fontSize: 12)),
              const SizedBox(height: 16),
              GestureDetector(
                onLongPress: () => _callEmergency('1122'),
                child: Container(
                  width: 100, height: 100,
                  decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle, boxShadow: [BoxShadow(color: Colors.red, blurRadius: 20)]),
                  child: const Center(child: Text('SOS', style: TextStyle(color: Color(0xFFD32F2F), fontSize: 28, fontWeight: FontWeight.bold))),
                ),
              ),
            ]),
          ),
          const SizedBox(height: 24),

          // أرقام الطوارئ
          Text('Emergency Numbers', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          GridView.count(
            crossAxisCount: 3,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            childAspectRatio: 1.1,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            children: _emergencyNumbers.map((e) => _emergencyCard(context, e)).toList(),
          ),
          const SizedBox(height: 24),

          // مستشفيات
          Text('Nearby Hospitals', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          ..._hospitalNumbers.map((h) => _hospitalCard(context, h)),
          const SizedBox(height: 20),
        ]),
      ),
    );
  }

  Widget _emergencyCard(BuildContext context, Map<String, dynamic> data) {
    return GestureDetector(
      onTap: () => _callEmergency(data['number']),
      child: Container(
        decoration: BoxDecoration(color: (data['color'] as Color).withOpacity(0.08), borderRadius: BorderRadius.circular(14), border: Border.all(color: (data['color'] as Color).withOpacity(0.2))),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(data['icon'], style: const TextStyle(fontSize: 30)),
          const SizedBox(height: 4),
          Text(data['name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
          Text(data['number'], style: TextStyle(color: data['color'], fontWeight: FontWeight.bold, fontSize: 16)),
        ]),
      ),
    );
  }

  Widget _hospitalCard(BuildContext context, Map<String, dynamic> data) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 4)]),
      child: Row(children: [
        Text(data['icon'], style: const TextStyle(fontSize: 28)),
        const SizedBox(width: 10),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(data['name'], style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13)),
          Text(data['city'], style: const TextStyle(fontSize: 10, color: AppColors.grey)),
          Text(data['number'], style: const TextStyle(fontSize: 12, color: AppColors.primary, fontWeight: FontWeight.bold)),
        ])),
        IconButton(icon: const Icon(Icons.call, color: AppColors.success), onPressed: () => _callEmergency(data['number'])),
      ]),
    );
  }

  void _callEmergency(String number) async {
    final uri = Uri.parse('tel:$number');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}
