import 'package:flutter/material.dart';
import 'package:sehatak/core/constants/app_colors.dart';
import 'package:sehatak/core/services/medical_ai_local.dart';

class SmartClinicScreen extends StatefulWidget {
  const SmartClinicScreen({super.key});
  @override
  State<SmartClinicScreen> createState() => _SmartClinicScreenState();
}

class _SmartClinicScreenState extends State<SmartClinicScreen> {
  final _ai = LocalMedicalAI();
  final _controller = TextEditingController();
  final List<Map<String, String>> _chat = [];
  bool _isTyping = false;

  void _send(String text) {
    if (text.trim().isEmpty) return;
    setState(() {
      _chat.add({'role': 'user', 'text': text});
      _isTyping = true;
    });
    _controller.clear();

    Future.delayed(const Duration(milliseconds: 800), () {
      final reply = _ai.chatbotRespond(text);
      String fullReply = reply;
      if (RegExp(r'عندي|اعاني|احس|اشعر|الم|وجع|صداع|حرارة|سعال').hasMatch(text)) {
        final triage = _ai.triage(text);
        fullReply += '\n\n🔍 تحليل سريع:\n• التخصص: ${triage['specialization']}\n• الطوارئ: ${triage['urgency']}\n• الإجراء: ${triage['action']}';
      }
      setState(() {
        _chat.add({'role': 'bot', 'text': fullReply});
        _isTyping = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('المساعد الذكي 🤖'), backgroundColor: AppColors.primary),
      body: Column(children: [
        Container(
          padding: const EdgeInsets.all(8),
          color: AppColors.warning.withOpacity(0.08),
          child: const Row(children: [
            Icon(Icons.info, size: 14, color: AppColors.warning),
            SizedBox(width: 4),
            Expanded(child: Text('يعمل محلياً بدون إنترنت', style: TextStyle(fontSize: 10))),
          ]),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: _chat.length + (_isTyping ? 1 : 0),
            itemBuilder: (context, i) {
              if (_isTyping && i == _chat.length) {
                return const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Text('...يكتب', style: TextStyle(color: AppColors.grey)),
                  ),
                );
              }
              final msg = _chat[i];
              final isUser = msg['role'] == 'user';
              return Align(
                alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                child: Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(12),
                  constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.82),
                  decoration: BoxDecoration(
                    color: isUser ? AppColors.primary : Theme.of(context).colorScheme.surfaceVariant,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Text(msg['text']!, style: TextStyle(color: isUser ? Colors.white : null, fontSize: 13)),
                ),
              );
            },
          ),
        ),
        SizedBox(
          height: 42,
          child: ListView(scrollDirection: Axis.horizontal, padding: const EdgeInsets.symmetric(horizontal: 8), children: [
            _quickChip('🤒 أعراض', 'عندي صداع وحرارة'),
            _quickChip('💊 باراسيتامول', 'باراسيتامول'),
            _quickChip('💎 الباقات', 'كم سعر الباقة'),
            _quickChip('📅 حجز', 'كيف احجز موعد'),
            _quickChip('💡 نصيحة', 'نصيحة'),
          ]),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 4)]),
          child: Row(children: [
            Expanded(child: TextField(
              controller: _controller,
              textAlign: TextAlign.right,
              decoration: InputDecoration(
                hintText: 'اسألني...',
                filled: true,
                fillColor: AppColors.surfaceContainerLow,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(24), borderSide: BorderSide.none),
                contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              ),
            )),
            const SizedBox(width: 4),
            CircleAvatar(
              backgroundColor: AppColors.primary,
              child: IconButton(
                icon: const Icon(Icons.send, color: Colors.white, size: 18),
                onPressed: () => _send(_controller.text),
              ),
            ),
          ]),
        ),
      ]),
    );
  }

  Widget _quickChip(String label, String query) {
    return Padding(
      padding: const EdgeInsets.only(right: 6),
      child: ActionChip(label: Text(label, style: const TextStyle(fontSize: 11)), onPressed: () => _send(query)),
    );
  }
}
