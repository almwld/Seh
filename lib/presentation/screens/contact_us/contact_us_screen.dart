import 'package:flutter/material.dart';
import 'package:sehatak/core/constants/app_colors.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});
  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  String _category = 'استفسار عام';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('تواصل معنا', style: TextStyle(fontWeight: FontWeight.bold))),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(14),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            _contactInfoCard('📧', 'البريد', 'info@sehatak.com', AppColors.primary),
            const SizedBox(width: 8),
            _contactInfoCard('📱', 'الهاتف', '+967 777 123 456', AppColors.success),
            const SizedBox(width: 8),
            _contactInfoCard('🕐', 'الدوام', '24/7', AppColors.info),
          ]),
          const SizedBox(height: 20),
          Text('أرسل رسالة', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 4)]),
            child: DropdownButtonFormField<String>(
              value: _category,
              decoration: const InputDecoration(labelText: 'نوع الاستفسار', prefixIcon: Icon(Icons.category), border: InputBorder.none),
              items: ['استفسار عام', 'مشكلة تقنية', 'اقتراح', 'شكوى', 'طلب تعاون'].map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
              onChanged: (v) => setState(() => _category = v!),
            ),
          ),
          _textField('الاسم', Icons.person, _nameController),
          _textField('البريد الإلكتروني', Icons.email, _emailController, TextInputType.emailAddress),
          _textField('الموضوع', Icons.subject, _subjectController),
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 4)]),
            child: TextField(
              controller: _messageController, maxLines: 4, textAlign: TextAlign.right,
              decoration: InputDecoration(
                labelText: 'الرسالة', hintText: 'اكتب رسالتك هنا...',
                prefixIcon: const Icon(Icons.message),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text('أو تواصل عبر', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            _socialButton(Icons.chat, 'واتساب', const Color(0xFF25D366)),
            _socialButton(Icons.telegram, 'تليجرام', const Color(0xFF0088cc)),
            _socialButton(Icons.facebook, 'فيسبوك', const Color(0xFF1877F2)),
            _socialButton(Icons.alternate_email, 'تويتر', const Color(0xFF1DA1F2)),
          ]),
          const SizedBox(height: 20),
          SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () { ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('تم إرسال رسالتك. سنرد عليك قريباً.'), backgroundColor: AppColors.success)); }, style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, padding: const EdgeInsets.symmetric(vertical: 14)), child: const Text('إرسال الرسالة', style: TextStyle(fontSize: 16)))),
        ]),
      ),
    );
  }

  Widget _contactInfoCard(String emoji, String label, String value, Color color) {
    return Expanded(child: Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: color.withOpacity(0.05), borderRadius: BorderRadius.circular(12)), child: Column(children: [Text(emoji, style: const TextStyle(fontSize: 24)), const SizedBox(height: 4), Text(value, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11, color: color)), Text(label, style: const TextStyle(fontSize: 9, color: AppColors.grey))])));
  }

  Widget _textField(String label, IconData icon, TextEditingController controller, [TextInputType? keyboardType]) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 4)]),
      child: TextField(
        controller: controller, keyboardType: keyboardType, textAlign: TextAlign.right,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }

  Widget _socialButton(IconData icon, String label, Color color) {
    return GestureDetector(
      onTap: () {},
      child: Column(children: [Container(width: 50, height: 50, decoration: BoxDecoration(color: color.withOpacity(0.1), shape: BoxShape.circle), child: Icon(icon, color: color, size: 24)), const SizedBox(height: 4), Text(label, style: const TextStyle(fontSize: 10))]),
    );
  }
}
