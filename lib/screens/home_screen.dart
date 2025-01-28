import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeScreen extends StatelessWidget {
  void logout(BuildContext context) async {
    await Supabase.instance.client.auth.signOut();
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    final user = Supabase.instance.client.auth.currentUser;

    return Scaffold(
      body: Stack(
        children: [
          // الخلفية
          Positioned.fill(
            child: Image.asset(
              'assets/images/Blue and Green.png', // قم بتغيير المسار إلى مسار صورتك
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // صورة الشعار
                Image.asset(
                  'assets/images/Ellipse 25.png', // قم بتغيير المسار إلى مسار شعارك
                  width: 300, // عرض الشعار
                  height: 300, // ارتفاع الشعار
                ),
                const SizedBox(height:2), // مسافة بين الشعار ونص الترحيب
                // نص الترحيب
                Text(
                  'مرحبًا, ${user?.email ?? "ضيف"}!',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 20), // مسافة بين نص الترحيب وزر التشغيل
                // زر التشغيل
                ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, '/games'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding: const EdgeInsets.all(24), // لجعل الزر دائريًا
                    shape: const CircleBorder(), // لجعل الزر دائريًا
                  ),
                  child: const Icon(
                    Icons.play_arrow, // أيقونة التشغيل
                    size: 50, // حجم الأيقونة
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}