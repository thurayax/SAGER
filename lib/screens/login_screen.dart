import 'package:autism_app/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:autism_app/screens/home_screen.dart';
import 'package:autism_app/screens/reset_password.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  Future<void> login(BuildContext context) async {
    try {
      final AuthResponse response =
          await Supabase.instance.client.auth.signInWithPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      if (response.session != null) {
        // Login successful, navigate to HomeScreen
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        // Login failed without clear reason
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login failed')),
        );
      }
    } on AuthException catch (e) {
      if (e.message.contains('Email not confirmed')) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Email not confirmed. Please verify your email.')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('خطأ في تسجيل الدخول')),
        );
      }
    } catch (e) {
      // Handle other unexpected errors
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An unexpected error occurred')),
      );
    }
  }

  // Email validation function
  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'يرجى إدخال البريد الإلكتروني';
    }

    final emailRegex = RegExp(
      r'^[a-zA-Z0-9]+([._-]?[a-zA-Z0-9]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z]{2,})+$',
    );

    if (!emailRegex.hasMatch(value)) {
      return 'يرجى إدخال بريد إلكتروني صحيح';
    }
    return null;
  }

  // Password validation function
  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'يرجى إدخال كلمة المرور';
    }

    final passwordRegex = RegExp(
      r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[!@#\$&*~]).{8,16}$',
    );

    if (!passwordRegex.hasMatch(value)) {
      return 'الحد الأدنى لكلمة المرور (8-16 حرف بالإنجليزية) \n :يجب أن تتضمن \n أحرف كبيرة وصغيرة \n أرقام \n رموز (مثل: ! , # , @)';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFE7F3FA),
              Color(0xFFB1D8E8),
            ],
          ),
        ),
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(20.0),
            width: 350,
            decoration: BoxDecoration(
              color: const Color(0xFF719E8F),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'تسجيل الدخول',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Email Field
                  TextFormField(
                    controller: _emailController,
                    textAlign: TextAlign.right,
                    decoration: InputDecoration(
                      hintText: 'البريد الإلكتروني',
                      hintStyle: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.normal),
                      filled: true,
                      fillColor: const Color(0xFF709E8F),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(color: Colors.white, width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(color: Colors.white, width: 1),
                      ),
                    ),
                    validator: _validateEmail,
                  ),
                  const SizedBox(height: 15),

                  // Password Field
                  TextFormField(
                    controller: _passwordController,
                    textAlign: TextAlign.right,
                    obscureText: !_isPasswordVisible,
                    decoration: InputDecoration(
                      hintText: 'كلمة المرور',
                      hintStyle: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.normal),
                      filled: true,
                      fillColor: const Color(0xFF709E8F),
                      prefixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(color: Colors.white, width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(color: Colors.white, width: 1),
                      ),
                    ),
                    validator: _validatePassword,
                  ),
                  const SizedBox(height: 20),

                  // Login Button
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF527566),
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        login(context); // Use the login method here
                      }
                    },
                    child: const Text(
                      'تسجيل الدخول',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                  const SizedBox(height: 15),

                  // Forgot Password
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ResetPasswordScreen(),
                            ),
                          );
                        },
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          onHover: (_) {
                            setState(() {});
                          },
                          child: Text(
                            'نسيت كلمة المرور ؟',
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Signup Prompt
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const RegistrationScreen()),
                          );
                        },
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          onHover: (_) {
                            setState(() {});
                          },
                          child: Text(
                            'إنشاء حساب',
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
