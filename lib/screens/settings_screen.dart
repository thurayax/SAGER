import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user != null) {
      setState(() {
        _nameController.text = user.userMetadata?['full_name'] ?? '';
        _emailController.text = user.email ?? '';
      });
    }
  }

  Future<void> _updateDataAndPassword() async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        // Update user data first
        final response = await Supabase.instance.client.auth.updateUser(
          UserAttributes(
            data: {'full_name': _nameController.text},
            password: _newPasswordController.text.isNotEmpty
                ? _newPasswordController.text
                : null,
          ),
        );

        if (response.user != null) {
          // Show appropriate snack bar message
          if (_newPasswordController.text.isNotEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('تم تحديث البيانات بنجاح')),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('تم تحديث البيانات بنجاح')),
            );
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text('حدث خطأ أثناء تحديث البيانات أو كلمة المرور')),
          );
        }
      } catch (error) {
        print('Error updating user data or password: $error');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('حدث خطأ أثناء تحديث البيانات أو كلمة المرور')),
        );
      }
    }
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
        child: Stack(
          children: [
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    size: 60,
                    color: Color(0xFF527566),
                  ),
                ),
              ),
            ),
            Center(
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
                        'البيانات الشخصية',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Name Field
                      TextFormField(
                        controller: _nameController,
                        textAlign: TextAlign.right,
                        decoration: InputDecoration(
                          hintText: 'الاسم',
                          hintStyle: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                          ),
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
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'يرجى إدخال الاسم الكامل';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),

                      // Email Field (Read-Only)
                      TextFormField(
                        controller: _emailController,
                        textAlign: TextAlign.right,
                        decoration: InputDecoration(
                          hintText: 'البريد الإلكتروني',
                          hintStyle: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                          ),
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
                        readOnly: true,
                      ),
                      const SizedBox(height: 15),

                      // Password Field (New Password)
                      TextFormField(
                        controller: _newPasswordController,
                        obscureText: !_isPasswordVisible,
                        textAlign: TextAlign.right,
                        decoration: InputDecoration(
                          hintText: 'تغيير كلمة المرور',
                          hintStyle: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                          ),
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
                        ),
                        validator: _validatePassword,
                      ),
                      const SizedBox(height: 20),

                      // Save Data Button
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF527566),
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: _updateDataAndPassword,
                        child: const Text(
                          'حفظ',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                      const SizedBox(height: 15),

                      // Additional Options Section
                      Divider(color: Colors.white),
                      ListTile(
                        title: const Text(
                          'عن ساجر',
                          textAlign: TextAlign.right,
                        ),
                        trailing:
                            Icon(Icons.info, color: const Color(0xFF527566)),
                        onTap: () {
                          showAboutDialog(
                            context: context,
                            applicationName: 'ساجر',
                            applicationVersion: '1.0.0',
                            applicationLegalese: 'حقوق النشر © 2025',
                          );
                        },
                      ),
                      Divider(color: Colors.white),
                      ListTile(
                        title: const Text(
                          ':تواصل معنا \n SagerApp2025@gmail.com',
                          textAlign: TextAlign.right,
                        ),
                        trailing:
                            Icon(Icons.email, color: const Color(0xFF527566)),
                        onTap: () {
                          // Handle email tap
                        },
                      ),
                      Divider(color: Colors.white),
                      ListTile(
                        title: const Text(
                          'تسجيل الخروج',
                          textAlign: TextAlign.right,
                        ),
                        trailing:
                            Icon(Icons.logout, color: const Color(0xFF527566)),
                        onTap: () {
                          Supabase.instance.client.auth.signOut();
                          Navigator.pushReplacementNamed(context, '/login');
                        },
                      ),
                      const SizedBox(height: 15),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
