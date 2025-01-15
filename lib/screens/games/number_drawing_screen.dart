import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class NumbersLearningGame extends StatefulWidget {
  @override
  _NumbersLearningGameState createState() => _NumbersLearningGameState();
}

class _NumbersLearningGameState extends State<NumbersLearningGame> {
  final FlutterTts tts = FlutterTts();
  String currentNumber = '3'; // الرقم الحالي
  bool isDrawingComplete = false;

  Future<void> speak(String text) async {
    await tts.setLanguage("ar");
    await tts.speak(text);
  }

  void resetDrawing() {
    setState(() {
      isDrawingComplete = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('لعبة تعلم الأرقام'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            'ارسم الرقم $currentNumber',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          GestureDetector(
            onPanUpdate: (details) {
              // يمكنك استخدام مكتبة لرسم الخطوط هنا
              setState(() {
                isDrawingComplete = true; // محاكاة اكتمال الرسم
              });
            },
            child: Container(
              height: 400,
              width: 300,
              color: Colors.grey[200],
              child: Center(
                child: isDrawingComplete
                    ? Icon(Icons.check, size: 100, color: Colors.green)
                    : Text(
                        'ارسم هنا',
                        style: TextStyle(fontSize: 24, color: Colors.grey),
                      ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () => speak('ارسم الرقم $currentNumber'),
            child: Text('الإرشادات الصوتية'),
          ),
          ElevatedButton(
            onPressed: resetDrawing,
            child: Text('إعادة المحاولة'),
          ),
        ],
      ),
    );
  }
}
