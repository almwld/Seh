import 'package:flutter/material.dart';
import 'package:sehatak/core/constants/app_colors.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});
  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _nameController = TextEditingController(text: 'أحمد محمد');
  final TextEditingController _emailController = TextEditingController(text: 'ahmed@email.com');
  final TextEditingController _phoneController = TextEditingController(text: '+967 777 123 456');
  final TextEditingController _addressController = TextEditingController(text: 'شارع الزبيري، صنعاء');
  final TextEditingController _emergencyContactController = TextEditingController(text: '+967 777 987 654');
  
  String _gender = 'ذكر';
  String _bloodType = 'O+';
  DateTime? _birthDate;
  double _height = 175;
  double _weight = 72;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تعديل الملف الشخصي', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [TextButton(onPressed: () {}, child: const Text('حفظ', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)))],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(14),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // الصورة الشخصية
          Center(
            child: Stack(children: [
              const CircleAvatar(radius: 50, backgroundColor: AppColors.primary, child: Text('أح', style: TextStyle(fontSize: 40, color: Colors.white))),
              Positioned(bottom: 0, right: 0, child: Container(padding: const EdgeInsets.all(6), decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle), child: const Icon(Icons.camera_alt, color: Colors.white, size: 18))),
            ]),
          ),
          const SizedBox(height: 24),

          // المعلومات الأساسية
          _sectionTitle('المعلومات الأساسية'),
          _textField('الاسم الكامل', Icons.person, _nameController),
          _textField('البريد الإلكتروني', Icons.email, _emailController, keyboardType: TextInputType.emailAddress),
          _textField('رقم الهاتف', Icons.phone, _phoneController, keyboardType: TextInputType.phone),
          const SizedBox(height: 18),

          // المعلومات الشخصية
          _sectionTitle('المعلومات الشخصية'),
          _dropdownField('الجنس', Icons.people, _gender, ['ذكر', 'أنثى'], (v) => setState(() => _gender = v!)),
          _dateField('تاريخ الميلاد', Icons.cake, _birthDate, (d) => setState(() => _birthDate = d)),
          _dropdownField('فصيلة الدم', Icons.bloodtype, _bloodType, ['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-'], (v) => setState(() => _bloodType = v!)),
          _textField('العنوان', Icons.location_on, _addressController),
          const SizedBox(height: 18),

          // القياسات
          _sectionTitle('القياسات الجسمية'),
          _sliderField('الطول', '${_height.toInt()} سم', _height, 100, 250, (v) => setState(() => _height = v)),
          _sliderField('الوزن', '${_weight.toInt()} كجم', _weight, 30, 200, (v) => setState(() => _weight = v)),
          const SizedBox(height: 18),

          // اتصال الطوارئ
          _sectionTitle('جهة اتصال طوارئ'),
          _textField('اسم جهة الاتصال', Icons.contact_emergency, _emergencyContactController),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: AppColors.info.withOpacity(0.05), borderRadius: BorderRadius.circular(10), border: Border.all(color: AppColors.info.withOpacity(0.2))),
            child: const Row(children: [Icon(Icons.info, color: AppColors.info, size: 16), SizedBox(width: 8), Expanded(child: Text('سيتم التواصل مع هذا الرقم في الحالات الطارئة', style: TextStyle(fontSize: 10, color: AppColors.info)))]),
          ),
          const SizedBox(height: 24),

          // أزرار
          SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, padding: const EdgeInsets.symmetric(vertical: 14)), child: const Text('حفظ التغييرات', style: TextStyle(fontSize: 16)))),
          const SizedBox(height: 10),
          SizedBox(width: double.infinity, child: OutlinedButton(onPressed: () => Navigator.pop(context), style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14)), child: const Text('إلغاء'))),
          const SizedBox(height: 20),
        ]),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(padding: const EdgeInsets.only(bottom: 10, right: 4), child: Text(title, style: const TextStyle(fontSize: 14, color: AppColors.grey, fontWeight: FontWeight.w600)));
  }

  Widget _textField(String label, IconData icon, TextEditingController controller, {TextInputType keyboardType = TextInputType.text}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 4)]),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        textAlign: TextAlign.right,
        decoration: InputDecoration(labelText: label, prefixIcon: Icon(icon, color: AppColors.primary), border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)), contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12)),
      ),
    );
  }

  Widget _dropdownField(String label, IconData icon, String value, List<String> items, Function(String?) onChange) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 4)]),
      child: DropdownButtonFormField<String>(
        value: value,
        decoration: InputDecoration(labelText: label, prefixIcon: Icon(icon, color: AppColors.primary), border: InputBorder.none),
        items: items.map((i) => DropdownMenuItem(value: i, child: Text(i))).toList(),
        onChanged: onChange,
      ),
    );
  }

  Widget _dateField(String label, IconData icon, DateTime? date, Function(DateTime) onSelected) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 4)]),
      child: ListTile(
        leading: const Icon(Icons.cake, color: AppColors.primary),
        title: Text(label, style: const TextStyle(fontSize: 12, color: AppColors.grey)),
        subtitle: Text(date != null ? '${date.day}/${date.month}/${date.year}' : 'اختر التاريخ', style: const TextStyle(fontWeight: FontWeight.w500)),
        trailing: const Icon(Icons.arrow_drop_down),
        onTap: () async {
          final picked = await showDatePicker(context: context, initialDate: date ?? DateTime(1995), firstDate: DateTime(1940), lastDate: DateTime.now());
          if (picked != null) onSelected(picked);
        },
      ),
    );
  }

  Widget _sliderField(String label, String value, double current, double min, double max, Function(double) onChange) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 4)]),
      child: Column(children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(label), Text(value, style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary))]),
        Slider(value: current, min: min, max: max, activeColor: AppColors.primary, onChanged: onChange),
      ]),
    );
  }
}
