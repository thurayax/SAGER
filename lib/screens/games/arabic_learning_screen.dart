import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ArabicLearningScreen extends StatefulWidget {
  @override
  _ArabicLearningScreenState createState() => _ArabicLearningScreenState();
}

class _ArabicLearningScreenState extends State<ArabicLearningScreen> {
  final FlutterTts tts = FlutterTts();

  // قائمة جميع الحروف العربية مع الكلمات والصور
  final List<Map<String, String>> lettersWithImages = [
    {'letter': 'أ', 'image': 'assets/images/rabbit.png', 'word': 'أرنب'},
    {'letter': 'ب', 'image': 'assets/images/duck.png', 'word': 'بطة'},
    {'letter': 'ت', 'image': 'assets/images/apple.jpg', 'word': 'تفاحة'},
    {'letter': 'ث', 'image': 'assets/images/fox.png', 'word': 'ثعلب'},
    {'letter': 'ج', 'image': 'assets/images/carrot.png', 'word': 'جزر'},
    {'letter': 'ح', 'image': 'assets/images/cake.png', 'word': 'حلوى'},
    {'letter': 'خ', 'image': 'assets/images/bread.png', 'word': 'خبز'},
    {'letter': 'د', 'image': 'assets/images/house.png', 'word': 'دار'},
    {'letter': 'ذ', 'image': 'assets/images/flower.png', 'word': 'ذرة'},
    {'letter': 'ر', 'image': 'assets/images/feather.png', 'word': 'ريشة'},
    {'letter': 'ز', 'image': 'assets/images/plant.png', 'word': 'زهرة'},
    {'letter': 'س', 'image': 'assets/images/fish.png', 'word': 'سمكة'},
    {'letter': 'ش', 'image': 'assets/images/sun.png', 'word': 'شمس'},
    {'letter': 'ص', 'image': 'assets/images/box.png', 'word': 'صندوق'},
    {'letter': 'ض', 'image': 'assets/images/plate.png', 'word': 'طبق'},
    {'letter': 'ط', 'image': 'assets/images/crown.png', 'word': 'طاووس'},
    {'letter': 'ظ', 'image': 'assets/images/shadow.png', 'word': 'ظل'},
    {'letter': 'ع', 'image': 'assets/images/eye.png', 'word': 'عين'},
    {'letter': 'غ', 'image': 'assets/images/cloud.png', 'word': 'غيمة'},
    {'letter': 'ف', 'image': 'assets/images/elephant.png', 'word': 'فيل'},
    {'letter': 'ق', 'image': 'assets/images/pen.png', 'word': 'قلم'},
    {'letter': 'ك', 'image': 'assets/images/book.png', 'word': 'كتاب'},
    {'letter': 'ل', 'image': 'assets/images/lemon.png', 'word': 'ليمون'},
    {'letter': 'م', 'image': 'assets/images/mountain.png', 'word': 'جبل'},
    {'letter': 'ن', 'image': 'assets/images/star.png', 'word': 'نجمة'},
    {'letter': 'هـ', 'image': 'assets/images/flower2.png', 'word': 'هلال'},
    {'letter': 'و', 'image': 'assets/images/rose.png', 'word': 'وردة'},
    {'letter': 'ي', 'image': 'assets/images/hand.png', 'word': 'يد'},
  ];

  List<String> draggableLetters = [];
  List<Map<String, String>> targetImages = [];
  late DateTime startTime;

  @override
  void initState() {
    super.initState();
    draggableLetters = lettersWithImages.map((e) => e['letter']!).toList();
    targetImages = [...lettersWithImages];
    targetImages.shuffle();
    startTime = DateTime.now(); // وقت بدء اللعبة
  }

  @override
  void dispose() {
    final endTime = DateTime.now();
    final duration = endTime.difference(startTime).inMinutes;

    saveGameProgress('لعبة التوصيل', duration); // تسجيل التقدم عند الخروج
    super.dispose();
  }

  Future<void> saveGameProgress(String gameName, int duration) async {
    try {
      final response = await Supabase.instance.client
          .from('game_progress')
          .insert({
            'game_name': gameName,
            'duration': duration,
            'date_played': DateTime.now().toIso8601String(),
          });

      if (response.isEmpty) {
        print('No data saved. Please check your request.');
      } else {
        print('Game progress saved successfully!');
      }
    } catch (error) {
      print('Error saving game progress: $error');
    }
  }

  Future<void> speak(String text) async {
    await tts.setLanguage("ar");
    await tts.speak(text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('لعبة التوصيل'),
        backgroundColor: Colors.blueAccent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // العودة إلى الصفحة السابقة
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: GridView.builder(
              padding: EdgeInsets.all(16.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: targetImages.length,
              itemBuilder: (context, index) {
                return DragTarget<String>(
                  onAccept: (letter) {
                    if (letter == targetImages[index]['letter']) {
                      setState(() {
                        draggableLetters.remove(letter);
                        targetImages[index]['letter'] = '';
                      });
                      speak(targetImages[index]['word']!);
                    }
                  },
                  builder: (context, candidateData, rejectedData) {
                    return Card(
                      color: targetImages[index]['letter']!.isEmpty
                          ? Colors.greenAccent
                          : Colors.white,
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            targetImages[index]['image']!,
                            height: 80,
                            fit: BoxFit.contain,
                          ),
                          if (targetImages[index]['letter']!.isEmpty)
                            Icon(Icons.check, color: Colors.white, size: 30),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: GridView.builder(
              padding: EdgeInsets.all(16.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 6,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: draggableLetters.length,
              itemBuilder: (context, index) {
                return Draggable<String>(
                  data: draggableLetters[index],
                  child: WordCard(
                    letter: draggableLetters[index],
                  ),
                  feedback: Material(
                    color: Colors.transparent,
                    child: WordCard(
                      letter: draggableLetters[index],
                      isDragging: true,
                    ),
                  ),
                  childWhenDragging: Opacity(
                    opacity: 0.5,
                    child: WordCard(
                      letter: draggableLetters[index],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class WordCard extends StatelessWidget {
  final String letter;
  final bool isDragging;

  const WordCard({required this.letter, this.isDragging = false});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: isDragging ? Colors.blueAccent : Colors.white,
      elevation: isDragging ? 8.0 : 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Center(
        child: Text(
          letter,
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: isDragging ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
