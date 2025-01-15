import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'story.dart';

class StoriesListScreen extends StatelessWidget {
  final List<Story> stories = [
    Story(
      title: 'رحلة اكتشاف غابة السر',
      imagePath: 'assets/images/forest.png',
      content: '''
      كان يا مكان في قديم الزمان، في قرية صغيرة...
      ''',
    ),
    Story(
      title: 'الأصدقاء',
      imagePath: 'assets/images/friends.png',
      content: '''
      في قرية صغيرة هادئة تحيط بها الحقول الخضراء...
      ''',
    ),
    Story(
      title: 'رحلة إلى المملكة الساحرة',
      imagePath: 'assets/images/kingdom.png',
      content: '''
      كان يا ما كان، في قديم الزمان، في قرية صغيرة...
      ''',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // الخلفية
          Positioned.fill(
            child: Image.asset(
              'assets/images/Blue.png', // استبدل هذا بمسار الخلفية الخاص بك
              fit: BoxFit.cover,
            ),
          ),
          // زر الرجوع
          Positioned(
            top: 40,
            left: 20,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context); // الرجوع إلى الصفحة السابقة
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      blurRadius: 5,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(8),
                child: const Icon(
                  Icons.arrow_back,
                  size: 24,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          // المحتوى
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: stories.map((story) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => StoryBookScreen(story: story),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    width: 200, // تكبير العرض
                    height: 300, // تكبير الارتفاع
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20), // زوايا دائرية
                      image: DecorationImage(
                        image: AssetImage(story.imagePath),
                        fit: BoxFit.cover,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.6),
                          spreadRadius: 4,
                          blurRadius: 8,
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class StoryBookScreen extends StatefulWidget {
  final Story story;

  const StoryBookScreen({Key? key, required this.story}) : super(key: key);

  @override
  _StoryBookScreenState createState() => _StoryBookScreenState();
}

class _StoryBookScreenState extends State<StoryBookScreen> {
  final FlutterTts _flutterTts = FlutterTts();
  late List<String> _storyPages;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    // تقسيم النص إلى صفحات بناءً على الفقرات
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
      appBar: AppBar(
        title: Text(widget.story.title),
        backgroundColor: Colors.blue[200],
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // الرجوع إلى الصفحة السابقة
          },
        ),
      ),
      body: PageView.builder(
        itemCount: _storyPages.length,
        onPageChanged: (index) {
          setState(() {
            _currentPage = index;
          });
        },
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue.shade100, Colors.green.shade100],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Expanded(
                    flex: 3,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        widget.story.imagePath,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    flex: 4,
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 5,
                          ),
                        ],
                      ),
                      child: SingleChildScrollView(
                        child: Text(
                          _storyPages[index],
                          style: const TextStyle(
                            fontSize: 18,
                            height: 1.6,
                            color: Colors.black87,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.volume_up, color: Colors.blue),
                        onPressed: () => _speak(_storyPages[index]),
                      ),
                      Text(
                        "الصفحة ${index + 1} من ${_storyPages.length}",
                        style: const TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _flutterTts.stop();
    super.dispose();
  }
}
