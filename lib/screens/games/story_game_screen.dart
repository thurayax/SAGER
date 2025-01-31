import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../games/story.dart';

class StoryGameScreen extends StatefulWidget {
  final Story story;

  const StoryGameScreen({Key? key, required this.story}) : super(key: key);

  @override
  _StoryGameScreenState createState() => _StoryGameScreenState();
}

class _StoryGameScreenState extends State<StoryGameScreen> {
  final FlutterTts _flutterTts = FlutterTts();
  late List<String> _storyPages;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _storyPages = widget.story.content.split("\n\n");
  }

  void _speak(String text) async {
    await _flutterTts.setLanguage("ar");
    await _flutterTts.setSpeechRate(0.5);
    await _flutterTts.speak(text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset('assets/images/Blue.png', fit: BoxFit.cover),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back,
                  size: 50,
                  color: Color.fromARGB(255, 238, 184, 59),
                ),
              ),
            ),
          ),
          Column(
            children: [
              const SizedBox(height: 60),
              Text(
                widget.story.title,
                style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.blue),
              ),
              const SizedBox(height: 20),
              Expanded(
                      flex: 2,
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Image.asset(widget.story.imagePath, fit: BoxFit.contain),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.yellow.shade100,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.black, width: 2),
                        ),
                        child: SingleChildScrollView(
                          child: Text(
                            _storyPages[_currentPage],
                            style: const TextStyle(fontSize: 22, height: 1.8, color: Colors.black),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios, color: Colors.blue, size: 30),
                    onPressed: () {
                      if (_currentPage > 0) {
                        setState(() {
                          _currentPage--;
                        });
                      }
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.audiotrack, size: 50, color: Colors.blue),
                    onPressed: () => _speak(_storyPages[_currentPage]),
                  ),
                  IconButton(
                    icon: const Icon(Icons.arrow_forward_ios, color: Colors.blue, size: 30),
                    onPressed: () {
                      if (_currentPage < _storyPages.length - 1) {
                        setState(() {
                          _currentPage++;
                        });
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _flutterTts.stop();
    super.dispose();
  }
}
