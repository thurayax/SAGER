import 'package:flutter/material.dart';

class GamesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // الخلفية
          Positioned.fill(
            child: Image.asset(
              'assets/images/Blue and Green.png', // صورة الخلفية
              fit: BoxFit.cover,
            ),
          ),
          // زر العودة
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context); // العودة للصفحة السابقة
                },
                icon: const Icon(
                  Icons.arrow_back,
                  size: 40, // حجم أكبر للأيقونة
                  color: Color.fromARGB(255, 238, 184, 59),
                ),
              ),
            ),
          ),
          // المحتوى
          Column(
            children: [
              const SizedBox(height: 100), // مسافة من الأعلى
              Center(
                child: const Text(
                  ' قائمة الالعاب  ',
                  style: TextStyle(
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
              // الألعاب في صف واحد
              Expanded(
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // مربع 1
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/picture_sentence');
                        },
                        child: GameCard(
                          title: 'تكوين الجمل',
                          imagePath: 'assets/images/learning.png',
                          backgroundColor: const Color(0xFFB2D8B1), // اللون الأخضر
                        ),
                      ),
                      // مربع 2
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/simulation_game');
                        },
                        child: GameCard(
                          title: 'لعبة المحاكاة',
                          imagePath: 'assets/images/m.png',
                          backgroundColor: const Color(0xFFFEE8A5), // اللون الأصفر
                        ),
                      ),
                      // مربع 3
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/arabic_learning');
                        },
                        child: GameCard(
                          title: 'تعلم العربية',
                          imagePath: 'assets/images/A.png',
                          backgroundColor: const Color(0xFFF7C5D8), // اللون الوردي
                        ),
                      ),
                      // مربع 4
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/number_drawing');
                        },
                        child: GameCard(
                          title: 'لعبة تعلم الأرقام',
                          imagePath: 'assets/images/num.png',
                          backgroundColor: const Color(0xFFD6E0F0), // اللون الأزرق الفاتح
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

class GameCard extends StatelessWidget {
  final String title;
  final String imagePath;
  final Color backgroundColor;

  const GameCard({
    required this.title,
    required this.imagePath,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150, // العرض
      height: 200, // الارتفاع
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // أيقونة اللعبة
          Container(
            width: 80, // عرض الأيقونة المصغرة
            height: 80, // ارتفاع الأيقونة المصغرة
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.contain,
              ),
            ),
          ),
          const SizedBox(height: 10), // مسافة بين الأيقونة والنص
          // نص اللعبة
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black, // لون النص: أسود
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
