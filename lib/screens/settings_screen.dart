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

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  // تحميل بيانات المستخدم
  Future<void> _loadUserData() async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user != null) {
      setState(() {
        _nameController.text = user.userMetadata?['full_name'] ?? '';
        _emailController.text = user.email ?? '';
      });
    }
  }

  // تحديث بيانات المستخدم
Future<void> _updateUserData() async {
  if (_formKey.currentState?.validate() ?? false) {
    try {
      final response = await Supabase.instance.client.auth.updateUser(
        UserAttributes(
          data: {'full_name': _nameController.text},
        ),
      );

      // التحقق من نجاح التحديث
      if (response.user != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('تم تحديث البيانات بنجاح')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('حدث خطأ أثناء تحديث البيانات')),
        );
      }
    } catch (error) {
      print('Error updating user data: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('حدث خطأ أثناء تحديث البيانات')),
      );
    }
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('الإعدادات'),
        backgroundColor: Colors.orange,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // تحديث بيانات المستخدم
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'تحديث البيانات الشخصية',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          labelText: 'الاسم الكامل',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'يرجى إدخال الاسم الكامل';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: 'البريد الإلكتروني',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        readOnly: true, // البريد الإلكتروني غير قابل للتعديل
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _updateUserData,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        ),
                        child: Text(
                          'تحديث البيانات',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),

            // باقي الخيارات
            ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: [
              
                Divider(),
                ListTile(
                  leading: Icon(Icons.info),
                  title: Text('عن التطبيق'),
                  onTap: () {
                    // وظيفة عرض معلومات عن التطبيق
                  },
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.logout),
                  title: Text('تسجيل الخروج'),
                  onTap: () {
                    Supabase.instance.client.auth.signOut();
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
