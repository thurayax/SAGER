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
              'assets/images/Blue and Green.png',
              fit: BoxFit.cover,
            ),
          ),
          // زر العودة
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      size: 40,
                      color: Color.fromARGB(255, 238, 184, 59),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // المحتوى
          Column(
            children: [
              const SizedBox(height: 100),
              const Center(
                child: Text(
                  'قائمة الألعاب',
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 20, 85, 129),
                    shadows: [
                      Shadow(
                        offset: Offset(2, 2),
                        blurRadius: 5,
                        color: Colors.black26,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Expanded(
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GameCard(
                        title: 'تكوين الجمل',
                        imagePath: 'assets/images/learning.png',
                        backgroundColor: const Color(0xFFB2D8B1),
                        isLocked: false,
                        routeName: '/picture_sentence',
                      ),
                      GameCard(
                        title: 'لعبة المحاكاة',
                        imagePath: 'assets/images/m.png',
                        backgroundColor: const Color(0xFFFEE8A5),
                        isLocked: false,
                        routeName: '/simulation_game',
                      ),
                      GameCard(
                        title: 'تعلم العربية',
                        imagePath: 'assets/images/A.png',
                        backgroundColor: const Color(0xFFF7C5D8),
                        isLocked: false,
                        routeName: '/arabic_learning',
                      ),
                      GameCard(
                        title: 'لعبة تعلم الأرقام',
                        imagePath: 'assets/images/num.png',
                        backgroundColor: const Color(0xFFD6E0F0),
                        isLocked: true,
                        routeName: '/number_drawing',
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
  final bool isLocked;
  final String routeName;

  const GameCard({
    required this.title,
    required this.imagePath,
    required this.backgroundColor,
    required this.isLocked,
    required this.routeName,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!isLocked) {
          Navigator.pushNamed(context, routeName);
        }
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 150,
            height: 200,
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
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(imagePath),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          if (isLocked)
            Positioned(
              top: 10,
              right: 10,
              child: Icon(
                Icons.lock,
                size: 40,
                color: Colors.red.shade700,
              ),
            ),
        ],
      ),
    );
  }
}
