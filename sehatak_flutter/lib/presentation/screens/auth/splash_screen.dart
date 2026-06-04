import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sehatak/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'onboarding_screen.dart';
import '../home/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animCtrl;
  late Animation<double> _fadeIn;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _animCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 1500));
    _fadeIn = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _animCtrl, curve: const Interval(0.0, 0.6, curve: Curves.easeIn)));
    _scale = Tween(begin: 0.5, end: 1.0).animate(CurvedAnimation(parent: _animCtrl, curve: const Interval(0.0, 0.6, curve: Curves.elasticOut)));
    _animCtrl.forward();
    _navigate();
  }

  Future<void> _navigate() async {
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;

    final prefs = await SharedPreferences.getInstance();
    final isFirstTime = prefs.getBool('onboarding_shown') ?? true;

    if (isFirstTime) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const OnboardingScreen()));
    } else {
      final authState = context.read<AuthBloc>().state;
      if (authState is Authenticated) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeScreen()));
      } else {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const OnboardingScreen()));
      }
    }
  }

  @override
  void dispose() {
    _animCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Color(0xFF00796B), Color(0xFF004D40), Color(0xFF00251A)]),
        ),
        child: Center(
          child: AnimatedBuilder(
            animation: _animCtrl,
            builder: (_, child) => Opacity(opacity: _fadeIn.value, child: Transform.scale(scale: _scale.value, child: child)),
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(width: 100, height: 100, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(28), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 20)]), child: const Icon(Icons.health_and_safety, size: 55, color: Color(0xFF00796B))),
              const SizedBox(height: 24),
              const Text('SEHATAK', style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: 3, fontFamily: 'Rubik')),
              const SizedBox(height: 8),
              const Text('صحتك', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white, fontFamily: 'Cairo')),
              const SizedBox(height: 40),
              SizedBox(width: 30, height: 30, child: CircularProgressIndicator(strokeWidth: 2.5, valueColor: AlwaysStoppedAnimation<Color>(Colors.white.withOpacity(0.8)))),
            ]),
          ),
        ),
      ),
    );
  }
}
