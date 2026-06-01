import 'package:flutter/material.dart';
import 'package:sehatak/core/constants/app_colors.dart';

class MedicalNotesScreen extends StatefulWidget {
  const MedicalNotesScreen({super.key});
  @override
  State<MedicalNotesScreen> createState() => _MedicalNotesScreenState();
}

class _MedicalNotesScreenState extends State<MedicalNotesScreen> {
  final List<Map<String, dynamic>> _notes = [
    {
      'title': 'أعراض الصداع',
      'content': 'صداع في الجانب الأيمن يستمر 2-3 ساعات. يحدث عادة في المساء بعد العمل. لاحظت أنه يزداد مع التوتر وقلة النوم.',
      'date': '1 مايو 2026',
      'color': AppColors.warning,
      'icon': '🤕',
      'category': 'أعراض',
      'pinned': true,
    },
    {
      'title': 'قراءات الضغط الأسبوعية',
      'content': 'السبت: 128/82\nالأحد: 132/85\nالإثنين: 126/80\nالثلاثاء: 130/84\nالأربعاء: 125/79\nنصحني الدكتور بمواصلة المراقبة وتقليل الملح.',
      'date': '28 أبريل 2026',
      'color': AppColors.info,
      'icon': '🩺',
      'category': 'قياسات',
      'pinned': false,
    },
    {
      'title': 'موعد المختبر',
      'content': 'حجزت موعد تحليل دم شامل يوم 15 مايو الساعة 8 صباحاً في مختبر الثقة. يجب الصيام 8 ساعات قبل التحليل.',
      'date': '25 أبريل 2026',
      'color': AppColors.success,
      'icon': '📅',
      'category': 'مواعيد',
      'pinned': false,
    },
  ];

  String _searchQuery = '';
  String _filterCategory = 'الكل';
  final List<String> _categories = ['الكل', 'أعراض', 'قياسات', 'مواعيد', 'أدوية', 'أخرى'];

  List<Map<String, dynamic>> get _filteredNotes {
    var notes = _notes;
    if (_filterCategory != 'الكل') {
      notes = notes.where((n) => n['category'] == _filterCategory).toList();
    }
    if (_searchQuery.isNotEmpty) {
      notes = notes.where((n) => (n['title'] as String).toLowerCase().contains(_searchQuery.toLowerCase()) || (n['content'] as String).toLowerCase().contains(_searchQuery.toLowerCase())).toList();
    }
    // مثبتة أولاً
    notes.sort((a, b) => (b['pinned'] as bool).toString().compareTo((a['pinned'] as bool).toString()));
    return notes;
  }

  void _addNote() {
    _showNoteDialog();
  }

  void _editNote(int index) {
    _showNoteDialog(noteIndex: index);
  }

  void _deleteNote(int index) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('حذف الملاحظة'),
        content: const Text('هل أنت متأكد من حذف هذه الملاحظة؟'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('إلغاء')),
          ElevatedButton(onPressed: () { setState(() => _notes.removeAt(index)); Navigator.pop(context); ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('تم حذف الملاحظة'), backgroundColor: AppColors.error)); }, style: ElevatedButton.styleFrom(backgroundColor: AppColors.error), child: const Text('حذف')),
        ],
      ),
    );
  }

  void _togglePin(int index) {
    setState(() => _notes[index]['pinned'] = !(_notes[index]['pinned'] as bool));
  }

  void _showNoteDialog({int? noteIndex}) {
    final isEdit = noteIndex != null;
    final titleController = TextEditingController(text: isEdit ? _notes[noteIndex]['title'] : '');
    final contentController = TextEditingController(text: isEdit ? _notes[noteIndex]['content'] : '');
    String category = isEdit ? _notes[noteIndex]['category'] : 'أخرى';
    String emoji = isEdit ? _notes[noteIndex]['icon'] : '📝';
    Color noteColor = isEdit ? _notes[noteIndex]['color'] : AppColors.primary;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => StatefulBuilder(
        builder: (context, setModalState) => Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, left: 20, right: 20, top: 20),
          child: SingleChildScrollView(
            child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
              Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(2)))),
              const SizedBox(height: 16),
              Text(isEdit ? 'تعديل الملاحظة' : 'إضافة ملاحظة', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 14),

              // اختيار أيقونة ولون
              Row(children: [
                _emojiPicker(emoji, (e) => setModalState(() => emoji = e)),
                const SizedBox(width: 10),
                _colorPicker(noteColor, (c) => setModalState(() => noteColor = c)),
              ]),
              const SizedBox(height: 10),

              // العنوان
              TextField(
                controller: titleController,
                textAlign: TextAlign.right,
                decoration: InputDecoration(
                  labelText: 'العنوان',
                  hintText: 'أدخل عنوان الملاحظة',
                  prefixIcon: const Icon(Icons.title),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 10),

              // التصنيف
              DropdownButtonFormField<String>(
                value: category,
                decoration: InputDecoration(labelText: "التصنيف", prefixIcon: const Icon(Icons.category), border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
                items: ['أعراض', 'قياسات', 'مواعيد', 'أدوية', 'أخرى'].map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
                onChanged: (v) => setModalState(() => category = v!),
              ),
              const SizedBox(height: 10),

              // المحتوى
              TextField(
                controller: contentController,
                maxLines: 5,
                textAlign: TextAlign.right,
                decoration: InputDecoration(
                  labelText: 'المحتوى',
                  hintText: 'اكتب ملاحظتك هنا...',
                  prefixIcon: const Icon(Icons.notes),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 16),

              // أزرار
              Row(children: [
                Expanded(child: OutlinedButton(onPressed: () => Navigator.pop(context), style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14)), child: const Text('إلغاء'))),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      if (titleController.text.trim().isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('يرجى إدخال العنوان')));
                        return;
                      }
                      final note = {
                        'title': titleController.text,
                        'content': contentController.text,
                        'date': '${DateTime.now().day} ${_getMonth(DateTime.now().month)} ${DateTime.now().year}',
                        'color': noteColor,
                        'icon': emoji,
                        'category': category,
                        'pinned': isEdit ? _notes[noteIndex!]['pinned'] : false,
                      };
                      setState(() {
                        if (isEdit) {
                          _notes[noteIndex!] = note;
                        } else {
                          _notes.insert(0, note);
                        }
                      });
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(isEdit ? 'تم تعديل الملاحظة' : 'تمت إضافة الملاحظة'), backgroundColor: AppColors.success));
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, padding: const EdgeInsets.symmetric(vertical: 14)),
                    child: Text(isEdit ? 'حفظ التعديلات' : 'إضافة'),
                  ),
                ),
              ]),
              const SizedBox(height: 20),
            ]),
          ),
        ),
      ),
    );
  }

  Widget _emojiPicker(String selected, Function(String) onSelect) {
    final emojis = ['📝', '🤕', '🩺', '📅', '💊', '🔬', '💡', '⚠️', '✅', '❤️', '🧠', '🦷', '👁️', '🫀', '💪', '🍎'];
    return Container(
      width: 50, height: 50,
      decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.05), borderRadius: BorderRadius.circular(12)),
      child: PopupMenuButton<String>(
        child: Center(child: Text(selected, style: const TextStyle(fontSize: 24))),
        onSelected: onSelect,
        itemBuilder: (_) => [
          PopupMenuItem(
            enabled: false,
            child: Wrap(spacing: 8, children: emojis.map((e) => GestureDetector(
              onTap: () { Navigator.pop(context); onSelect(e); },
              child: Container(padding: const EdgeInsets.all(6), decoration: BoxDecoration(color: selected == e ? AppColors.primary.withOpacity(0.2) : Colors.transparent, borderRadius: BorderRadius.circular(8)), child: Text(e, style: const TextStyle(fontSize: 24))),
            )).toList()),
          ),
        ],
      ),
    );
  }

  Widget _colorPicker(Color selected, Function(Color) onSelect) {
    final colors = [AppColors.primary, AppColors.success, AppColors.info, AppColors.warning, AppColors.error, AppColors.purple, AppColors.teal, AppColors.amber, AppColors.orange];
    return Container(
      width: 50, height: 50,
      decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.05), borderRadius: BorderRadius.circular(12)),
      child: PopupMenuButton<Color>(
        child: Center(child: Container(width: 24, height: 24, decoration: BoxDecoration(color: selected, shape: BoxShape.circle))),
        onSelected: onSelect,
        itemBuilder: (_) => [
          PopupMenuItem(
            enabled: false,
            child: Wrap(spacing: 8, children: colors.map((c) => GestureDetector(
              onTap: () { Navigator.pop(context); onSelect(c); },
              child: Container(width: 30, height: 30, decoration: BoxDecoration(color: c, shape: BoxShape.circle, border: Border.all(color: selected == c ? AppColors.dark : Colors.transparent, width: 2))),
            )).toList()),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredNotes;

    return Scaffold(
      appBar: AppBar(
        title: const Text('ملاحظاتي الطبية', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [IconButton(icon: const Icon(Icons.search), onPressed: () => _showSearch())],
      ),
      body: Column(children: [
        // تصنيفات
        SizedBox(
          height: 45,
          child: ListView.separated(
            scrollDirection: Axis.horizontal, padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            itemCount: _categories.length, separatorBuilder: (_, __) => const SizedBox(width: 4),
            itemBuilder: (context, idx) {
              final c = _categories[idx];
              final selected = _filterCategory == c;
              return ChoiceChip(label: Text(c, style: const TextStyle(fontSize: 11)), selected: selected, selectedColor: AppColors.primary, labelStyle: TextStyle(color: selected ? Colors.white : AppColors.darkGrey), onSelected: (v) => setState(() => _filterCategory = v! ? c : 'الكل'));
            },
          ),
        ),
        const Divider(height: 1),
        // النتيجة
        Expanded(
          child: filtered.isEmpty
              ? Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  const Icon(Icons.note_add, size: 60, color: AppColors.grey),
                  const SizedBox(height: 10),
                  const Text('لا توجد ملاحظات', style: TextStyle(color: AppColors.grey, fontSize: 16)),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(onPressed: _addNote, icon: const Icon(Icons.add), label: const Text('إضافة أول ملاحظة'), style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary)),
                ]))
              : ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: filtered.length,
                  itemBuilder: (context, idx) {
                    final n = filtered[idx];
                    final originalIndex = _notes.indexOf(n);
                    return Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 6)]),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Row(children: [
                          Container(width: 36, height: 36, decoration: BoxDecoration(color: (n['color'] as Color).withOpacity(0.1), borderRadius: BorderRadius.circular(8)), child: Center(child: Text(n['icon'], style: const TextStyle(fontSize: 18)))),
                          const SizedBox(width: 8),
                          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Row(children: [
                              Expanded(child: Text(n['title'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14))),
                              if (n['pinned']) const Icon(Icons.push_pin, color: AppColors.warning, size: 16),
                            ]),
                            Text(n['date'], style: const TextStyle(fontSize: 9, color: AppColors.grey)),
                          ])),
                          Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: (n['color'] as Color).withOpacity(0.1), borderRadius: BorderRadius.circular(4)), child: Text(n['category'], style: TextStyle(fontSize: 8, color: n['color']))),
                        ]),
                        const SizedBox(height: 8),
                        Text(n['content'], style: const TextStyle(fontSize: 12, color: AppColors.darkGrey, height: 1.4)),
                        const SizedBox(height: 8),
                        Row(children: [
                          IconButton(icon: Icon(Icons.push_pin, color: n['pinned'] ? AppColors.warning : AppColors.grey, size: 18), onPressed: () => _togglePin(originalIndex), tooltip: 'تثبيت', constraints: const BoxConstraints()),
                          IconButton(icon: const Icon(Icons.edit, size: 18, color: AppColors.info), onPressed: () => _editNote(originalIndex), tooltip: 'تعديل', constraints: const BoxConstraints()),
                          IconButton(icon: const Icon(Icons.delete, size: 18, color: AppColors.error), onPressed: () => _deleteNote(originalIndex), tooltip: 'حذف', constraints: const BoxConstraints()),
                          const Spacer(),
                          IconButton(icon: const Icon(Icons.share, size: 18, color: AppColors.grey), onPressed: () {}, tooltip: 'مشاركة', constraints: const BoxConstraints()),
                        ]),
                      ]),
                    );
                  },
                ),
        ),
      ]),
      floatingActionButton: FloatingActionButton(onPressed: _addNote, backgroundColor: AppColors.primary, child: const Icon(Icons.add, color: Colors.white)),
    );
  }

  void _showSearch() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('بحث في الملاحظات'),
        content: TextField(
          autofocus: true,
          textAlign: TextAlign.right,
          decoration: InputDecoration(hintText: 'ابحث...', prefixIcon: const Icon(Icons.search), border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
          onChanged: (v) => setState(() => _searchQuery = v),
        ),
        actions: [TextButton(onPressed: () { setState(() => _searchQuery = ''); Navigator.pop(context); }, child: const Text('إغلاق'))],
      ),
    );
  }

  String _getMonth(int m) {
    const months = ['', 'يناير', 'فبراير', 'مارس', 'إبريل', 'مايو', 'يونيو', 'يوليو', 'أغسطس', 'سبتمبر', 'أكتوبر', 'نوفمبر', 'ديسمبر'];
    return months[m];
  }
}
