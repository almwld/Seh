import 'package:flutter/material.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import '../../../core/services/agora_service.dart';

class ChatScreen extends StatefulWidget {
  final String doctorName;
  final String channelName;
  
  const ChatScreen({super.key, this.doctorName = 'الطبيب', this.channelName = 'sehatak_channel'});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final AgoraService _agora = AgoraService();
  final TextEditingController _msgCtrl = TextEditingController();
  final List<String> _messages = [];
  bool _isInCall = false;
  bool _isMuted = false;
  bool _isVideo = false;
  bool _isSpeakerOn = true;
  int? _remoteUid;

  @override
  void initState() {
    super.initState();
    _initAgora();
  }

  Future<void> _initAgora() async {
    await _agora.initialize();
    
    _agora.engine?.registerEventHandler(RtcEngineEventHandler(
      onJoinChannelSuccess: (connection, elapsed) {
        print('تم الانضمام للقناة: ${connection.channelId}');
      },
      onUserJoined: (connection, uid, elapsed) {
        setState(() => _remoteUid = uid);
      },
      onUserOffline: (connection, uid, reason) {
        setState(() => _remoteUid = null);
      },
    ));
  }

  Future<void> _startCall({bool video = false}) async {
    setState(() { _isInCall = true; _isVideo = video; });
    await _agora.joinChannel(widget.channelName);
  }

  Future<void> _endCall() async {
    await _agora.leaveChannel();
    setState(() { _isInCall = false; _remoteUid = null; });
  }

  Future<void> _toggleMute() async {
    setState(() => _isMuted = !_isMuted);
    await _agora.engine?.muteLocalAudioStream(_isMuted);
  }

  Future<void> _toggleSpeaker() async {
    setState(() => _isSpeakerOn = !_isSpeakerOn);
    await _agora.engine?.setEnableSpeakerphone(_isSpeakerOn);
  }

  void _sendMessage() {
    if (_msgCtrl.text.isEmpty) return;
    setState(() => _messages.add(_msgCtrl.text));
    _msgCtrl.clear();
  }

  @override
  void dispose() {
    _agora.dispose();
    _msgCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.doctorName),
        actions: [
          IconButton(icon: const Icon(Icons.call), onPressed: () => _startCall()),
          IconButton(icon: const Icon(Icons.videocam), onPressed: () => _startCall(video: true)),
        ],
      ),
      body: _isInCall ? _buildCallScreen() : _buildChatOnly(),
    );
  }

  Widget _buildCallScreen() {
    return Column(
      children: [
        // منطقة الفيديو
        Expanded(
          flex: 3,
          child: _isVideo ? _buildVideoArea() : _buildAudioOnly(),
        ),
        
        // أزرار التحكم
        _buildCallControls(),
        
        // الدردشة النصية
        Expanded(
          flex: 2,
          child: Column(
            children: [
              Expanded(child: _buildMessagesList()),
              _buildMessageInput(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildVideoArea() {
    return Stack(
      children: [
        // فيديو الطرف الآخر (ملء الشاشة)
        if (_remoteUid != null)
          Positioned.fill(
            child: AgoraVideoView(
              controller: VideoViewController.remote(
                rtcEngine: _agora.engine!,
                canvas: VideoCanvas(uid: _remoteUid!),
                connection: RtcConnection(channelId: widget.channelName),
              ),
            ),
          )
        else
          const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.videocam_off, size: 60, color: Colors.grey),
                SizedBox(height: 10),
                Text('في انتظار اتصال الطرف الآخر...', style: TextStyle(color: Colors.grey, fontSize: 16)),
              ],
            ),
          ),
        
        // فيديو محلي (صغير في الزاوية)
        Positioned(
          top: 10,
          right: 10,
          child: Container(
            width: 120,
            height: 160,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: AgoraVideoView(
                controller: VideoViewController(
                  rtcEngine: _agora.engine!,
                  canvas: const VideoCanvas(uid: 0),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAudioOnly() {
    return Container(
      color: const Color(0xFF1A2540),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.teal,
                shape: BoxShape.circle,
                boxShadow: [BoxShadow(color: Colors.teal.withOpacity(0.5), blurRadius: 20)],
              ),
              child: const Icon(Icons.person, size: 50, color: Colors.white),
            ),
            const SizedBox(height: 20),
            const Text('مكالمة صوتية', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(widget.doctorName, style: const TextStyle(color: Colors.white70, fontSize: 14)),
            const SizedBox(height: 20),
            Text(_formatDuration(), style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildCallControls() {
    return Container(
      color: const Color(0xFF0B1121),
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _callButton(Icons.mic, _isMuted ? Colors.red : Colors.white, _isMuted ? 'كتم' : 'مايك', _toggleMute),
          _callButton(Icons.volume_up, _isSpeakerOn ? Colors.white : Colors.grey, 'سماعة', _toggleSpeaker),
          _callButton(Icons.call_end, Colors.red, 'إنهاء', _endCall, size: 50),
          _callButton(Icons.videocam, _isVideo ? Colors.white : Colors.grey, 'فيديو', () {
            setState(() => _isVideo = !_isVideo);
          }),
          _callButton(Icons.chat, Colors.white, 'دردشة', () {}),
        ],
      ),
    );
  }

  Widget _callButton(IconData icon, Color color, String label, VoidCallback onTap, {double size = 40}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: size + 10,
            height: size + 10,
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: size > 45 ? 28 : 22),
          ),
        ),
        const SizedBox(height: 4),
        Text(label, style: TextStyle(color: Colors.white70, fontSize: 10)),
      ],
    );
  }

  Widget _buildChatOnly() {
    return Column(
      children: [
        Expanded(child: _buildMessagesList()),
        _buildMessageInput(),
      ],
    );
  }

  Widget _buildMessagesList() {
    if (_messages.isEmpty) {
      return const Center(child: Text('ابدأ المحادثة مع الطبيب', style: TextStyle(color: Colors.grey)));
    }
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _messages.length,
      itemBuilder: (_, i) => Align(
        alignment: i % 2 == 0 ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: i % 2 == 0 ? Colors.teal[100] : Colors.grey[200],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(_messages[i]),
        ),
      ),
    );
  }

  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(children: [
        Expanded(
          child: TextField(
            controller: _msgCtrl,
            textAlign: TextAlign.right,
            decoration: InputDecoration(
              hintText: 'اكتب رسالة...',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(24)),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            ),
          ),
        ),
        const SizedBox(width: 8),
        CircleAvatar(backgroundColor: Colors.teal, child: IconButton(icon: const Icon(Icons.send, color: Colors.white), onPressed: _sendMessage)),
      ]),
    );
  }

  String _formatDuration() {
    return '00:00';
  }

  DateTime? _callStartTime;
}

extension on AgoraService {
  // No changes needed
}
