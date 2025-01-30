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
    {
      'letter': 'أ',
      'image': 'assets/images/arabic_learning_game/أرنب.jpg',
      'word': 'أرنب'
    },
    {
      'letter': 'ب',
      'image': 'assets/images/arabic_learning_game/بطة.jpg',
      'word': 'بطة'
    },
    {'letter': 'ت', 'image': 'assets/images/apple.jpg', 'word': 'تفاحة'},
    {
      'letter': 'ث',
      'image': 'assets/images/arabic_learning_game/ثعلب.jpg',
      'word': 'ثعلب'
    },
    {
      'letter': 'ث',
      'image': 'assets/images/arabic_learning_game/ثعلب.jpg',
      'word': 'ثعلب'
    },
    {
      'letter': 'ج',
      'image': 'assets/images/arabic_learning_game/جمل.jpg',
      'word': 'جمل'
    },
    {
      'letter': 'ح',
      'image': 'assets/images/arabic_learning_game/حصان.jpg',
      'word': 'حصان'
    },
    {
      'letter': 'خ',
      'image': 'assets/images/arabic_learning_game/خيار.jpg',
      'word': 'خيار'
    },
    {
      'letter': 'د',
      'image': 'assets/images/arabic_learning_game/دجاجة.jpg',
      'word': 'دجاجة'
    },
    {
      'letter': 'ذ',
      'image': 'assets/images/arabic_learning_game/ذئب.jpg',
      'word': 'ذئب'
    },
    {
      'letter': 'ر',
      'image': 'assets/images/arabic_learning_game/رمان.jpg',
      'word': 'رمان'
    },
    {
      'letter': 'ز',
      'image': 'assets/images/arabic_learning_game/زرافة.jpg',
      'word': 'زرافة'
    },
    {
      'letter': 'س',
      'image': 'assets/images/arabic_learning_game/سمكة.jpg',
      'word': 'سمكة'
    },
    {
      'letter': 'ش',
      'image': 'assets/images/arabic_learning_game/شمس.jpg',
      'word': 'شمس'
    },
    {
      'letter': 'ص',
      'image': 'assets/images/arabic_learning_game/صقر.jpg',
      'word': 'صقر'
    },
    {
      'letter': 'ض',
      'image': 'assets/images/arabic_learning_game/ضفدع.jpg',
      'word': 'ضفدع'
    },
    {
      'letter': 'ط',
      'image': 'assets/images/arabic_learning_game/طائرة.jpg',
      'word': 'طائرة'
    },
    {
      'letter': 'ظ',
      'image': 'assets/images/arabic_learning_game/ظرف.jpg',
      'word': 'ظرف'
    },
    {
      'letter': 'ع',
      'image': 'assets/images/arabic_learning_game/عنب.jpg',
      'word': 'عنب'
    },
    {
      'letter': 'غ',
      'image': 'assets/images/arabic_learning_game/غزال.jpg',
      'word': 'غزال'
    },
    {
      'letter': 'ف',
      'image': 'assets/images/arabic_learning_game/فيل.jpg',
      'word': 'فيل'
    },
    {
      'letter': 'ق',
      'image': 'assets/images/arabic_learning_game/قمر.jpg',
      'word': 'قمر'
    },
    {
      'letter': 'ك',
      'image': 'assets/images/arabic_learning_game/كتاب.jpg',
      'word': 'كتاب'
    },
    {
      'letter': 'ل',
      'image': 'assets/images/arabic_learning_game/ليمون.jpg',
      'word': 'ليمون'
    },
    {
      'letter': 'م',
      'image': 'assets/images/arabic_learning_game/موز.jpg',
      'word': 'موز'
    },
    {
      'letter': 'ن',
      'image': 'assets/images/arabic_learning_game/نمر.jpg',
      'word': 'نمر'
    },
    {
      'letter': 'هـ',
      'image': 'assets/images/arabic_learning_game/هرم.jpg',
      'word': 'هرم'
    },
    {
      'letter': 'و',
      'image': 'assets/images/arabic_learning_game/وردة.jpg',
      'word': 'وردة'
    },
    {
      'letter': 'ي',
      'image': 'assets/images/arabic_learning_game/يد.jpg',
      'word': 'يد'
    },
  ];

  List<String> draggableLetters = [];
  List<Map<String, String>> targetImages = [];
  late DateTime startTime;
  int attempts = 0;
  int successes = 0;
  int failures = 0;

  @override
  void initState() {
    super.initState();
    draggableLetters = lettersWithImages.map((e) => e['letter']!).toList();
    targetImages = [...lettersWithImages];
    targetImages.shuffle();
    startTime = DateTime.now();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      showInstructions();
    });
  }

  @override
  void dispose() {
    final endTime = DateTime.now();
    final duration = endTime.difference(startTime).inMinutes;

    saveGameProgress('لعبة الحروف', duration);
    super.dispose();
  }

  Future<void> saveGameProgress(String gameName, int duration) async {
    try {
      final response = await Supabase.instance.client.from('game_progress').insert({
        'game_name': gameName,
        'duration': duration,
        'date_played': DateTime.now().toIso8601String(),
        'attempts': attempts,
        'success': successes,
        'failures': failures,
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

  void showPopup(String message, bool isSuccess) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          title: Text(isSuccess ? 'أحسنت!' : 'حاول مجددًا',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: isSuccess ? Colors.green : Colors.red,
              )),
          content: Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('موافق', style: TextStyle(fontSize: 18)),
            ),
          ],
        );
      },
    );
  }

  void showInstructions() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          title: Text('تعليمات اللعبة',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              )),
          content: Text(
            'مرحباً بك في لعبة الحروف! اسحب الحرف المناسب إلى الصورة الصحيحة لتعلم الحروف بطريقة ممتعة.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('ابدأ', style: TextStyle(fontSize: 18)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const Text(
          'لعبة الحروف العربية',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFB8E1FC), Color(0xFFD7F8FF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
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
                      attempts++;
                      if (letter == targetImages[index]['letter']) {
                        successes++;
                        setState(() {
                          draggableLetters.remove(letter);
                          targetImages[index]['letter'] = '';
                        });
                        speak(targetImages[index]['word']!);
                        showPopup('لقد قمت باختيار الحرف الصحيح!', true);
                      } else {
                        failures++;
                        showPopup('هذا ليس الحرف الصحيح، حاول مرة أخرى.', false);
                      }
                    },
                    builder: (context, candidateData, rejectedData) {
                      return Card(
                        color: targetImages[index]['letter']!.isEmpty
                            ? Colors.greenAccent
                            : Colors.white,
                        elevation: 6,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              targetImages[index]['image']!,
                              height: 100,
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
      elevation: isDragging ? 10.0 : 6.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: isDragging
              ? LinearGradient(
                  colors: [Colors.deepOrange, Colors.orangeAccent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : LinearGradient(
                  colors: [Colors.white, Colors.grey[200]!],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
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
      ),
    );
  }
}
