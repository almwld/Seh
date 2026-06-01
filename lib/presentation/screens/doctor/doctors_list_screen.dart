import 'package:flutter/material.dart';
import 'package:sehatak/core/constants/app_colors.dart';
import 'package:sehatak/presentation/screens/doctor/doctor_details_screen.dart';
import 'package:sehatak/presentation/screens/chat/chat_screen.dart';

class DoctorsListScreen extends StatefulWidget {
  const DoctorsListScreen({super.key});
  @override
  State<DoctorsListScreen> createState() => _DoctorsListScreenState();
}

class _DoctorsListScreenState extends State<DoctorsListScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedSpecialty = 'الكل';
  String _sortBy = 'التقييم';
  bool _showAvailableOnly = false;

  final List<Map<String, String>> _specialties = const [
    {'icon': '🫀', 'name': 'الكل'},
    {'icon': '👨‍⚕️', 'name': 'عام'},
    {'icon': '🫀', 'name': 'قلب'},
    {'icon': '🫁', 'name': 'صدرية'},
    {'icon': '🧠', 'name': 'أعصاب'},
    {'icon': '🦴', 'name': 'عظام'},
    {'icon': '👶', 'name': 'أطفال'},
    {'icon': '👩‍🦰', 'name': 'جلدية'},
    {'icon': '👁️', 'name': 'عيون'},
    {'icon': '🦷', 'name': 'أسنان'},
    {'icon': '🧘', 'name': 'نفسية'},
    {'icon': '🤰', 'name': 'نسائية'},
    {'icon': '🩺', 'name': 'أنف وأذن'},
    {'icon': '🩻', 'name': 'أشعة'},
    {'icon': '💊', 'name': 'صيدلة'},
  ];

  final List<Map<String, dynamic>> _allDoctors = [
    {'id': '1', 'name': 'د. عائشة رحمن', 'specialty': 'عام', 'subspecialty': 'باطنية عامة', 'qualification': 'بكالوريوس طب، زمالة الباطنية', 'experience': '12+ سنة', 'rating': 4.9, 'reviews': 128, 'fee': '500', 'available': true, 'online': true, 'languages': 'عربي، إنجليزي، بنغالي', 'hospital': 'مستشفى المدينة الطبي', 'patients': '5,000+', 'image': '👩‍⚕️', 'nextAvailable': 'اليوم 3:00 م'},
    {'id': '2', 'name': 'د. حسن رضا', 'specialty': 'عام', 'subspecialty': 'طب الأسرة', 'qualification': 'بكالوريوس طب، ماجستير طب أسرة', 'experience': '8+ سنة', 'rating': 4.8, 'reviews': 235, 'fee': '300', 'available': true, 'online': true, 'languages': 'عربي، إنجليزي', 'hospital': 'عيادة الصحة بلس', 'patients': '3,200+', 'image': '👨‍⚕️', 'nextAvailable': 'اليوم 4:30 م'},
    {'id': '3', 'name': 'د. عثمان خان', 'specialty': 'قلب', 'subspecialty': 'قسطرة قلبية', 'qualification': 'بكالوريوس طب، زمالة القلب، البورد الأمريكي', 'experience': '10+ سنة', 'rating': 4.7, 'reviews': 312, 'fee': '1000', 'available': true, 'online': true, 'languages': 'عربي، إنجليزي، بشتو', 'hospital': 'معهد القلب الوطني', 'patients': '8,000+', 'image': '👨‍⚕️', 'nextAvailable': 'اليوم 5:00 م'},
    {'id': '4', 'name': 'د. سارة أحمد', 'specialty': 'قلب', 'subspecialty': 'قلب أطفال', 'qualification': 'بكالوريوس طب، زمالة قلب أطفال', 'experience': '7+ سنة', 'rating': 4.8, 'reviews': 156, 'fee': '1200', 'available': false, 'online': false, 'languages': 'عربي، إنجليزي', 'hospital': 'مركز قلب الأطفال', 'patients': '2,500+', 'image': '👩‍⚕️', 'nextAvailable': 'غداً 11:00 ص'},
    {'id': '5', 'name': 'د. عمران شيخ', 'specialty': 'صدرية', 'subspecialty': 'أمراض تنفسية', 'qualification': 'بكالوريوس طب، زمالة الأمراض الصدرية', 'experience': '9+ سنة', 'rating': 4.6, 'reviews': 189, 'fee': '900', 'available': true, 'online': true, 'languages': 'عربي، إنجليزي، سندي', 'hospital': 'مستشفى العناية بالرئة', 'patients': '4,000+', 'image': '👨‍⚕️', 'nextAvailable': 'اليوم 6:00 م'},
    {'id': '6', 'name': 'د. نادية حسين', 'specialty': 'أعصاب', 'subspecialty': 'الجلطات الدماغية', 'qualification': 'بكالوريوس طب، زمالة الأعصاب، عضوية كلية الأطباء', 'experience': '11+ سنة', 'rating': 4.9, 'reviews': 201, 'fee': '1500', 'available': true, 'online': false, 'languages': 'عربي، إنجليزي', 'hospital': 'معهد العناية العصبية', 'patients': '6,000+', 'image': '👩‍⚕️', 'nextAvailable': 'اليوم 2:00 م'},
    {'id': '7', 'name': 'د. كمال أحمد', 'specialty': 'عظام', 'subspecialty': 'مفاصل صناعية', 'qualification': 'بكالوريوس طب، ماجستير جراحة عظام، زمالة بريطانيا', 'experience': '15+ سنة', 'rating': 4.6, 'reviews': 98, 'fee': '1200', 'available': false, 'online': false, 'languages': 'عربي، إنجليزي', 'hospital': 'مستشفى العظام والمفاصل', 'patients': '10,000+', 'image': '👨‍⚕️', 'nextAvailable': 'بعد غد'},
    {'id': '8', 'name': 'د. فاطمة صديقي', 'specialty': 'أطفال', 'subspecialty': 'حديثي الولادة', 'qualification': 'بكالوريوس طب، زمالة طب الأطفال', 'experience': '7+ سنة', 'rating': 4.9, 'reviews': 167, 'fee': '600', 'available': true, 'online': true, 'languages': 'عربي، إنجليزي، سندي', 'hospital': 'مستشفى الأطفال', 'patients': '7,000+', 'image': '👩‍⚕️', 'nextAvailable': 'اليوم 2:30 م'},
    {'id': '9', 'name': 'د. عائشة ملك', 'specialty': 'جلدية', 'subspecialty': 'جلدية تجميلية', 'qualification': 'بكالوريوس طب، دبلوم جلدية، ماجستير', 'experience': '6+ سنة', 'rating': 4.9, 'reviews': 189, 'fee': '800', 'available': false, 'online': false, 'languages': 'عربي، إنجليزي، بنجابي', 'hospital': 'عيادة تجميل البشرة', 'patients': '4,500+', 'image': '👩‍⚕️', 'nextAvailable': 'غداً 10:00 ص'},
    {'id': '10', 'name': 'د. عمر فاروق', 'specialty': 'عيون', 'subspecialty': 'شبكية', 'qualification': 'بكالوريوس طب، زمالة طب العيون', 'experience': '13+ سنة', 'rating': 4.7, 'reviews': 145, 'fee': '1000', 'available': true, 'online': true, 'languages': 'عربي، إنجليزي', 'hospital': 'مركز العناية بالعيون', 'patients': '9,000+', 'image': '👨‍⚕️', 'nextAvailable': 'اليوم 7:00 م'},
    {'id': '11', 'name': 'د. زهرة طارق', 'specialty': 'أسنان', 'subspecialty': 'تقويم أسنان', 'qualification': 'بكالوريوس جراحة أسنان، ماجستير تقويم', 'experience': '5+ سنة', 'rating': 4.5, 'reviews': 112, 'fee': '700', 'available': true, 'online': false, 'languages': 'عربي، إنجليزي', 'hospital': 'عيادة سمايل لطب الأسنان', 'patients': '2,000+', 'image': '👩‍⚕️', 'nextAvailable': 'اليوم 3:30 م'},
    {'id': '12', 'name': 'د. بلال محمود', 'specialty': 'نفسية', 'subspecialty': 'طب نفسي للكبار', 'qualification': 'بكالوريوس طب، زمالة الطب النفسي', 'experience': '8+ سنة', 'rating': 4.8, 'reviews': 134, 'fee': '1000', 'available': true, 'online': true, 'languages': 'عربي، إنجليزي، بنجابي', 'hospital': 'مركز العافية الذهنية', 'patients': '3,500+', 'image': '👨‍⚕️', 'nextAvailable': 'اليوم 5:30 م'},
    {'id': '13', 'name': 'د. سناء طارق', 'specialty': 'نسائية', 'subspecialty': 'ولادة', 'qualification': 'بكالوريوس طب، زمالة النساء والولادة', 'experience': '10+ سنة', 'rating': 4.9, 'reviews': 278, 'fee': '800', 'available': true, 'online': false, 'languages': 'عربي، إنجليزي، بشتو', 'hospital': 'مركز صحة المرأة', 'patients': '12,000+', 'image': '👩‍⚕️', 'nextAvailable': 'اليوم 1:00 م'},
    {'id': '14', 'name': 'د. راشد علي', 'specialty': 'أنف وأذن', 'subspecialty': 'جراحة الرأس والرقبة', 'qualification': 'بكالوريوس طب، زمالة الأنف والأذن', 'experience': '14+ سنة', 'rating': 4.6, 'reviews': 167, 'fee': '900', 'available': false, 'online': false, 'languages': 'عربي، إنجليزي', 'hospital': 'مستشفى الأنف والأذن التخصصي', 'patients': '11,000+', 'image': '👨‍⚕️', 'nextAvailable': 'غداً 9:00 ص'},
    {'id': '15', 'name': 'د. هالة شيخ', 'specialty': 'أشعة', 'subspecialty': 'أشعة تشخيصية', 'qualification': 'بكالوريوس طب، زمالة الأشعة', 'experience': '9+ سنة', 'rating': 4.7, 'reviews': 89, 'fee': '600', 'available': true, 'online': true, 'languages': 'عربي، إنجليزي', 'hospital': 'مركز التصوير المتقدم', 'patients': '15,000+', 'image': '👩‍⚕️', 'nextAvailable': 'اليوم 4:00 م'},
    {'id': '16', 'name': 'د. فيصل قريشي', 'specialty': 'صيدلة', 'subspecialty': 'صيدلة إكلينيكية', 'qualification': 'دكتور صيدلة، دكتوراه علم الأدوية', 'experience': '11+ سنة', 'rating': 4.5, 'reviews': 76, 'fee': '500', 'available': true, 'online': true, 'languages': 'عربي، إنجليزي', 'hospital': 'مركز المعلومات الدوائية', 'patients': '1,500+', 'image': '👨‍⚕️', 'nextAvailable': 'اليوم 3:00 م'},
  ];

  List<Map<String, dynamic>> get _filteredDoctors {
    var doctors = _allDoctors;
    if (_selectedSpecialty != 'الكل') {
      doctors = doctors.where((d) => d['specialty'] == _selectedSpecialty).toList();
    }
    if (_showAvailableOnly) {
      doctors = doctors.where((d) => d['available'] == true).toList();
    }
    final query = _searchController.text.toLowerCase();
    if (query.isNotEmpty) {
      doctors = doctors.where((d) => d['name'].toString().toLowerCase().contains(query) || d['subspecialty'].toString().toLowerCase().contains(query) || d['hospital'].toString().toLowerCase().contains(query)).toList();
    }
    if (_sortBy == 'التقييم') {
      doctors.sort((a, b) => (b['rating'] as double).compareTo(a['rating'] as double));
    } else if (_sortBy == 'الأقل سعراً') {
      doctors.sort((a, b) => int.parse(a['fee']).compareTo(int.parse(b['fee'])));
    } else if (_sortBy == 'الأعلى سعراً') {
      doctors.sort((a, b) => int.parse(b['fee']).compareTo(int.parse(a['fee'])));
    } else if (_sortBy == 'الخبرة') {
      doctors.sort((a, b) => (b['experience'] as String).compareTo(a['experience'] as String));
    }
    return doctors;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('البحث عن طبيب', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(icon: const Icon(Icons.sort), onPressed: _showSortOptions, tooltip: 'ترتيب'),
          IconButton(
            icon: Icon(Icons.filter_list, color: _showAvailableOnly ? AppColors.primary : null),
            onPressed: () => setState(() => _showAvailableOnly = !_showAvailableOnly),
            tooltip: 'المتاحون فقط',
          ),
        ],
      ),
      body: Column(children: [
        // شريط البحث
        Padding(
          padding: const EdgeInsets.all(10),
          child: TextField(
            controller: _searchController,
            textAlign: TextAlign.right,
            onChanged: (_) => setState(() {}),
            decoration: InputDecoration(
              hintText: 'ابحث بالاسم، التخصص، المستشفى...',
              prefixIcon: const Icon(Icons.search, color: AppColors.grey),
              suffixIcon: _searchController.text.isNotEmpty ? IconButton(icon: const Icon(Icons.clear), onPressed: () { _searchController.clear(); setState(() {}); }) : null,
              filled: true,
              fillColor: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
              contentPadding: const EdgeInsets.symmetric(vertical: 12),
            ),
          ),
        ),
        // التخصصات أفقية
        SizedBox(
          height: 75,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            scrollDirection: Axis.horizontal,
            itemCount: _specialties.length,
            separatorBuilder: (_, __) => const SizedBox(width: 2),
            itemBuilder: (context, index) {
              final s = _specialties[index];
              final selected = _selectedSpecialty == s['name'];
              return GestureDetector(
                onTap: () => setState(() => _selectedSpecialty = s['name']!),
                child: Column(children: [
                  Container(
                    padding: const EdgeInsets.all(9),
                    decoration: BoxDecoration(color: selected ? AppColors.primary : AppColors.primary.withOpacity(0.05), shape: BoxShape.circle),
                    child: Text(s['icon']!, style: const TextStyle(fontSize: 20)),
                  ),
                  const SizedBox(height: 3),
                  Text(s['name']!, style: TextStyle(fontSize: 9, fontWeight: selected ? FontWeight.bold : FontWeight.normal, color: selected ? AppColors.primary : AppColors.darkGrey)),
                ]),
              );
            },
          ),
        ),
        const Divider(height: 1),
        // نتائج
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text('${_filteredDoctors.length} طبيب', style: const TextStyle(fontSize: 11, color: AppColors.grey)),
            if (_showAvailableOnly)
              Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2), decoration: BoxDecoration(color: Colors.green.withOpacity(0.1), borderRadius: BorderRadius.circular(6)), child: const Row(mainAxisSize: MainAxisSize.min, children: [Icon(Icons.check, size: 11, color: Colors.green), SizedBox(width: 2), Text('متاح فقط', style: TextStyle(fontSize: 9, color: Colors.green))])),
          ]),
        ),
        Expanded(
          child: _filteredDoctors.isEmpty
              ? const Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.search_off, size: 60, color: AppColors.grey), SizedBox(height: 10), Text('لا يوجد أطباء', style: TextStyle(color: AppColors.grey, fontSize: 16))]))
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  itemCount: _filteredDoctors.length,
                  itemBuilder: (context, index) => _buildDoctorCard(_filteredDoctors[index]),
                ),
        ),
      ]),
    );
  }

  Widget _buildDoctorCard(Map<String, dynamic> doc) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8, offset: const Offset(0, 2))]),
      child: Column(children: [
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Stack(children: [
            Container(width: 60, height: 60, decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.07), borderRadius: BorderRadius.circular(14)), child: Center(child: Text(doc['image'], style: const TextStyle(fontSize: 30)))),
            if (doc['online'] == true) Positioned(bottom: 2, right: 2, child: Container(width: 13, height: 13, decoration: BoxDecoration(color: Colors.green, shape: BoxShape.circle, border: Border.all(color: Colors.white, width: 2)), child: const Icon(Icons.check, size: 7, color: Colors.white))),
          ]),
          const SizedBox(width: 12),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              Expanded(child: Text(doc['name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15))),
              if (doc['available'] == true) Container(padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2), decoration: BoxDecoration(color: Colors.green.withOpacity(0.1), borderRadius: BorderRadius.circular(5)), child: const Text('متاح', style: TextStyle(fontSize: 8, color: Colors.green, fontWeight: FontWeight.bold))),
            ]),
            Text(doc['qualification'], style: const TextStyle(fontSize: 10, color: AppColors.darkGrey)),
            Text(doc['subspecialty'], style: const TextStyle(fontSize: 12, color: AppColors.primary, fontWeight: FontWeight.w500)),
            Row(children: [
              const Icon(Icons.star, color: AppColors.amber, size: 15),
              Text(' ${doc['rating']}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
              Text(' (${doc['reviews']} تقييم)', style: const TextStyle(fontSize: 10, color: AppColors.grey)),
              const SizedBox(width: 10),
              const Icon(Icons.work_outline, size: 13, color: AppColors.grey),
              Text(' ${doc['experience']}', style: const TextStyle(fontSize: 10, color: AppColors.grey)),
              const SizedBox(width: 10),
              const Icon(Icons.people, size: 13, color: AppColors.grey),
              Text(' ${doc['patients']}', style: const TextStyle(fontSize: 10, color: AppColors.grey)),
            ]),
          ])),
          Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            Text('${doc['fee']} ر.س', style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary, fontSize: 17)),
            const Text('استشارة', style: TextStyle(fontSize: 8, color: AppColors.grey)),
          ]),
        ]),
        const SizedBox(height: 8),
        Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: AppColors.surfaceContainerLow.withOpacity(0.5), borderRadius: BorderRadius.circular(8)), child: Row(children: [
          const Icon(Icons.local_hospital, size: 13, color: AppColors.darkGrey),
          const SizedBox(width: 4),
          Expanded(child: Text(doc['hospital'], style: const TextStyle(fontSize: 10, color: AppColors.darkGrey))),
          const Icon(Icons.language, size: 13, color: AppColors.darkGrey),
          const SizedBox(width: 4),
          Text(doc['languages'], style: const TextStyle(fontSize: 9, color: AppColors.darkGrey)),
        ])),
        const SizedBox(height: 8),
        Row(children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 7),
              decoration: BoxDecoration(color: doc['online'] == true ? Colors.green.withOpacity(0.05) : Colors.orange.withOpacity(0.05), borderRadius: BorderRadius.circular(7)),
              child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Icon(doc['online'] == true ? Icons.videocam : Icons.schedule, size: 13, color: doc['online'] == true ? Colors.green : Colors.orange),
                const SizedBox(width: 4),
                Text(doc['nextAvailable'], style: TextStyle(fontSize: 10, color: doc['online'] == true ? Colors.green : Colors.orange, fontWeight: FontWeight.w500)),
              ]),
            ),
          ),
          const SizedBox(width: 6),
          ElevatedButton.icon(
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => DoctorDetailsScreen(doctorId: doc['id']))),
            icon: const Icon(Icons.person, size: 15),
            label: const Text('الملف'),
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary.withOpacity(0.08), foregroundColor: AppColors.primary, elevation: 0, padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8)),
          ),
          const SizedBox(width: 4),
          ElevatedButton.icon(
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ChatScreen())),
            icon: const Icon(Icons.message, size: 15),
            label: const Text('محادثة'),
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, foregroundColor: Colors.white, elevation: 0, padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8)),
          ),
        ]),
      ]),
    );
  }

  void _showSortOptions() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('ترتيب حسب', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 14),
          _sortOption('التقييم (الأعلى)', 'التقييم', Icons.star),
          _sortOption('السعر (الأقل)', 'الأقل سعراً', Icons.arrow_upward),
          _sortOption('السعر (الأعلى)', 'الأعلى سعراً', Icons.arrow_downward),
          _sortOption('الخبرة', 'الخبرة', Icons.work),
        ]),
      ),
    );
  }

  Widget _sortOption(String title, String value, IconData icon) {
    final selected = _sortBy == value;
    return ListTile(
      leading: Icon(icon, color: selected ? AppColors.primary : AppColors.grey),
      title: Text(title, style: TextStyle(fontWeight: selected ? FontWeight.bold : FontWeight.normal, color: selected ? AppColors.primary : null)),
      trailing: selected ? const Icon(Icons.check, color: AppColors.primary) : null,
      onTap: () { setState(() => _sortBy = value); Navigator.pop(context); },
    );
  }
}
