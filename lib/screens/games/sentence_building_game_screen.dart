import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SentenceBuildingGameScreen extends StatefulWidget {
  @override
  _SentenceBuildingGameScreenState createState() =>
      _SentenceBuildingGameScreenState();
}

class _SentenceBuildingGameScreenState
    extends State<SentenceBuildingGameScreen> {
  final Map<String, List<String>> categories = {
    'الأساسيات': [
      'assets/images/sentence_game/انا.png',
      'assets/images/sentence_game/انت.png',
      'assets/images/sentence_game/هو.png',
      'assets/images/sentence_game/هي.png',
      'assets/images/sentence_game/أريد التحدث.png',
      'assets/images/sentence_game/جائع.png',
      'assets/images/sentence_game/عطشان.png',
      'assets/images/sentence_game/لا.png',
      'assets/images/sentence_game/من.png',
      'assets/images/sentence_game/شكرًا.png',
      'هذا',
      'هذه',
      'نعم',
    ],
    'الأسئلة': [
      'assets/images/sentence_game/متى.png',
      'assets/images/sentence_game/لماذا.png',
      'assets/images/sentence_game/من.png',
      'assets/images/sentence_game/أين.png',
      'assets/images/sentence_game/ماذا.png',
    ],
    'الأفعال': [
      'assets/images/sentence_game/الذهاب.png',
      'assets/images/sentence_game/أريد.png',
      'assets/images/sentence_game/افعل.png',
      'assets/images/sentence_game/استطيع.png',
      'assets/images/sentence_game/انظر.png',
      'assets/images/sentence_game/أكل.png',
      'assets/images/sentence_game/اشرب.png',
      'assets/images/sentence_game/طلب.png',
      'assets/images/sentence_game/توقف.png',
      'assets/images/sentence_game/انتهى.png',
      'assets/images/sentence_game/أحب.png',
      'أشعر',
      'اصنع'
    ],
    'المحادثات': [
      'assets/images/sentence_game/مرحبًا.png',
      'assets/images/sentence_game/وداعًا.png',
      'assets/images/sentence_game/شكرًا.png',
      'كيف حالك؟',
      'أنا بخير',
      'أنا لست بخير',
      'حسناً',
      'من فضلك',
    ],
    'المشاعر': [
      'assets/images/sentence_game/مضحك.png',
      'assets/images/sentence_game/سعيد.png',
      'assets/images/sentence_game/منزعج.png',
      'assets/images/sentence_game/متحمس.png',
      'حزين',
      'غاضب',
      'خائف',
      'متفاجئ',
    ],
    'الألعاب': ['كرة القدم', 'كرة السلة', 'ألعاب الفيديو', 'الشطرنج', 'السباق'],
    'الطعام والشراب': [
      'تفاحة',
      'برتقالة',
      'موزة',
      'خبز',
      'جبنة',
      'لحم',
      'ماء',
      'عصير'
    ],
    'الأماكن': ['المنزل', 'المدرسة', 'الحديقة', 'المتجر', 'المكتبة'],
    'الألوان': ['أحمر', 'أزرق', 'أخضر', 'أصفر', 'برتقالي', 'أسود', 'أبيض'],
    'الأرقام': ['۰', '۱', '۲', '۳', '٤', '٥', '٦', '٧', '۸', '۹', '۱۰'],
    'الأشكال': ['دائرة', 'مربع', 'مثلث', 'نجمة', 'قلب'],
  };

  final Map<String, String> imageToTextMap = {
    //الأساسيات
    'assets/images/sentence_game/انا.png': 'أنا',
    'assets/images/sentence_game/انت.png': 'أنت',
    'assets/images/sentence_game/هو.png': 'هو',
    'assets/images/sentence_game/هي.png': 'هي',
    'assets/images/sentence_game/أريد التحدث.png': 'أريد التحدث',
    'assets/images/sentence_game/جائع.png': 'جائع',
    'assets/images/sentence_game/عطشان.png': 'عطشان',
    'assets/images/sentence_game/لا.png': 'لا',
    'assets/images/sentence_game/من.png': 'من؟',
    'assets/images/sentence_game/شكرًا.png': 'شكرًا',
    //الأسئلة
    'assets/images/sentence_game/متى.png': 'متى؟',
    'assets/images/sentence_game/لماذا.png': 'لماذا؟',
    'assets/images/sentence_game/من.png': 'من؟',
    'assets/images/sentence_game/أين.png': 'أين؟',
    'assets/images/sentence_game/ماذا.png': 'ماذا؟',
    //الأفعال
    'assets/images/sentence_game/الذهاب.png': 'الذهاب',
    'assets/images/sentence_game/أريد.png': 'أريد',
    'assets/images/sentence_game/افعل.png': 'افعل',
    'assets/images/sentence_game/استطيع.png': 'استطيع',
    'assets/images/sentence_game/انظر.png': 'انظر',
    'assets/images/sentence_game/أكل.png': 'اكل',
    'assets/images/sentence_game/اشرب.png': 'اشرب',
    'assets/images/sentence_game/طلب.png': 'طلب',
    'assets/images/sentence_game/توقف.png': 'توقف',
    'assets/images/sentence_game/انتهى.png': 'انتهى',
    'assets/images/sentence_game/أحب.png': 'أحب',
    //الإفعال
    'assets/images/sentence_game/مرحبًا.png': 'مرحبًا',
    'assets/images/sentence_game/وداعًا.png': 'وداعًا',
    'assets/images/sentence_game/شكرًا.png': 'شكرًا',
    //المشاعر
    'assets/images/sentence_game/سعيد.png': 'سعيد',
    'assets/images/sentence_game/منزعج.png': 'منزعج',
    'assets/images/sentence_game/متحمس.png': 'متحمّس',
    'assets/images/sentence_game/مضحك.png': 'مضحك',
  };

  List<String> sentence = [];
  String selectedCategory = 'الأساسيات';
  late DateTime startTime;

  @override
  void initState() {
    super.initState();
    startTime = DateTime.now();
  }

  @override
  void dispose() {
    final endTime = DateTime.now();
    final duration = endTime.difference(startTime).inMinutes;

    saveGameProgress('لعبة تكوين الجمل', duration);
    super.dispose();
  }

  Future<void> saveGameProgress(String gameName, int duration) async {
    try {
      final response =
          await Supabase.instance.client.from('game_progress').insert({
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

  void removeLastWord() {
    if (sentence.isNotEmpty) {
      setState(() {
        sentence.removeLast();
      });
    }
  }

  void resetSentence() {
    setState(() {
      sentence.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true, // Ensures the title is centered
        title: const Text(
          'لعبة تكوين الجُمل',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black, // Adjust color as needed
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Return to the previous screen
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
            SizedBox(height: 20),
            DragTarget<String>(
              onAccept: (data) {
                setState(() {
                  // Add corresponding text if it's an image, otherwise use the word
                  sentence.add(imageToTextMap[data] ?? data);
                });
              },
              builder: (context, candidateData, rejectedData) {
                return Container(
                  height: 120,
                  margin: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Color(0xFFD9F4FF),
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Center(
                    child: Text(
                      sentence.isEmpty
                          ? 'اسحب الكلمات إلى هنا'
                          : sentence.join(' '),
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color:
                            sentence.isEmpty ? Colors.grey : Color(0xFF333333),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              },
            ),
            ElevatedButton(
              onPressed: removeLastWord,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade400,
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Text(
                'احذف الكلمة الأخيرة',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
            SizedBox(height: 20),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: categories.keys.map((category) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6.0),
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          selectedCategory = category;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: selectedCategory == category
                            ? Color(0xFF709E8F)
                            : Colors.grey.shade300,
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Text(
                        category,
                        style: TextStyle(
                          fontSize: 14,
                          color: selectedCategory == category
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: categories[selectedCategory]!.length,
                  itemBuilder: (context, index) {
                    return Draggable<String>(
                      data: categories[selectedCategory]![index],
                      child:
                          WordCard(word: categories[selectedCategory]![index]),
                      feedback: Material(
                        color: Colors.transparent,
                        child: WordCard(
                          word: categories[selectedCategory]![index],
                          isDragging: true,
                        ),
                      ),
                      childWhenDragging: Opacity(
                        opacity: 0.5,
                        child: WordCard(
                            word: categories[selectedCategory]![index]),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WordCard extends StatelessWidget {
  final String word;
  final bool isDragging;

  const WordCard({required this.word, this.isDragging = false});

  @override
  Widget build(BuildContext context) {
    final isImage =
        word.startsWith('assets/images/'); // Detect if it's an image path

    return Card(
      color: isDragging ? const Color(0xFF76D7C4) : Colors.white,
      elevation: isDragging ? 8.0 : 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Center(
        child: isImage
            ? Image.asset(
                word, // Display the image
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => const Icon(
                  Icons.broken_image,
                  size: 48.0,
                  color: Colors.grey,
                ),
              )
            : Text(
                word, // Display the text
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: isDragging ? Colors.white : const Color(0xFF333333),
                ),
              ),
      ),
    );
  }
}
