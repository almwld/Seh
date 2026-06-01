import 'package:flutter/material.dart';
import 'package:sehatak/core/constants/app_colors.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});
  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController _currentPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  
  bool _obscureCurrent = true;
  bool _obscureNew = true;
  bool _obscureConfirm = true;
  
  String _passwordStrength = '';
  Color _strengthColor = AppColors.grey;
  
  void _checkPasswordStrength(String password) {
    int score = 0;
    if (password.length >= 8) score++;
    if (password.contains(RegExp(r'[A-Z]'))) score++;
    if (password.contains(RegExp(r'[0-9]'))) score++;
    if (password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) score++;
    
    setState(() {
      switch (score) {
        case 0:
        case 1:
          _passwordStrength = 'ضعيفة';
          _strengthColor = AppColors.error;
          break;
        case 2:
          _passwordStrength = 'متوسطة';
          _strengthColor = AppColors.warning;
          break;
        case 3:
          _passwordStrength = 'قوية';
          _strengthColor = AppColors.info;
          break;
        case 4:
          _passwordStrength = 'قوية جداً';
          _strengthColor = AppColors.success;
          break;
      }
    });
  }

  bool _canSave() {
    return _currentPasswordController.text.isNotEmpty &&
           _newPasswordController.text.isNotEmpty &&
           _newPasswordController.text == _confirmPasswordController.text &&
           _newPasswordController.text.length >= 6;
  }

  void _savePassword() {
    if (!_canSave()) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('يرجى التأكد من صحة البيانات')));
      return;
    }
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('تم بنجاح'),
        content: const Text('تم تغيير كلمة المرور بنجاح'),
        actions: [TextButton(onPressed: () { Navigator.pop(context); Navigator.pop(context); }, child: const Text('حسناً'))],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('تغيير كلمة المرور', style: TextStyle(fontWeight: FontWeight.bold))),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(14),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // أيقونة
          Center(
            child: Container(
              width: 80, height: 80,
              decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.08), shape: BoxShape.circle),
              child: const Icon(Icons.lock_outline, color: AppColors.primary, size: 40),
            ),
          ),
          const SizedBox(height: 24),

          // كلمة المرور الحالية
          TextField(
            controller: _currentPasswordController,
            obscureText: _obscureCurrent,
            textAlign: TextAlign.right,
            decoration: InputDecoration(
              labelText: 'كلمة المرور الحالية',
              hintText: 'أدخل كلمة المرور الحالية',
              prefixIcon: const Icon(Icons.lock_outline),
              suffixIcon: IconButton(icon: Icon(_obscureCurrent ? Icons.visibility_off : Icons.visibility), onPressed: () => setState(() => _obscureCurrent = !_obscureCurrent)),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              filled: true,
              fillColor: AppColors.surfaceContainerLow.withOpacity(0.3),
            ),
          ),
          const SizedBox(height: 14),

          // كلمة المرور الجديدة
          TextField(
            controller: _newPasswordController,
            obscureText: _obscureNew,
            textAlign: TextAlign.right,
            onChanged: _checkPasswordStrength,
            decoration: InputDecoration(
              labelText: 'كلمة المرور الجديدة',
              hintText: 'أدخل كلمة المرور الجديدة',
              prefixIcon: const Icon(Icons.lock),
              suffixIcon: IconButton(icon: Icon(_obscureNew ? Icons.visibility_off : Icons.visibility), onPressed: () => setState(() => _obscureNew = !_obscureNew)),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              filled: true,
              fillColor: AppColors.surfaceContainerLow.withOpacity(0.3),
            ),
          ),
          // مؤشر القوة
          if (_newPasswordController.text.isNotEmpty) ...[
            const SizedBox(height: 8),
            Row(children: [
              const Text('قوة كلمة المرور: ', style: TextStyle(fontSize: 12, color: AppColors.grey)),
              Text(_passwordStrength, style: TextStyle(fontWeight: FontWeight.bold, color: _strengthColor, fontSize: 12)),
              const SizedBox(width: 8),
              Expanded(child: LinearProgressIndicator(
                value: _passwordStrength == 'ضعيفة' ? 0.25 : _passwordStrength == 'متوسطة' ? 0.5 : _passwordStrength == 'قوية' ? 0.75 : 1.0,
                color: _strengthColor, backgroundColor: AppColors.surfaceContainerLow, minHeight: 4, borderRadius: BorderRadius.circular(2),
              )),
            ]),
            const SizedBox(height: 4),
          ],
          const SizedBox(height: 14),

          // تأكيد كلمة المرور
          TextField(
            controller: _confirmPasswordController,
            obscureText: _obscureConfirm,
            textAlign: TextAlign.right,
            decoration: InputDecoration(
              labelText: 'تأكيد كلمة المرور',
              hintText: 'أعد كتابة كلمة المرور الجديدة',
              prefixIcon: const Icon(Icons.lock),
              suffixIcon: IconButton(icon: Icon(_obscureConfirm ? Icons.visibility_off : Icons.visibility), onPressed: () => setState(() => _obscureConfirm = !_obscureConfirm)),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              filled: true,
              fillColor: AppColors.surfaceContainerLow.withOpacity(0.3),
            ),
          ),
          // رسالة التطابق
          if (_confirmPasswordController.text.isNotEmpty) ...[
            const SizedBox(height: 6),
            Row(children: [
              Icon(_newPasswordController.text == _confirmPasswordController.text ? Icons.check_circle : Icons.cancel, size: 14, color: _newPasswordController.text == _confirmPasswordController.text ? AppColors.success : AppColors.error),
              const SizedBox(width: 6),
              Text(_newPasswordController.text == _confirmPasswordController.text ? 'كلمتا المرور متطابقتان' : 'كلمتا المرور غير متطابقتين', style: TextStyle(fontSize: 11, color: _newPasswordController.text == _confirmPasswordController.text ? AppColors.success : AppColors.error)),
            ]),
          ],
          const SizedBox(height: 24),

          // نصائح
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(color: AppColors.warning.withOpacity(0.05), borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.warning.withOpacity(0.15))),
            child: const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [Icon(Icons.tips_and_updates, color: AppColors.warning, size: 18), SizedBox(width: 6), Text('نصائح لكلمة مرور آمنة', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14))]),
              SizedBox(height: 8),
              Text('• 8 أحرف على الأقل', style: TextStyle(fontSize: 11)),
              Text('• حرف كبير وصغير', style: TextStyle(fontSize: 11)),
              Text('• رقم واحد على الأقل', style: TextStyle(fontSize: 11)),
              Text('• رمز خاص (!@#\$%^&*)', style: TextStyle(fontSize: 11)),
              Text('• لا تستخدم كلمة المرور نفسها لحسابات أخرى', style: TextStyle(fontSize: 11)),
            ]),
          ),
          const SizedBox(height: 24),

          // زر الحفظ
          SizedBox(width: double.infinity, child: ElevatedButton(onPressed: _canSave() ? _savePassword : null, style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 14), disabledBackgroundColor: AppColors.grey.withOpacity(0.3)), child: const Text('حفظ كلمة المرور الجديدة', style: TextStyle(fontSize: 16)))),
          const SizedBox(height: 30),
        ]),
      ),
    );
  }
}
