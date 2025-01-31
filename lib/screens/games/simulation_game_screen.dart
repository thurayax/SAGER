import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SimulationGameScreen extends StatefulWidget {
  @override
  _SimulationGameScreenState createState() => _SimulationGameScreenState();
}

class _SimulationGameScreenState extends State<SimulationGameScreen> {
  int currentIndex = 0;
  late DateTime startTime;

  final List<Map<String, dynamic>> scenarios = [
    {
      'image': 'assets/images/bad_behavior.jpg',
      'correctChoice': false,
    },
    {
      'image': 'assets/images/good_behavior.jpg',
      'correctChoice': true,
    },
  ];

  @override
  void initState() {
    super.initState();
    startTime = DateTime.now();
    Future.delayed(Duration.zero, () => showInstructions());
  }

  void makeDecision(bool choice) {
    bool isSuccess = choice == scenarios[currentIndex]['correctChoice'];
    showPopup(isSuccess ? 'لقد قمت باختيار الإجابة الصحيحة!' : 'هذا ليس الاختيار الصحيح، حاول مرة أخرى.', isSuccess);
    setState(() {
      currentIndex = (currentIndex + 1) % scenarios.length;
    });
  }

  void showPopup(String message, bool isSuccess) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          title: Text(
            isSuccess ? 'أحسنت!' : 'حاول مجددًا',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: isSuccess ? Colors.green : Colors.red,
            ),
          ),
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
          title: Text(
            'تعليمات اللعبة',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'اختر الخيار الصحيح بناءً على الصورة الظاهرة أمامك.',
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

  Future<void> saveGameProgress(String gameName, int duration) async {
    try {
      await Supabase.instance.client.from('game_progress').insert({
        'game_name': gameName,
        'duration': duration,
        'date_played': DateTime.now().toIso8601String(),
      });
      print('Game progress saved successfully!');
    } catch (error) {
      print('Error saving game progress: $error');
    }
  }

  @override
  void dispose() {
    final duration = DateTime.now().difference(startTime).inMinutes;
    saveGameProgress('لعبة المحاكاة', duration);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('لعبة المحاكاة'),
        backgroundColor: Color(0xFFFCEEEF),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'اختر الخيار الصحيح:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFFD9F4FF),
                  borderRadius: BorderRadius.circular(16.0),
                ),
                padding: EdgeInsets.all(16.0),
                child: Image.asset(
                  scenarios[currentIndex]['image'],
                  height: 250,
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: Icon(Icons.check_circle, color: Color(0xFF709E8F), size: 50),
                    onPressed: () => makeDecision(true),
                  ),
                  IconButton(
                    icon: Icon(Icons.cancel, color: Colors.red.shade400, size: 50),
                    onPressed: () => makeDecision(false),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
