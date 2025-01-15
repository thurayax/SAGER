import 'package:flutter/material.dart';

class GamesHomeScreen extends StatelessWidget {
  final String? username; // جعل المتغير اختياريًا

  GamesHomeScreen({this.username}); // إزالة required

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // الخلفية
          Positioned.fill(
            child: Image.asset(
              'assets/images/Blue.png', // قم بتغيير المسار إلى مسار خلفيتك
              fit: BoxFit.cover,
            ),
          ),
          // المحتوى
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // زر العودة
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, top: 16.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context); // العودة للصفحة السابقة
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            blurRadius: 6,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(8),
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.blue,
                        size: 28,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // النص الترحيبي
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    'أهلاً صديقنا $username',
                    style: const TextStyle(
                      fontSize: 28, // تكبير النص الترحيبي
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 40),
                // مربعات الألعاب والقصص
                Center(
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
                                width: 220, // العرض
                                height: 300, // الارتفاع
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  image: const DecorationImage(
                                    image: AssetImage('assets/images/story BG.png'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 20,
                              left: 0,
                              right: 0,
                              child: Center(
                                child: Text(
                                  'قائمة القصص',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    shadows: [
                                      Shadow(
                                        offset: Offset(1, 1),
                                        blurRadius: 5,
                                        color: Colors.black,
                                      ),
                                    ],
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
                                width: 220, // العرض
                                height: 300, // الارتفاع
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  image: const DecorationImage(
                                    image: AssetImage('assets/images/game BG.png'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 20,
                              left: 0,
                              right: 0,
                              child: Center(
                                child: Text(
                                  'قائمة الألعاب',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    shadows: [
                                      Shadow(
                                        offset: Offset(1, 1),
                                        blurRadius: 5,
                                        color: Colors.black,
                                      ),
                                    ],
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
