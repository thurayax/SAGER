import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RegistrationScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void register(BuildContext context) async {
    try {
      // تسجيل المستخدم مع تمرير الاسم كـ metadata
      final response = await Supabase.instance.client.auth.signUp(
        email: emailController.text,
        password: passwordController.text,
        data: {'name': nameController.text}, // إضافة الاسم
      );

      // التحقق من نجاح عملية التسجيل
      if (response.user != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('تم إنشاء الحساب بنجاح!')),
        );
        Navigator.pop(context); // العودة إلى الشاشة السابقة
      } else if (response.session == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('فشل إنشاء الحساب. يرجى المحاولة مرة أخرى.')),
        );
      }
    } on AuthException catch (e) {
      // معالجة الأخطاء الخاصة بالمصادقة
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('خطأ في المصادقة: ${e.message}')),
      );
    } catch (e) {
      // معالجة الأخطاء العامة
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('حدث خطأ غير متوقع: $e')),
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
              'assets/images/Blue and Green.png', // المسار الخاص بالخلفية
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: SingleChildScrollView(
              child: Container(
                width: 350, // عرض المربع
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: const Color(0xFF8FB49A),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'إنشاء حساب',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    // حقل الاسم
                    TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        hintText: 'الاسم',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
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
                    const SizedBox(height: 16),
                    // حقل كلمة المرور
                    TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'كلمة المرور',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        suffixIcon: Icon(Icons.visibility_off),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // زر التسجيل
                    ElevatedButton(
                      onPressed: () => register(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF56796D),
                        padding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 60),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'إنشاء حساب',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // رابط تسجيل الدخول
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text(
                        'لديك حساب بالفعل؟ سجل الدخول',
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
