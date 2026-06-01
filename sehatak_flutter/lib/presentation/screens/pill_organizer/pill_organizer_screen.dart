import 'package:flutter/material.dart';
import 'package:sehatak/core/constants/app_colors.dart';

class PillOrganizerScreen extends StatefulWidget {
  const PillOrganizerScreen({super.key});
  @override
  State<PillOrganizerScreen> createState() => _PillOrganizerScreenState();
}

class _PillOrganizerScreenState extends State<PillOrganizerScreen> {
  int _selectedDay = 0;
  
  final List<String> _days = ['سبت', 'أحد', 'إثنين', 'ثلاثاء', 'أربعاء', 'خميس', 'جمعة'];
  
  final List<List<Map<String, dynamic>>> _weekPills = [
    [{'name': 'أملوديبين 5mg', 'time': 'صباح', 'taken': true}, {'name': 'فيتامين د', 'time': 'ظهر', 'taken': true}],
    [{'name': 'أملوديبين 5mg', 'time': 'صباح', 'taken': true}, {'name': 'أوميبرازول 40mg', 'time': 'صباح', 'taken': true}],
    [{'name': 'أملوديبين 5mg', 'time': 'صباح', 'taken': true}, {'name': 'فيتامين د', 'time': 'ظهر', 'taken': false}],
    [{'name': 'أملوديبين 5mg', 'time': 'صباح', 'taken': true}, {'name': 'أوميبرازول 40mg', 'time': 'صباح', 'taken': true}, {'name': 'سيتريزين 10mg', 'time': 'مساء', 'taken': false}],
    [{'name': 'أملوديبين 5mg', 'time': 'صباح', 'taken': true}, {'name': 'فيتامين د', 'time': 'ظهر', 'taken': true}],
    [{'name': 'أملوديبين 5mg', 'time': 'صباح', 'taken': false}, {'name': 'أوميبرازول 40mg', 'time': 'صباح', 'taken': false}],
    [{'name': 'أملوديبين 5mg', 'time': 'صباح', 'taken': true}, {'name': 'فيتامين د', 'time': 'ظهر', 'taken': false}, {'name': 'سيتريزين 10mg', 'time': 'مساء', 'taken': true}],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('منظم الأدوية', style: TextStyle(fontWeight: FontWeight.bold))),
      body: Column(children: [
        // أيام الأسبوع
        Container(
          margin: const EdgeInsets.all(12),
          decoration: BoxDecoration(color: AppColors.surfaceContainerLow, borderRadius: BorderRadius.circular(16)),
          child: Row(children: List.generate(7, (i) => Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _selectedDay = i),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: _selectedDay == i ? AppColors.primary : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(children: [
                  Text(_days[i], style: TextStyle(color: _selectedDay == i ? Colors.white : AppColors.darkGrey, fontWeight: FontWeight.bold, fontSize: 12)),
                  if (_weekPills[i].where((p) => p['taken']).length == _weekPills[i].length && _weekPills[i].isNotEmpty)
                    const Icon(Icons.check, color: Colors.white, size: 14),
                ]),
              ),
            ),
          ))),
        ),
        // الأدوية لليوم المختار
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(gradient: const LinearGradient(colors: [AppColors.primary, AppColors.primaryDark]), borderRadius: BorderRadius.circular(14)),
                child: Row(children: [
                  const Icon(Icons.calendar_today, color: Colors.white, size: 28),
                  const SizedBox(width: 10),
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text('${_days[_selectedDay]} - ${_selectedDay + 1} مايو', style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                    Text('${_weekPills[_selectedDay].length} أدوية', style: const TextStyle(color: Colors.white70, fontSize: 12)),
                  ])),
                  Text('${_weekPills[_selectedDay].where((p) => p['taken']).length}/${_weekPills[_selectedDay].length}', style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
                ]),
              ),
              const SizedBox(height: 14),
              ..._weekPills[_selectedDay].asMap().entries.map((e) {
                final p = e.value;
                return Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 4)]),
                  child: Row(children: [
                    Container(
                      width: 40, height: 40,
                      decoration: BoxDecoration(color: p['taken'] ? AppColors.success.withOpacity(0.1) : AppColors.warning.withOpacity(0.1), shape: BoxShape.circle),
                      child: Icon(p['taken'] ? Icons.check : Icons.schedule, color: p['taken'] ? AppColors.success : AppColors.warning, size: 20),
                    ),
                    const SizedBox(width: 10),
                    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(p['name'], style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13)),
                      Text(p['time'], style: const TextStyle(fontSize: 10, color: AppColors.grey)),
                    ])),
                    Checkbox(value: p['taken'], activeColor: AppColors.success, onChanged: (v) => setState(() => p['taken'] = v)),
                  ]),
                );
              }),
              if (_weekPills[_selectedDay].isEmpty)
                const Center(child: Padding(padding: EdgeInsets.all(30), child: Text('لا توجد أدوية لهذا اليوم 🎉', style: TextStyle(color: AppColors.grey, fontSize: 16)))),
              const SizedBox(height: 20),
            ]),
          ),
        ),
      ]),
    );
  }
}
