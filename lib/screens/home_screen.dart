import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:autism_app/screens/parent_login_screen.dart'; // استيراد صفحة تسجيل دخول الآباء

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
              'assets/images/Blue and Green.png', // الخلفية
              fit: BoxFit.cover,
            ),
          ),

          // المحتوى الرئيسي
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // صورة الشعار
                Image.asset(
                  'assets/images/logoSager.png', // الشعار
                  width: 300,
                  height: 300,
                ),
                const SizedBox(height: 2),

                // نص الترحيب
                Text(
                  'اهلا بكم في تطبيق ساجر ${user?.email ?? ""}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 20),

                // زر التشغيل
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

          // أيقونة على شكل شخصية للانتقال إلى صفحة الآباء
          Positioned(
            top: 40,
            right: 20, // تغيير الخاصية من left إلى right
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ParentLoginScreen(), // الربط بالصفحة
                  ),
                );
              },
              child: CircleAvatar(
                radius: 30, // حجم الأيقونة
                backgroundImage:
                    AssetImage('assets/images/avatar.jpg'), // صورة الشخصية
              ),
            ),
          ),
        ],
      ),
    );
  }
}
