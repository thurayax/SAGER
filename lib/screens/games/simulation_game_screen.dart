import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SimulationGameScreen extends StatefulWidget {
  @override
  _SimulationGameScreenState createState() => _SimulationGameScreenState();
}

class _SimulationGameScreenState extends State<SimulationGameScreen> {
  int score = 0;
  late DateTime startTime; // لتسجيل وقت بدء اللعبة

  @override
  void initState() {
    super.initState();
    startTime = DateTime.now(); // حفظ وقت بدء اللعبة
  }

  // دالة اتخاذ القرار
  void makeDecision(String choice) {
    setState(() {
      if (choice == 'correct') {
        score += 10;
      } else {
        score -= 5;
      }
    });
  }

  // دالة حفظ بيانات اللعبة عند الخروج
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

  @override
  void dispose() {
    // حساب مدة اللعب عند الخروج
    final endTime = DateTime.now();
    final duration = endTime.difference(startTime).inMinutes;

    // حفظ التقدم
    saveGameProgress('لعبة المحاكاة', duration);

    super.dispose(); // استدعاء الدالة الأصلية
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('لعبة المحاكاة'),
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // العودة إلى الصفحة السابقة
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'اختر الخيار الأفضل:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => makeDecision('correct'),
              child: Text('الخيار 1 (صحيح)'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => makeDecision('wrong'),
              child: Text('الخيار 2 (خطأ)'),
            ),
            SizedBox(height: 30),
            Text(
              'النتيجة: $score',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
