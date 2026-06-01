import 'package:flutter/material.dart';
import 'package:sehatak/core/constants/app_colors.dart';
import 'package:sehatak/presentation/screens/chat/chat_screen.dart';

class ConsultationScreen extends StatefulWidget {
  const ConsultationScreen({super.key});

  @override
  State<ConsultationScreen> createState() => _ConsultationScreenState();
}

class _ConsultationScreenState extends State<ConsultationScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, dynamic>> _doctors = [
    {
      'name': 'Dr. Ayesha Rahman',
      'specialty': 'Internal Medicine Specialist',
      'qualification': 'MBBS, FCPS',
      'rating': 4.9,
      'reviews': 128,
      'experience': '12+ Years',
      'fee': '500',
      'available': true,
      'image': '👩‍⚕️',
      'languages': 'English, Urdu, Bengali',
      'nextAvailable': 'Today 3:00 PM',
      'online': true,
    },
    {
      'name': 'Dr. Hassan Raza',
      'specialty': 'General Physician',
      'qualification': 'MBBS, MD',
      'rating': 4.8,
      'reviews': 235,
      'experience': '8+ Years',
      'fee': '300',
      'available': true,
      'image': '👨‍⚕️',
      'languages': 'English, Urdu',
      'nextAvailable': 'Today 4:30 PM',
      'online': true,
    },
    {
      'name': 'Dr. Ayesha Malik',
      'specialty': 'Dermatologist',
      'qualification': 'MBBS, DDerm',
      'rating': 4.9,
      'reviews': 189,
      'experience': '6+ Years',
      'fee': '800',
      'available': false,
      'image': '👩‍⚕️',
      'languages': 'English, Urdu, Punjabi',
      'nextAvailable': 'Tomorrow 10:00 AM',
      'online': false,
    },
    {
      'name': 'Dr. Usman Khan',
      'specialty': 'Cardiologist',
      'qualification': 'MBBS, FCPS (Cardiology)',
      'rating': 4.7,
      'reviews': 312,
      'experience': '10+ Years',
      'fee': '1000',
      'available': true,
      'image': '👨‍⚕️',
      'languages': 'English, Urdu, Pashto',
      'nextAvailable': 'Today 5:00 PM',
      'online': true,
    },
    {
      'name': 'Dr. Fatima Siddiqui',
      'specialty': 'Pediatrician',
      'qualification': 'MBBS, FCPS (Pediatrics)',
      'rating': 4.9,
      'reviews': 167,
      'experience': '7+ Years',
      'fee': '600',
      'available': true,
      'image': '👩‍⚕️',
      'languages': 'English, Urdu, Sindhi',
      'nextAvailable': 'Today 2:30 PM',
      'online': true,
    },
    {
      'name': 'Dr. Kamran Ahmed',
      'specialty': 'Orthopedic Surgeon',
      'qualification': 'MBBS, MS (Orthopedics)',
      'rating': 4.6,
      'reviews': 98,
      'experience': '15+ Years',
      'fee': '1200',
      'available': false,
      'image': '👨‍⚕️',
      'languages': 'English, Urdu',
      'nextAvailable': 'Day after tomorrow',
      'online': false,
    },
  ];

  final List<Map<String, String>> _specialties = [
    {'icon': '🫀', 'name': 'Cardiology'},
    {'icon': '🫁', 'name': 'Pulmonology'},
    {'icon': '🧠', 'name': 'Neurology'},
    {'icon': '🦴', 'name': 'Orthopedics'},
    {'icon': '👶', 'name': 'Pediatrics'},
    {'icon': '👩‍🦰', 'name': 'Dermatology'},
    {'icon': '👁️', 'name': 'Ophthalmology'},
    {'icon': '🦷', 'name': 'Dental'},
    {'icon': '🧘', 'name': 'Psychiatry'},
    {'icon': '🤰', 'name': 'Gynecology'},
  ];

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Consultations', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: const [
            Tab(text: 'Doctors', icon: Icon(Icons.person_search, size: 20)),
            Tab(text: 'Chat', icon: Icon(Icons.chat, size: 20)),
            Tab(text: 'Video', icon: Icon(Icons.videocam, size: 20)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildDoctorsTab(),
          _buildChatTab(),
          _buildVideoTab(),
        ],
      ),
    );
  }

  // ================ تبويب الأطباء ================
  Widget _buildDoctorsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        // شريط البحث
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(children: [
            Expanded(
              child: TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  hintText: 'Search doctors, specialties...',
                  prefixIcon: Icon(Icons.search, color: AppColors.grey),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Row(children: [
                Icon(Icons.tune, color: Colors.white, size: 16),
                SizedBox(width: 4),
                Text('Filter', style: TextStyle(color: Colors.white, fontSize: 12)),
              ]),
            ),
          ]),
        ),
        const SizedBox(height: 20),

        // التخصصات
        Text('Specialties', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        SizedBox(
          height: 100,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: _specialties.length,
            separatorBuilder: (_, __) => const SizedBox(width: 10),
            itemBuilder: (context, index) {
              final s = _specialties[index];
              return GestureDetector(
                onTap: () {},
                child: Column(children: [
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.08),
                      shape: BoxShape.circle,
                    ),
                    child: Text(s['icon']!, style: const TextStyle(fontSize: 28)),
                  ),
                  const SizedBox(height: 6),
                  Text(s['name']!, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500)),
                ]),
              );
            },
          ),
        ),
        const SizedBox(height: 24),

        // أطباء متاحون الآن
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Row(children: [
            Container(width: 8, height: 8, decoration: const BoxDecoration(color: Colors.green, shape: BoxShape.circle)),
            const SizedBox(width: 6),
            Text('Available Now', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
          ]),
          TextButton(onPressed: () {}, child: const Text('View All')),
        ]),
        const SizedBox(height: 8),
        ..._doctors.where((d) => d['online'] == true).map((d) => _buildDoctorCard(d)),

        const SizedBox(height: 20),

        // كل الأطباء
        Text('All Doctors', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        ..._doctors.where((d) => d['online'] == false).map((d) => _buildDoctorCard(d)),

        const SizedBox(height: 80),
      ]),
    );
  }

  Widget _buildDoctorCard(Map<String, dynamic> doc) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.outlineVariant.withOpacity(0.3)),
      ),
      child: Column(children: [
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // صورة الطبيب
          Stack(children: [
            Container(
              width: 60, height: 60,
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Center(child: Text(doc['image'] as String, style: const TextStyle(fontSize: 30))),
            ),
            if (doc['online'] == true)
              Positioned(
                bottom: 0, right: 0,
                child: Container(
                  width: 16, height: 16,
                  decoration: const BoxDecoration(color: Colors.green, shape: BoxShape.circle),
                  child: const Icon(Icons.check, size: 10, color: Colors.white),
                ),
              ),
          ]),
          const SizedBox(width: 14),
          // معلومات الطبيب
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(doc['name'] as String, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 2),
            Text(doc['qualification'] as String, style: const TextStyle(fontSize: 12, color: AppColors.darkGrey)),
            const SizedBox(height: 2),
            Text(doc['specialty'] as String, style: const TextStyle(color: AppColors.primary, fontSize: 13)),
            const SizedBox(height: 6),
            Row(children: [
              const Icon(Icons.star, color: AppColors.amber, size: 16),
              const SizedBox(width: 2),
              Text('${doc['rating']}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
              Text(' (${doc['reviews']} reviews)', style: const TextStyle(fontSize: 11, color: AppColors.grey)),
              const SizedBox(width: 10),
              const Icon(Icons.work_outline, size: 14, color: AppColors.grey),
              const SizedBox(width: 2),
              Text(doc['experience'] as String, style: const TextStyle(fontSize: 11, color: AppColors.grey)),
            ]),
          ])),
          // رسوم
          Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            Text('Rs. ${doc['fee']}', style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary, fontSize: 16)),
            const Text('per visit', style: TextStyle(fontSize: 10, color: AppColors.grey)),
          ]),
        ]),
        const SizedBox(height: 12),
        Row(children: [
          const Icon(Icons.language, size: 14, color: AppColors.grey),
          const SizedBox(width: 4),
          Expanded(child: Text(doc['languages'] as String, style: const TextStyle(fontSize: 11, color: AppColors.darkGrey))),
        ]),
        const SizedBox(height: 10),
        Row(children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 6),
              decoration: BoxDecoration(
                color: doc['online'] == true ? Colors.green.withOpacity(0.1) : Colors.orange.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Icon(doc['online'] == true ? Icons.videocam : Icons.schedule, size: 14, color: doc['online'] == true ? Colors.green : Colors.orange),
                const SizedBox(width: 4),
                Text(doc['nextAvailable'] as String, style: TextStyle(fontSize: 11, color: doc['online'] == true ? Colors.green : Colors.orange, fontWeight: FontWeight.w500)),
              ]),
            ),
          ),
          const SizedBox(width: 8),
          ElevatedButton.icon(
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ChatScreen())),
            icon: const Icon(Icons.message, size: 16),
            label: const Text('Chat Now'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
          ),
        ]),
      ]),
    );
  }

  // ================ تبويب المحادثة ================
  Widget _buildChatTab() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.chat_bubble_rounded, size: 60, color: AppColors.primary),
          ),
          const SizedBox(height: 24),
          const Text('Chat with a Doctor', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text('Get instant medical advice from certified doctors through secure messaging.', textAlign: TextAlign.center, style: TextStyle(color: AppColors.grey, fontSize: 14)),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ChatScreen())),
              icon: const Icon(Icons.message),
              label: const Text('Start Chat Consultation'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
            ),
          ),
          const SizedBox(height: 30),
          // مميزات
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            _featureItem(Icons.lock, 'Secure & Private'),
            _featureItem(Icons.attach_file, 'Share Reports'),
            _featureItem(Icons.history, 'Chat History'),
          ]),
        ]),
      ),
    );
  }

  // ================ تبويب الفيديو ================
  Widget _buildVideoTab() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: AppColors.secondary.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.videocam_rounded, size: 60, color: AppColors.secondary),
          ),
          const SizedBox(height: 24),
          const Text('Video Consultation', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text('Face-to-face video consultation with top doctors from the comfort of your home.', textAlign: TextAlign.center, style: TextStyle(color: AppColors.grey, fontSize: 14)),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.videocam),
              label: const Text('Book Video Call'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.secondary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
            ),
          ),
          const SizedBox(height: 30),
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            _featureItem(Icons.hd, 'HD Quality'),
            _featureItem(Icons.schedule, 'Flexible Timing'),
            _featureItem(Icons.notes, 'E-Prescription'),
          ]),
        ]),
      ),
    );
  }

  Widget _featureItem(IconData icon, String label) {
    return Column(children: [
      Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.primary.withOpacity(0.08),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: AppColors.primary, size: 24),
      ),
      const SizedBox(height: 8),
      Text(label, style: const TextStyle(fontSize: 11)),
    ]);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }
}
