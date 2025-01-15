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
    'الأساسيات': ['أنا', 'أنت', 'هو', 'هي', 'هذا', 'هذه', 'نعم', 'لا', 'شكراً', 'من؟'],
    'الأفعال': ['أحب', 'أريد', 'أشعر', 'أنظر', 'أستطيع', 'افعل', 'توقف', 'اصنع'],
    'المحادثات': [
      'مرحباً',
      'وداعاً',
      'كيف حالك؟',
      'أنا بخير',
      'أنا لست بخير',
      'حسناً',
      'من فضلك',
      'شكراً'
    ],
    'المشاعر': ['سعيد', 'حزين', 'غاضب', 'متوتر', 'خائف', 'متفاجئ', 'متحمس'],
    'الألعاب': ['كرة القدم', 'كرة السلة', 'ألعاب الفيديو', 'الشطرنج', 'السباق'],
    'الطعام والشراب': ['تفاحة', 'برتقالة', 'موزة', 'خبز', 'جبنة', 'لحم', 'ماء', 'عصير'],
    'الأماكن': ['المنزل', 'المدرسة', 'الحديقة', 'المتجر', 'المكتبة'],
    'الألوان': ['أحمر', 'أزرق', 'أخضر', 'أصفر', 'برتقالي', 'أسود', 'أبيض'],
    'الأرقام': ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10'],
    'الأشكال': ['دائرة', 'مربع', 'مثلث', 'نجمة', 'قلب'],
  };

  List<String> sentence = [];
  String selectedCategory = 'الأساسيات';
  late DateTime startTime;

  @override
  void initState() {
    super.initState();
    startTime = DateTime.now(); // وقت بدء اللعبة
  }

  @override
  void dispose() {
    final endTime = DateTime.now();
    final duration = endTime.difference(startTime).inMinutes;

    saveGameProgress('لعبة تكوين الجمل', duration); // حفظ تقدم اللعبة
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
      backgroundColor: Color(0xFFF5F5F5),
      appBar: AppBar(
        title: Text('لعبة تكوين الجمل'),
        backgroundColor: Color(0xFFFFA500),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // العودة إلى صفحة الألعاب
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: resetSentence,
            tooltip: 'إعادة تعيين الجملة',
          ),
        ],
      ),
      body: Column(
        children: [
          DragTarget<String>(
            onAccept: (data) {
              setState(() {
                sentence.add(data);
              });
            },
            builder: (context, candidateData, rejectedData) {
              return Container(
                height: 120,
                margin: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Color(0xFFD8BFD8),
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(color: Color(0xFF7F00FF), width: 2.0),
                ),
                child: Center(
                  child: Text(
                    sentence.isEmpty
                        ? 'اسحب الكلمات إلى هنا'
                        : sentence.join(' '),
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: sentence.isEmpty
                          ? Colors.grey
                          : Color(0xFF4B0082),
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
              backgroundColor: Colors.red,
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Text(
              'تراجع عن الكلمة الأخيرة',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 20),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: categories.keys.map((category) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        selectedCategory = category;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: selectedCategory == category
                          ? Colors.orange
                          : Colors.grey.shade300,
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
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
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: categories[selectedCategory]!.length,
                itemBuilder: (context, index) {
                  return Draggable<String>(
                    data: categories[selectedCategory]![index],
                    child: WordCard(word: categories[selectedCategory]![index]),
                    feedback: Material(
                      color: Colors.transparent,
                      child: WordCard(
                        word: categories[selectedCategory]![index],
                        isDragging: true,
                      ),
                    ),
                    childWhenDragging: Opacity(
                      opacity: 0.5,
                      child: WordCard(word: categories[selectedCategory]![index]),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
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
    return Card(
      color: isDragging ? Color(0xFFFFC0CB) : Colors.white,
      elevation: isDragging ? 8.0 : 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Center(
        child: Text(
          word,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: isDragging ? Colors.white : Color(0xFF000000),
          ),
        ),
      ),
    );
  }
}
