import 'package:flutter/material.dart';
import 'package:sehatak/core/constants/app_colors.dart';

class VideoConsultScreen extends StatefulWidget {
  const VideoConsultScreen({super.key});
  @override
  State<VideoConsultScreen> createState() => _VideoConsultScreenState();
}

class _VideoConsultScreenState extends State<VideoConsultScreen> {
  bool _isMuted = false;
  bool _isVideoOff = false;
  bool _isSpeakerOn = true;
  int _callDuration = 0;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () {
      _startTimer();
    });
  }

  void _startTimer() {
    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 1));
      if (!mounted) return false;
      setState(() => _callDuration++);
      return true;
    });
  }

  String get _formattedTime {
    final min = (_callDuration ~/ 60).toString().padLeft(2, '0');
    final sec = (_callDuration % 60).toString().padLeft(2, '0');
    return '$min:$sec';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      body: SafeArea(
        child: Stack(children: [
          // فيديو الطبيب
          Center(
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                width: 200, height: 200,
                decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.primary.withOpacity(0.2), border: Border.all(color: AppColors.primary, width: 3)),
                child: const Center(child: Text('👨‍⚕️', style: TextStyle(fontSize: 80))),
              ),
              const SizedBox(height: 20),
              const Text('د. حسن رضا', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
              const Text('طبيب عام • متصل', style: TextStyle(color: Colors.white60, fontSize: 13)),
              const SizedBox(height: 6),
              Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4), decoration: BoxDecoration(color: AppColors.success.withOpacity(0.2), borderRadius: BorderRadius.circular(12)), child: Text(_formattedTime, style: const TextStyle(color: AppColors.success, fontWeight: FontWeight.bold, fontSize: 14))),
            ]),
          ),
          // صورة المريض (صغيرة)
          Positioned(
            top: 20, right: 20,
            child: Container(
              width: 100, height: 140,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: AppColors.dark, border: Border.all(color: Colors.white24, width: 2)),
              child: const Center(child: Text('👤', style: TextStyle(fontSize: 40))),
            ),
          ),
          // أزرار التحكم
          Positioned(
            bottom: 40, left: 20, right: 20,
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              _controlButton(Icons.mic, _isMuted ? 'كتم' : 'مايك', _isMuted ? AppColors.error : Colors.white, () => setState(() => _isMuted = !_isMuted)),
              _controlButton(Icons.videocam, _isVideoOff ? 'كاميرا' : 'فيديو', _isVideoOff ? AppColors.error : Colors.white, () => setState(() => _isVideoOff = !_isVideoOff)),
              _controlButton(Icons.volume_up, _isSpeakerOn ? 'سماعة' : 'صامت', _isSpeakerOn ? Colors.white : AppColors.warning, () => setState(() => _isSpeakerOn = !_isSpeakerOn)),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(width: 60, height: 60, decoration: const BoxDecoration(color: AppColors.error, shape: BoxShape.circle), child: const Icon(Icons.call_end, color: Colors.white, size: 28)),
              ),
            ]),
          ),
        ]),
      ),
    );
  }

  Widget _controlButton(IconData icon, String label, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(children: [
        Container(width: 50, height: 50, decoration: BoxDecoration(color: color.withOpacity(0.2), shape: BoxShape.circle), child: Icon(icon, color: color, size: 24)),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(color: Colors.white, fontSize: 10)),
      ]),
    );
  }
}
