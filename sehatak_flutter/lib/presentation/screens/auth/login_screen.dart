import 'package:flutter/material.dart';
import 'package:sehatak/core/constants/app_colors.dart';
import 'package:sehatak/core/services/api_service.dart';
import 'package:sehatak/presentation/screens/home/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _obscurePassword = true;
  bool _obscureConfirm = true;
  bool _agreeTerms = false;
  bool _isLoading = false;

  final _loginEmailController = TextEditingController(text: 'ahmed@email.com');
  final _loginPasswordController = TextEditingController(text: '123456');
  final _registerNameController = TextEditingController();
  final _registerEmailController = TextEditingController();
  final _registerPhoneController = TextEditingController();
  final _registerPasswordController = TextEditingController();
  final _registerConfirmController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  Future<void> _handleLogin() async {
    setState(() => _isLoading = true);
    try {
      final result = await ApiService.login(
        email: _loginEmailController.text.trim(),
        password: _loginPasswordController.text.trim(),
      );
      if (result['token'] != null) {
        if (!mounted) return;
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const HomeScreen()),
          (route) => false,
        );
      } else {
        _showError(result['error'] ?? 'فشل تسجيل الدخول');
      }
    } catch (e) {
      _showError('تعذر الاتصال بالخادم. يعمل التطبيق محلياً.');
      // الدخول بدون API للتطوير
      if (!mounted) return;
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
        (route) => false,
      );
    }
    setState(() => _isLoading = false);
  }

  Future<void> _handleRegister() async {
    if (_registerPasswordController.text != _registerConfirmController.text) {
      _showError('كلمتا المرور غير متطابقتين');
      return;
    }
    setState(() => _isLoading = true);
    try {
      final result = await ApiService.register(
        fullName: _registerNameController.text.trim(),
        email: _registerEmailController.text.trim(),
        phone: _registerPhoneController.text.trim(),
        password: _registerPasswordController.text.trim(),
      );
      if (result['token'] != null) {
        if (!mounted) return;
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const HomeScreen()),
          (route) => false,
        );
      } else {
        _showError(result['error'] ?? 'فشل التسجيل');
      }
    } catch (e) {
      _showError('تعذر الاتصال بالخادم');
    }
    setState(() => _isLoading = false);
  }

  void _showError(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: AppColors.error),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          const SizedBox(height: 20),
          Container(
            width: 80, height: 80,
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [AppColors.primary, AppColors.primaryDark]),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [BoxShadow(color: AppColors.primary.withOpacity(0.3), blurRadius: 15)],
            ),
            child: const Icon(Icons.health_and_safety, color: Colors.white, size: 45),
          ),
          const SizedBox(height: 10),
          const Text('صحتك', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.primary)),
          const Text('صحتك، أولويتنا', style: TextStyle(fontSize: 13, color: AppColors.grey)),
          const SizedBox(height: 16),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 24),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF1A2540) : AppColors.surfaceContainerLow,
              borderRadius: BorderRadius.circular(14),
            ),
            child: TabBar(
              controller: _tabController,
              indicator: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(12)),
              indicatorSize: TabBarIndicatorSize.tab,
              labelColor: Colors.white,
              unselectedLabelColor: AppColors.darkGrey,
              labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              padding: const EdgeInsets.all(4),
              tabs: const [Tab(text: 'تسجيل الدخول'), Tab(text: 'إنشاء حساب')],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildLoginTab(isDark),
                _buildRegisterTab(isDark),
              ],
            ),
          ),
        ]),
      ),
    );
  }

  Widget _buildLoginTab(bool isDark) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        const SizedBox(height: 10),
        const Text('مرحباً بعودتك!', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        const Text('سجل دخولك للمتابعة', style: TextStyle(color: AppColors.grey, fontSize: 14)),
        const SizedBox(height: 28),
        TextField(
          controller: _loginEmailController,
          keyboardType: TextInputType.emailAddress,
          textAlign: TextAlign.right,
          decoration: InputDecoration(
            labelText: 'البريد الإلكتروني',
            prefixIcon: const Icon(Icons.email_outlined),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            filled: true,
            fillColor: isDark ? const Color(0xFF1A2540) : AppColors.surfaceContainerLow.withOpacity(0.5),
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _loginPasswordController,
          obscureText: _obscurePassword,
          textAlign: TextAlign.right,
          decoration: InputDecoration(
            labelText: 'كلمة المرور',
            prefixIcon: const Icon(Icons.lock_outline),
            suffixIcon: IconButton(icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility), onPressed: () => setState(() => _obscurePassword = !_obscurePassword)),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            filled: true,
            fillColor: isDark ? const Color(0xFF1A2540) : AppColors.surfaceContainerLow.withOpacity(0.5),
          ),
        ),
        const SizedBox(height: 8),
        Align(alignment: Alignment.centerLeft, child: TextButton(onPressed: () {}, child: const Text('نسيت كلمة المرور؟'))),
        const SizedBox(height: 20),
        SizedBox(
          height: 54,
          child: ElevatedButton(
            onPressed: _isLoading ? null : _handleLogin,
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)), elevation: 3),
            child: _isLoading ? const CircularProgressIndicator(color: Colors.white) : const Text('تسجيل الدخول', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
        ),
        const SizedBox(height: 24),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Text('ليس لديك حساب؟', style: TextStyle(color: AppColors.darkGrey)),
          TextButton(onPressed: () => _tabController.animateTo(1), child: const Text('إنشاء حساب', style: TextStyle(fontWeight: FontWeight.bold))),
        ]),
      ]),
    );
  }

  Widget _buildRegisterTab(bool isDark) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        const SizedBox(height: 10),
        const Text('انضم إلى صحتك', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        const Text('أنشئ حسابك وابدأ رحلتك الصحية', style: TextStyle(color: AppColors.grey, fontSize: 14)),
        const SizedBox(height: 24),
        TextField(controller: _registerNameController, textAlign: TextAlign.right, decoration: InputDecoration(labelText: 'الاسم الكامل', prefixIcon: const Icon(Icons.person_outline), border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)), filled: true, fillColor: isDark ? const Color(0xFF1A2540) : AppColors.surfaceContainerLow.withOpacity(0.5))),
        const SizedBox(height: 14),
        TextField(controller: _registerEmailController, keyboardType: TextInputType.emailAddress, textAlign: TextAlign.right, decoration: InputDecoration(labelText: 'البريد الإلكتروني', prefixIcon: const Icon(Icons.email_outlined), border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)), filled: true, fillColor: isDark ? const Color(0xFF1A2540) : AppColors.surfaceContainerLow.withOpacity(0.5))),
        const SizedBox(height: 14),
        TextField(controller: _registerPhoneController, keyboardType: TextInputType.phone, textAlign: TextAlign.right, decoration: InputDecoration(labelText: 'رقم الهاتف', prefixIcon: const Icon(Icons.phone_android), border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)), filled: true, fillColor: isDark ? const Color(0xFF1A2540) : AppColors.surfaceContainerLow.withOpacity(0.5))),
        const SizedBox(height: 14),
        TextField(controller: _registerPasswordController, obscureText: _obscurePassword, textAlign: TextAlign.right, decoration: InputDecoration(labelText: 'كلمة المرور', prefixIcon: const Icon(Icons.lock_outline), suffixIcon: IconButton(icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility), onPressed: () => setState(() => _obscurePassword = !_obscurePassword)), border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)), filled: true, fillColor: isDark ? const Color(0xFF1A2540) : AppColors.surfaceContainerLow.withOpacity(0.5))),
        const SizedBox(height: 14),
        TextField(controller: _registerConfirmController, obscureText: _obscureConfirm, textAlign: TextAlign.right, decoration: InputDecoration(labelText: 'تأكيد كلمة المرور', prefixIcon: const Icon(Icons.lock_outline), suffixIcon: IconButton(icon: Icon(_obscureConfirm ? Icons.visibility_off : Icons.visibility), onPressed: () => setState(() => _obscureConfirm = !_obscureConfirm)), border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)), filled: true, fillColor: isDark ? const Color(0xFF1A2540) : AppColors.surfaceContainerLow.withOpacity(0.5))),
        const SizedBox(height: 16),
        Row(children: [Checkbox(value: _agreeTerms, activeColor: AppColors.primary, onChanged: (v) => setState(() => _agreeTerms = v!)), const Expanded(child: Text('أوافق على الشروط والأحكام', style: TextStyle(fontSize: 11, color: AppColors.darkGrey)))]),
        const SizedBox(height: 18),
        SizedBox(
          height: 54,
          child: ElevatedButton(
            onPressed: (_agreeTerms && !_isLoading) ? _handleRegister : null,
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)), elevation: 3),
            child: _isLoading ? const CircularProgressIndicator(color: Colors.white) : const Text('إنشاء حساب', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
        ),
        const SizedBox(height: 24),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Text('لديك حساب بالفعل؟', style: TextStyle(color: AppColors.darkGrey)),
          TextButton(onPressed: () => _tabController.animateTo(0), child: const Text('تسجيل الدخول', style: TextStyle(fontWeight: FontWeight.bold))),
        ]),
      ]),
    );
  }
}
