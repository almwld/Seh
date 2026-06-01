import 'package:flutter/material.dart';
import 'package:sehatak/core/constants/app_colors.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, dynamic>> _messages = [
    {'text': 'السلام عليكم! 😊\nكيف يمكنني مساعدتك اليوم؟', 'isMe': false, 'time': '9:30 ص'},
    {'text': 'وعليكم السلام د. عائشة.\nعندي صداع وحمى خفيفة من أمس.', 'isMe': true, 'time': '9:31 ص'},
    {'text': 'آسف لسماع ذلك 😔\nهل قست درجة حرارتك؟ وما الأعراض الأخرى؟', 'isMe': false, 'time': '9:32 ص'},
    {'text': 'نعم، 38 درجة. أيضاً ألم في الجسم وتعب.', 'isMe': true, 'time': '9:33 ص'},
    {'text': 'شكراً للمعلومات.\nيرجى الاطلاع على توصياتي أدناه.', 'isMe': false, 'time': '9:35 ص', 'attachment': 'وصفة طبية وتوصيات\nPDF • 245 KB'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(children: [const CircleAvatar(radius: 16, child: Icon(Icons.person, size: 16)), const SizedBox(width: 6), const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('د. عائشة رحمن', style: TextStyle(fontSize: 13)), Text('⭐ 4.9 • متصل الآن', style: TextStyle(fontSize: 9, color: AppColors.grey))])]),
        actions: [IconButton(icon: const Icon(Icons.videocam), onPressed: () {}), IconButton(icon: const Icon(Icons.call), onPressed: () {})],
      ),
      body: Column(children: [
        Container(padding: const EdgeInsets.all(8), color: AppColors.primary.withOpacity(0.03), child: const Row(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.lock, size: 12, color: AppColors.grey), SizedBox(width: 4), Text('محادثة آمنة ومشفرة', style: TextStyle(fontSize: 10, color: AppColors.grey))])),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: _messages.length,
            itemBuilder: (context, index) {
              final msg = _messages[index];
              return Align(
                alignment: msg['isMe'] ? Alignment.centerRight : Alignment.centerLeft,
                child: Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(12),
                  constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
                  decoration: BoxDecoration(
                    color: msg['isMe'] ? AppColors.primary : AppColors.surfaceContainerLow,
                    borderRadius: BorderRadius.only(topLeft: const Radius.circular(14), topRight: const Radius.circular(14), bottomLeft: msg['isMe'] ? const Radius.circular(14) : Radius.zero, bottomRight: msg['isMe'] ? Radius.zero : const Radius.circular(14)),
                  ),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(msg['text'], style: TextStyle(color: msg['isMe'] ? Colors.white : Colors.black87, fontSize: 12)),
                    if (msg['attachment'] != null) ...[
                      const SizedBox(height: 6),
                      Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: msg['isMe'] ? Colors.white.withOpacity(0.2) : AppColors.primary.withOpacity(0.08), borderRadius: BorderRadius.circular(8)), child: Row(children: [const Icon(Icons.picture_as_pdf, color: AppColors.error, size: 16), const SizedBox(width: 6), Text(msg['attachment'], style: TextStyle(fontSize: 9, color: msg['isMe'] ? Colors.white : AppColors.darkGrey))])),
                    ],
                    const SizedBox(height: 4),
                    Text(msg['time'], style: TextStyle(fontSize: 8, color: msg['isMe'] ? Colors.white60 : AppColors.grey)),
                  ]),
                ),
              );
            },
          ),
        ),
        Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 4)]), child: Row(children: [
          IconButton(icon: const Icon(Icons.attach_file, color: AppColors.grey), onPressed: () {}),
          Expanded(child: TextField(controller: _controller, textAlign: TextAlign.right, decoration: InputDecoration(hintText: 'اكتب رسالتك...', filled: true, fillColor: AppColors.surfaceContainerLow, border: OutlineInputBorder(borderRadius: BorderRadius.circular(24), borderSide: BorderSide.none), contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8)))),
          const SizedBox(width: 4),
          CircleAvatar(backgroundColor: AppColors.primary, child: IconButton(icon: const Icon(Icons.send, color: Colors.white, size: 16), onPressed: () { if (_controller.text.isNotEmpty) { setState(() => _messages.add({'text': _controller.text, 'isMe': true, 'time': 'الآن'})); _controller.clear(); } })),
        ])),
      ]),
    );
  }
}
