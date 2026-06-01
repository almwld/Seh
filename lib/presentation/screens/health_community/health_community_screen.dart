import 'package:flutter/material.dart';
import 'package:sehatak/core/constants/app_colors.dart';

class HealthCommunityScreen extends StatefulWidget {
  const HealthCommunityScreen({super.key});
  @override
  State<HealthCommunityScreen> createState() => _HealthCommunityScreenState();
}

class _HealthCommunityScreenState extends State<HealthCommunityScreen> {
  String _selectedCategory = 'الكل';
  final TextEditingController _postController = TextEditingController();
  final TextEditingController _commentController = TextEditingController();

  final List<Map<String, dynamic>> _posts = [
    {
      'user': 'أم محمد',
      'avatar': '👩',
      'topic': 'سكري الأطفال',
      'content': 'ابني عمره 8 سنوات وشُخص بالسكري. أي نصائح للتعامل معه في المدرسة؟ وهل يوجد أطعمة معينة يجب تجنبها؟',
      'replies': 24,
      'likes': 45,
      'time': 'منذ 2 ساعة',
      'category': 'استشارات',
      'isLiked': false,
      'isSaved': false,
    },
    {
      'user': 'د. حسن رضا',
      'avatar': '👨‍⚕️',
      'topic': 'نصيحة طبية',
      'content': '🫀 تذكير: قياس ضغط الدم بانتظام من أهم عادات الوقاية. المعدل الطبيعي أقل من 120/80. لا تهملوا صحتكم!',
      'replies': 18,
      'likes': 92,
      'time': 'منذ 5 ساعات',
      'category': 'نصائح',
      'isLiked': true,
      'isSaved': true,
      'verified': true,
    },
    {
      'user': 'أبو خالد',
      'avatar': '👨',
      'topic': 'آلام الظهر',
      'content': 'أعاني من آلام أسفل الظهر منذ شهرين. جربت المسكنات وما نفعت. هل فيه أحد جرب العلاج الطبيعي؟',
      'replies': 18,
      'likes': 12,
      'time': 'منذ 5 ساعات',
      'category': 'استشارات',
      'isLiked': false,
      'isSaved': false,
    },
    {
      'user': 'سارة',
      'avatar': '👩',
      'topic': 'الحمل والولادة',
      'content': 'أنا في الشهر السابع وأعاني من حرقة المعدة باستمرار. أي حلول طبيعية مجربة؟ تعبت من الأدوية 💔',
      'replies': 35,
      'likes': 67,
      'time': 'منذ 8 ساعات',
      'category': 'استشارات',
      'isLiked': true,
      'isSaved': false,
    },
    {
      'user': 'محمد',
      'avatar': '👨',
      'topic': 'الرياضة والصحة',
      'content': 'ما أفضل التمارين لحرق الدهون في المنزل بدون معدات؟ وهل يكفي 30 دقيقة يومياً؟',
      'replies': 42,
      'likes': 88,
      'time': 'منذ 12 ساعة',
      'category': 'رياضة',
      'isLiked': false,
      'isSaved': true,
    },
    {
      'user': 'نورة',
      'avatar': '👩',
      'topic': 'تغذية الأطفال',
      'content': 'طفلي عمره سنتين يرفض الأكل. كيف أشجعه على تناول الطعام الصحي؟ جربت كل الطرق وما في فايدة 😢',
      'replies': 29,
      'likes': 34,
      'time': 'منذ يوم',
      'category': 'تغذية',
      'isLiked': false,
      'isSaved': false,
    },
    {
      'user': 'د. فاطمة صديقي',
      'avatar': '👩‍⚕️',
      'topic': 'توعية',
      'content': '👶 تذكير للأمهات: تطعيم الأطفال في موعده يحميهم من أمراض خطيرة. راجعوا جدول التطعيمات في التطبيق!',
      'replies': 15,
      'likes': 120,
      'time': 'منذ يومين',
      'category': 'نصائح',
      'isLiked': true,
      'isSaved': false,
      'verified': true,
    },
  ];

  List<Map<String, dynamic>> get _filteredPosts {
    if (_selectedCategory == 'الكل') return _posts;
    return _posts.where((p) => p['category'] == _selectedCategory).toList();
  }

  void _toggleLike(int index) {
    setState(() {
      _posts[index]['isLiked'] = !(_posts[index]['isLiked'] as bool);
      _posts[index]['likes'] = (_posts[index]['likes'] as int) + (_posts[index]['isLiked'] ? 1 : -1);
    });
  }

  void _toggleSave(int index) {
    setState(() => _posts[index]['isSaved'] = !(_posts[index]['isSaved'] as bool));
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(_posts[index]['isSaved'] ? 'تم الحفظ' : 'تم إلغاء الحفظ'),
      backgroundColor: AppColors.success,
      duration: const Duration(seconds: 1),
    ));
  }

  void _addPost() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (_) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, left: 20, right: 20, top: 20),
        child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
          Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(2)))),
          const SizedBox(height: 16),
          const Text('منشور جديد', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            value: 'استشارات',
            decoration: InputDecoration(labelText: 'التصنيف', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
            items: ['استشارات', 'نصائح', 'رياضة', 'تغذية', 'نفسية', 'أطفال', 'أخرى'].map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
            onChanged: (_) {},
          ),
          const SizedBox(height: 10),
          TextField(controller: _postController, maxLines: 4, textAlign: TextAlign.right, decoration: InputDecoration(hintText: 'اكتب منشورك هنا...', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)))),
          const SizedBox(height: 16),
          SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () { if (_postController.text.isNotEmpty) { setState(() => _posts.insert(0, {'user': 'أنت', 'avatar': '⭐', 'topic': 'جديد', 'content': _postController.text, 'replies': 0, 'likes': 0, 'time': 'الآن', 'category': 'استشارات', 'isLiked': false, 'isSaved': false})); _postController.clear(); Navigator.pop(context); ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('تم نشر منشورك!'), backgroundColor: AppColors.success)); } }, style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, padding: const EdgeInsets.symmetric(vertical: 14)), child: const Text('نشر'))),
          const SizedBox(height: 20),
        ]),
      ),
    );
  }

  void _showComments(Map<String, dynamic> post) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (_) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.6,
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(children: [
                const Text('التعليقات', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const Spacer(),
                IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close)),
              ]),
            ),
            const Divider(height: 1),
            Expanded(
              child: ListView(padding: const EdgeInsets.all(16), children: [
                _commentTile('👩', 'أم محمد', 'شكراً على النصيحة!', 'منذ ساعة'),
                _commentTile('👨‍⚕️', 'د. حسن', 'العفو، بالتوفيق', 'منذ 45 دقيقة'),
                _commentTile('👩', 'سارة', 'معلومات مفيدة جداً 🙏', 'منذ 30 دقيقة'),
              ]),
            ),
            Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4, offset: const Offset(0, -1))]), child: Row(children: [
              Expanded(child: TextField(controller: _commentController, textAlign: TextAlign.right, decoration: InputDecoration(hintText: 'اكتب تعليقاً...', filled: true, fillColor: AppColors.surfaceContainerLow, border: OutlineInputBorder(borderRadius: BorderRadius.circular(24), borderSide: BorderSide.none), contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8)))),
              const SizedBox(width: 6),
              CircleAvatar(backgroundColor: AppColors.primary, child: IconButton(icon: const Icon(Icons.send, color: Colors.white, size: 16), onPressed: () { _commentController.clear(); })),
            ])),
          ]),
        ),
      ),
    );
  }

  Widget _commentTile(String avatar, String name, String comment, String time) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        CircleAvatar(radius: 16, backgroundColor: AppColors.primary.withOpacity(0.1), child: Text(avatar, style: const TextStyle(fontSize: 16))),
        const SizedBox(width: 8),
        Expanded(child: Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: AppColors.surfaceContainerLow, borderRadius: BorderRadius.circular(12)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11)), const SizedBox(height: 2), Text(comment, style: const TextStyle(fontSize: 12)), const SizedBox(height: 2), Text(time, style: const TextStyle(fontSize: 9, color: AppColors.grey))]))),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('مجتمع صحتك', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
          IconButton(icon: const Icon(Icons.notifications_outlined), onPressed: () {}),
        ],
      ),
      body: Column(children: [
        // بطاقة الترحيب
        Container(
          margin: const EdgeInsets.fromLTRB(14, 14, 14, 0),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(gradient: LinearGradient(colors: [AppColors.teal, AppColors.primary]), borderRadius: BorderRadius.circular(16)),
          child: Row(children: [const Icon(Icons.people, color: Colors.white, size: 36), const SizedBox(width: 10), const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('مجتمع صحتك', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)), Text('انضم إلى 15,000+ عضو', style: TextStyle(color: Colors.white70, fontSize: 11))])), Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(12)), child: const Text('7 منشورات', style: TextStyle(color: Colors.white, fontSize: 10)))]),
        ),

        // تصنيفات
        SizedBox(
          height: 45,
          child: ListView.separated(
            scrollDirection: Axis.horizontal, padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            itemCount: ['الكل', 'استشارات', 'نصائح', 'رياضة', 'تغذية', 'نفسية', 'أطفال'].length,
            separatorBuilder: (_, __) => const SizedBox(width: 4),
            itemBuilder: (context, i) {
              final cat = ['الكل', 'استشارات', 'نصائح', 'رياضة', 'تغذية', 'نفسية', 'أطفال'][i];
              final selected = _selectedCategory == cat;
              return ChoiceChip(label: Text(cat, style: const TextStyle(fontSize: 10)), selected: selected, selectedColor: AppColors.primary, labelStyle: TextStyle(color: selected ? Colors.white : AppColors.darkGrey), onSelected: (v) => setState(() => _selectedCategory = v! ? cat : 'الكل'));
            },
          ),
        ),
        const Divider(height: 1),

        // المنشورات
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: _filteredPosts.length,
            itemBuilder: (context, idx) {
              final p = _filteredPosts[idx];
              return Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 6)]),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  // رأس المنشور
                  Row(children: [
                    CircleAvatar(radius: 18, backgroundColor: AppColors.primary.withOpacity(0.1), child: Text(p['avatar'], style: const TextStyle(fontSize: 18))),
                    const SizedBox(width: 8),
                    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Row(children: [
                        Text(p['user'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                        if (p['verified'] == true) ...[const SizedBox(width: 4), const Icon(Icons.verified, color: AppColors.info, size: 16)],
                      ]),
                      Text(p['time'], style: const TextStyle(fontSize: 9, color: AppColors.grey)),
                    ])),
                    PopupMenuButton(
                      icon: const Icon(Icons.more_vert, size: 16),
                      itemBuilder: (_) => [const PopupMenuItem(value: 'save', child: Text('حفظ')), const PopupMenuItem(value: 'report', child: Text('إبلاغ', style: TextStyle(color: AppColors.error)))],
                      onSelected: (v) { if (v == 'save') _toggleSave(idx); },
                    ),
                  ]),
                  const SizedBox(height: 8),

                  // المحتوى
                  Text(p['content'], style: const TextStyle(fontSize: 13, height: 1.5, color: AppColors.darkGrey)),
                  const SizedBox(height: 4),
                  Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3), decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.06), borderRadius: BorderRadius.circular(8)), child: Text(p['topic'], style: const TextStyle(fontSize: 9, color: AppColors.primary))),
                  const SizedBox(height: 10),

                  // أزرار التفاعل
                  Row(children: [
                    GestureDetector(onTap: () => _toggleLike(idx), child: Row(children: [Icon(p['isLiked'] ? Icons.favorite : Icons.favorite_border, color: p['isLiked'] ? AppColors.error : AppColors.grey, size: 18), const SizedBox(width: 4), Text('${p['likes']}', style: TextStyle(fontSize: 11, color: p['isLiked'] ? AppColors.error : AppColors.grey))])),
                    const SizedBox(width: 16),
                    GestureDetector(onTap: () => _showComments(p), child: Row(children: [const Icon(Icons.chat_bubble_outline, size: 18, color: AppColors.grey), const SizedBox(width: 4), Text('${p['replies']}', style: const TextStyle(fontSize: 11, color: AppColors.grey))])),
                    const Spacer(),
                    GestureDetector(onTap: () => _toggleSave(idx), child: Icon(p['isSaved'] ? Icons.bookmark : Icons.bookmark_border, color: p['isSaved'] ? AppColors.primary : AppColors.grey, size: 18)),
                    const SizedBox(width: 12),
                    const Icon(Icons.share, size: 18, color: AppColors.grey),
                  ]),
                ]),
              );
            },
          ),
        ),
      ]),
      floatingActionButton: FloatingActionButton(onPressed: _addPost, backgroundColor: AppColors.primary, child: const Icon(Icons.add, color: Colors.white)),
    );
  }
}
