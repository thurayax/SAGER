import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void login(BuildContext context) async {
    try {
      final response = await Supabase.instance.client.auth.signInWithPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      if (response.session != null) {
        // تسجيل الدخول ناجح
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        // تسجيل الدخول فشل بدون سبب واضح
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login failed')),
        );
      }
    } on AuthException catch (e) {
      if (e.message.contains('Email not confirmed')) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Email not confirmed. Please verify your email.')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.message}')),
        );
      }
    } catch (e) {
      // أخطاء عامة
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An unexpected error occurred')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // الخلفية
          Positioned.fill(
            child: Image.asset(
              'assets/images/Blue.png', // قم بتغيير مسار الخلفية
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: SingleChildScrollView(
              child: Container(
                width: 350, // عرض المربع
                padding: const EdgeInsets.all(32), // الحشوة الداخلية
                decoration: BoxDecoration(
                  color: const Color(0xFF8FB49A), // اللون الأخضر
                  borderRadius: BorderRadius.circular(20), // الحواف الدائرية
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, 4), // تأثير الظل
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // العنوان
                    Text(
                      'تسجيل الدخول',
                      style: TextStyle(
                        fontSize: 26, // حجم النص
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // اللون الأبيض
                      ),
                    ),
                    const SizedBox(height: 30),
                    // حقل البريد الإلكتروني
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        hintText: 'البريد الإلكتروني',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // حقل كلمة المرور
                    TextField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        hintText: 'كلمة المرور',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        suffixIcon: Icon(Icons.visibility_off),
                      ),
                      obscureText: true,
                    ),
                    const SizedBox(height: 30),
                    // زر تسجيل الدخول
                  ElevatedButton(
  onPressed: () => login(context),
  style: ElevatedButton.styleFrom(
    backgroundColor: const Color(0xFF56796D), // لون الزر (أخضر غامق)
    padding: const EdgeInsets.symmetric(
        vertical: 16, horizontal: 60), // تكبير حجم الزر
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
  ),
  child: const Text(
    'تسجيل الدخول',
    style: TextStyle(
      fontSize: 20,
      color: Colors.white, // اللون الأبيض للنص
    ),
  ),
),
                    const SizedBox(height: 20),
                    // رابط التسجيل
                    TextButton(
                      onPressed: () => Navigator.pushNamed(context, '/register'),
                      child: const Text(
                        'إنشاء حساب جديد',
                        style: TextStyle(
                          color: Colors.white,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
