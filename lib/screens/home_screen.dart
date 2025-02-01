import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:autism_app/screens/parent_login_screen.dart';
import 'package:just_audio/just_audio.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String userName = "بكم"; // الاسم الافتراضي
  final AudioPlayer _audioPlayer = AudioPlayer(); // مشغل الصوت الجديد

  @override
  void initState() {
    super.initState();
    _loadUserData();
    _playWelcomeSound(); // تشغيل الصوت عند فتح الصفحة
  }

  Future<void> _loadUserData() async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user != null) {
      final metadata = user.userMetadata;
      setState(() {
        userName = metadata?['full_name'] ?? "بكم";
      });
    }
  }

  Future<void> _playWelcomeSound() async {
    try {
      await _audioPlayer.setAsset('assets/audio/welcome.mp3'); // تحميل الملف
      await _audioPlayer.play(); // تشغيل الصوت
    } catch (e) {
      print("❌ خطأ في تشغيل الصوت: $e");
    }
  }

  void logout(BuildContext context) async {
    await Supabase.instance.client.auth.signOut();
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  void dispose() {
    _audioPlayer.dispose(); // إيقاف المشغل عند الخروج
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/Blue and Green.png',
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/logoSager.png',
                  width: 300,
                  height: 300,
                ),
                const SizedBox(height: 2),
                Text(
                  'أهلاً $userName في تطبيق ساجر',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, '/games'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding: const EdgeInsets.all(24),
                    shape: const CircleBorder(),
                  ),
                  child: const Icon(
                    Icons.play_arrow,
                    size: 50,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 40,
            right: 20,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ParentLoginScreen(),
                  ),
                );
              },
              child: CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage('assets/images/avatar.jpg'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
