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
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const Text(
          'لعبة تعلم الأرقام',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height, // Full height of the screen
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFB8E1FC), Color(0xFFD7F8FF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 20),
            Text(
              'ارسم الرقم $currentNumber',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: GestureDetector(
                onPanUpdate: (details) {
                  setState(() {
                    isDrawingComplete = true; // محاكاة اكتمال الرسم
                  });
                },
                child: Container(
                  width:
                      MediaQuery.of(context).size.width * 0.8, // Adjust width
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
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => speak('ارسم الرقم $currentNumber'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF709E8F),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Icon(
                Icons.volume_up,
                size: 30,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: resetDrawing,
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    Color.fromRGBO(234, 121, 22, 1), 

                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Icon(
                Icons.refresh,
                size: 30,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
