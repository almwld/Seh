import 'package:flutter/material.dart';
import 'package:sehatak/core/constants/app_colors.dart';

class VisionTestScreen extends StatefulWidget {
  const VisionTestScreen({super.key});
  @override
  State<VisionTestScreen> createState() => _VisionTestScreenState();
}

class _VisionTestScreenState extends State<VisionTestScreen> {
  int _currentTest = 0;
  int _score = 0;
  bool _testDone = false;

  final List<Map<String, dynamic>> _questions = const [
    {'question': 'ما الرقم الذي تراه؟', 'image': '6/6', 'answers': ['9', '6', '8', '0'], 'correct': 1},
    {'question': 'ما الحرف الذي تراه؟', 'image': 'E', 'answers': ['E', 'F', 'B', 'P'], 'correct': 0},
    {'question': 'ما الرقم الذي تراه؟', 'image': '3/8', 'answers': ['3', '6', '8', '0'], 'correct': 2},
    {'question': 'ما الحرف الذي تراه؟', 'image': 'C', 'answers': ['G', 'O', 'C', 'Q'], 'correct': 2},
    {'question': 'ما الرقم الذي تراه؟', 'image': '5/2', 'answers': ['2', '5', '3', '7'], 'correct': 1},
  ];

  void _answer(int answerIndex) {
    if (_questions[_currentTest]['correct'] == answerIndex) {
      _score++;
    }
    if (_currentTest < _questions.length - 1) {
      setState(() => _currentTest++);
    } else {
      setState(() => _testDone = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('فحص النظر', style: TextStyle(fontWeight: FontWeight.bold))),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(14),
        child: _testDone ? _buildResult() : _buildTest(),
      ),
    );
  }

  Widget _buildTest() {
    final q = _questions[_currentTest];
    return Column(children: [
      LinearProgressIndicator(value: (_currentTest) / _questions.length, backgroundColor: AppColors.surfaceContainerLow, color: AppColors.primary, minHeight: 6, borderRadius: BorderRadius.circular(3)),
      const SizedBox(height: 20),
      Text('سؤال ${_currentTest + 1} من ${_questions.length}', style: const TextStyle(color: AppColors.grey)),
      const SizedBox(height: 30),
      Container(
        width: 200, height: 200,
        decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.primary.withOpacity(0.05), border: Border.all(color: AppColors.primary, width: 3)),
        child: Center(child: Text(q['image'], style: const TextStyle(fontSize: 80, fontWeight: FontWeight.bold, color: AppColors.primary))),
      ),
      const SizedBox(height: 30),
      Text(q['question'], style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      const SizedBox(height: 20),
      ...(q['answers'] as List).asMap().entries.map((e) => Container(
        margin: const EdgeInsets.only(bottom: 8),
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () => _answer(e.key),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: AppColors.dark, padding: const EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: BorderSide(color: AppColors.outlineVariant))),
          child: Text(e.value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
      )),
    ]);
  }

  Widget _buildResult() {
    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Icon(_score >= 4 ? Icons.visibility : Icons.visibility_off, size: 80, color: _score >= 4 ? AppColors.success : AppColors.warning),
        const SizedBox(height: 20),
        Text('النتيجة: $_score/${_questions.length}', style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Text(_score >= 4 ? '👁️ نظرك جيد! استمر بالفحص الدوري' : '⚠️ ننصحك بمراجعة طبيب العيون', style: const TextStyle(fontSize: 16, color: AppColors.darkGrey)),
        const SizedBox(height: 30),
        ElevatedButton(onPressed: () => setState(() { _currentTest = 0; _score = 0; _testDone = false; }), style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14)), child: const Text('إعادة الاختبار')),
      ]),
    );
  }
}
