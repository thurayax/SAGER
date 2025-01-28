import 'package:flutter/material.dart';

class GamesHomeScreen extends StatelessWidget {
  final String? username;

  GamesHomeScreen({this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // الخلفية
          Positioned.fill(
            child: Image.asset(
              'assets/images/Blue.png', // مسار الخلفية
              fit: BoxFit.cover,
            ),
          ),
          // زر العودة وزر الإعدادات
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0), // تعديل المسافات حول الأزرار
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // زر العودة
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context); // العودة للصفحة السابقة
                    },
                    icon: const Icon(
                      Icons.arrow_back, // أيقونة الرجوع
                      size: 50, // الحجم
                      color: Color.fromARGB(255, 238, 184, 59), // اللون
                    ),
                  ),
                  // زر الإعدادات
                  IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/settings'); // الانتقال لصفحة الإعدادات
                    },
                    icon: const Icon(
                      Icons.settings, // أيقونة الإعدادات
                      size: 50, // الحجم
                      color: Color.fromARGB(255, 238, 184, 59), // اللون
                    ),
                  ),
                ],
              ),
            ),
          ),
          // النص الترحيبي
          Column(
            children: [
              const SizedBox(height: 100), // مسافة من الأعلى
              Center(
                child: Text(
                  'أهلًا صديقنا ${username ?? "الصغير"}', // النص الترحيبي مع اسم الطفل
                  style: const TextStyle(
                    fontSize: 35, // حجم النص
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 20, 85, 129), // لون النص
                    shadows: [
                      Shadow(
                        offset: Offset(2, 2),
                        blurRadius: 5,
                        color: Colors.black26, // تأثير الظل
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40), // مسافة بين النص والمربعات
              // مربعات الألعاب والقصص
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0), // مسافات جانبية حول المحتوى
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // مربع القصص
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/storieslist');
                        },
                        child: Stack(
                          children: [
                            Card(
                              elevation: 6,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: Container(
                                width: 220, // عرض أكبر قليلاً
                                height: 320, // ارتفاع أكبر قليلاً
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  image: const DecorationImage(
                                    image: AssetImage('assets/images/hstory.png'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // مربع الألعاب
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/gameslist');
                        },
                        child: Stack(
                          children: [
                            Card(
                              elevation: 6,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: Container(
                                width: 220, // عرض أكبر قليلاً
                                height: 320, // ارتفاع أكبر قليلاً
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  image: const DecorationImage(
                                    image: AssetImage('assets/images/hgames.png'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
