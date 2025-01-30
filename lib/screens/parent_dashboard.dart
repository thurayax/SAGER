import 'package:flutter/material.dart';
import 'parent_chatbot_screen.dart';
import 'progress_screen.dart';
import 'settings_screen.dart';

class ParentDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'لوحة التحكم',
          style: TextStyle(fontSize: 24),
        ),
        backgroundColor: Color(0xFF709E8F),
        centerTitle: true,
      ),
      body: Container(
        color: Color(0xFFB8E1FC), // استخدام اللون الثابت مثل الكود المرفق
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildDashboardItem(
                  context,
                  imagePath: "assets/images/اعدادات.png",
                  label: 'الإعدادات',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SettingsScreen(),
                      ),
                    );
                  },
                ),
                _buildDashboardItem(
                  context,
                  imagePath: "assets/images/تتبع.png",
                  label: 'تتبع التقدم',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProgressScreen(),
                      ),
                    );
                  },
                ),
                _buildDashboardItem(
                  context,
                  imagePath: "assets/images/شات.png",
                  label: 'مساعد ساجر',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ParentChatbotScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboardItem(
    BuildContext context, {
    IconData? icon,
    String? imagePath,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: Color(0xFFB8E1FC), // استخدام نفس لون الخلفية
            child: imagePath != null
                ? Image.asset(imagePath, fit: BoxFit.cover)
                : Icon(icon, size: 40, color: Colors.teal.shade700),
          ),
          SizedBox(height: 10),
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black, // استخدام لون النص الأسود
            ),
          ),
        ],
      ),
    );
  }
}
