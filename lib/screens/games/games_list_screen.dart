import 'package:flutter/material.dart';

class GamesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('قائمة الألعاب'),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade100, Colors.green.shade100],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // عدد العناصر في الصف الواحد
              crossAxisSpacing: 16, // المسافة الأفقية بين العناصر
              mainAxisSpacing: 16, // المسافة العمودية بين العناصر
            ),
            itemCount: 4, // عدد الألعاب
            itemBuilder: (context, index) {
              // تحديد محتوى البطاقة بناءً على الفهرس
              switch (index) {
                case 0:
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/picture_sentence');
                    },
                    child: const GameCard(
                      title: 'تكوين الجمل',
                      icon: Icons.text_fields,
                      color: Colors.orange,
                    ),
                  );
                case 1:
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/simulation_game');
                    },
                    child: const GameCard(
                      title: 'لعبة المحاكاة',
                      icon: Icons.computer,
                      color: Colors.blue,
                    ),
                  );
                case 2:
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/arabic_learning');
                    },
                    child: const GameCard(
                      title: 'تعلم العربية',
                      icon: Icons.language,
                      color: Colors.green,
                    ),
                  );
                case 3:
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/number_drawing');
                    },
                    child: const GameCard(
                      title: 'لعبة تعلم الأرقام',
                      icon: Icons.calculate,
                      color: Colors.purple,
                    ),
                  );
                default:
                  return const SizedBox.shrink(); // عنصر فارغ
              }
            },
          ),
        ),
      ),
    );
  }
}

class GameCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;

  const GameCard({
    required this.title,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: color.withOpacity(0.2),
            child: Icon(
              icon,
              size: 40,
              color: color,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
