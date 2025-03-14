import 'package:flutter/material.dart';
import 'story.dart';
import 'story_game_screen.dart';

class StoriesListScreen extends StatelessWidget {
  final List<Story> stories = [
    Story(
      title: 'رحلة اكتشاف غابة السر',
      imagePath: 'assets/images/forest.png',
      content: '''كان يا مكان في قديم الزمان، في قرية صغيرة تحيط بها الجبال والغابات، عاش ثلاثة أصدقاء مقربين: سامي، سند، ومالك. كانوا دائمًا يهوون المغامرات والاكتشافات...

ذات يوم، بينما كانوا يلعبون قرب أطراف القرية، سمعوا قصة من أحد كبار السن عن "غابة السر"، وهي غابة مليئة بالأسرار والعجائب، ولكن لا يستطيع الوصول إلى قلبها إلا الأصدقاء الحقيقيون الذين يتعاونون ولا يتخلون عن بعضهم. قرر الأصدقاء أن يخوضوا هذه المغامرة ويكتشفوا أسرار الغابة...

في صباح اليوم التالي، انطلقوا حاملين حقيبة صغيرة فيها طعام وبعض الأدوات. عندما اقتربوا من الغابة، لاحظوا أنها مختلفة تمامًا عن الغابات الأخرى. كانت الأشجار طويلة جدًا، وكأنها تهمس لهم، وكان الهواء مليئًا برائحة الزهور الغريبة...

بعد انتهاء التحديات، ظهرت شجرة ذهبية تتلألأ في ضوء الشمس وقالت لهم: "لقد أظهرتم الشجاعة، التعاون، والعطاء. هذه هي أسرار النجاح والسعادة. خذوا من ثماري، فهي تمنح القوة والحكمة لمن يشاركونها مع الآخرين."''',
      audioPath: 'assets/audio/forest_story.mp3',
    ),
    Story(
      title: 'الأصدقاء',
      imagePath: 'assets/images/friends.png',
      content: '''في قرية صغيرة هادئة تحيط بها الحقول الخضراء والأشجار العالية، كانت هناك سبع صديقات مقربات: أروى، ضحى، مروة، شروق، جمانة، جنى، وإيثار...

ذات يوم، وبينما كانت الصديقات يلعبن بالقرب من حقل مليء بالأزهار، اقترحن القيام بنشاط ممتع. قررت أروى أن ترسم صورة على الأرض باستخدام أغصان الأشجار الصغيرة، وبدأت بحماس كبير. لكن جمانة كانت ترغب في استخدام نفس المكان لتصنع شكلًا لقوس قزح من الزهور الملونة...

بعد خلاف صغير، قررت الصديقات كتابة ذكرياتهن الجميلة وتعليقها على الشجرة الكبيرة التي يجتمعن تحتها دائمًا. وعندما شاهدت أروى وجمانة هذا الجهد، تصالحا، وأدرك الجميع أن الصداقة أهم من أي خلاف.''',
      audioPath: 'assets/audio/friends_story.mp3',
    ),
    Story(
  title: 'رحلة إلى المملكة الساحرة',
  imagePath: 'assets/images/kingdom.png',
  content: '''كان يا ما كان، في قديم الزمان، في قرية صغيرة تحيط بها الجبال، كان هناك أربعة أصدقاء يحبون المغامرات والقصص الغامضة. كانوا سارة، وليلى، وعمر، وكريم.

في أحد الأيام، وبينما كانوا يستكشفون مكتبة القرية القديمة، عثروا على صندوق خشبي صغير. فتح كريم الصندوق ليجدوا بداخله خريطة قديمة تشير إلى مكان بعيد يُدعى "المملكة الساحرة".

قرر الأصدقاء أن ينطلقوا في مغامرة لاكتشاف هذه المملكة. مع شروق الشمس، جهزوا حقيبة صغيرة تحتوي على بعض الطعام والماء، وبدأوا رحلتهم. ساروا عبر غابات خضراء ومروا على أنهار صافية حتى وصلوا إلى بوابة ضخمة مغطاة بالزهور المتلألئة.

على البوابة، كان مكتوبًا: "مرحبًا بكم في المملكة الساحرة، حيث كل شيء يتحدث!" نظر الأصدقاء إلى بعضهم بدهشة، ثم دفع عمر البوابة بحذر. فور دخولهم، فوجئوا بكل ما حولهم يتحدث! الأشجار تلوح بأغصانها وتقول: "مرحبًا، أيها الأصدقاء!"، الزهور تهمس بلطف: "ما أجمل يومكم!"، وحتى النهر كان يغني بصوت هادئ.

اقتربت منهم فراشة ملونة، وقالت بصوت ناعم: "مرحبًا أيها المغامرون! إذا أردتم معرفة أسرار المملكة والحصول على هديتها، فعليكم تجاوز ثلاثة تحديات."

قبل الأصدقاء التحدي بحماس، وبدأوا مغامرتهم داخل المملكة الساحرة.

في التحدي الأول، قادتهم الفراشة إلى بحيرة جميلة تحيط بها زهور بألوان مختلفة. تحدثت زهرة بنفسجية وسألتهم: "ما اللون الذي يجمع بيننا جميعًا؟" فكر الأصدقاء قليلًا، ثم قالت سارة: "الأخضر، لأنه لون الطبيعة التي نعيش فيها جميعًا." أجابت الزهرة بسعادة: "صحيح!"، وبدأت الزهور تضيء وكأنها تحتفل بإجابتهم.

في التحدي الثاني، وصلوا إلى شجرة ضخمة بأغصان ممتدة. قالت لهم الشجرة بصوت عميق: "لتنجحوا في هذا التحدي، عليكم أن تغنوا أغنية تجعل الغابة سعيدة." بدأ كريم يغني بصوت عالٍ، وانضمت إليه سارة، ثم عمر وليلى. كان غناؤهم بسيطًا ولكنه مليء بالفرح. انضمت الغابة كلها إليهم، الطيور تغرد، الأوراق تصفق، والنهر يكمل الأغنية بصوته الجميل.

أما في التحدي الثالث، فقد قادتهم الفراشة إلى طائر ذهبي كان ينتظرهم. قال لهم الطائر: "هنا هديتكم، لكنها هدية يجب أن تُستخدم لنشر الخير." قدم لهم صندوقًا صغيرًا، وعندما فتحوه، وجدوا فيه بذورًا ذهبية. قال عمر: "علينا زراعتها هنا!"، ووافقه الجميع. زرعوا البذور، وفجأة نمت أشجار رائعة مليئة بالفواكه التي بدأت تتحدث بلطف، تدعو الجميع لتذوقها.

بعد انتهاء التحديات، ظهر نسر ضخم وجميل في السماء، وهبط أمامهم. قال النسر بصوت هادئ: "لقد أثبتم أنكم أصدقاء حقيقيون للمملكة الساحرة. ستظل أبواب المملكة مفتوحة لكم دائمًا." عاد الأصدقاء إلى قريتهم، محملين بذكريات لا تُنسى عن المملكة الساحرة.

ومنذ ذلك اليوم، كانوا يروون قصتهم لكل من يقابلونه، لينقلوا درسًا بسيطًا: بالتعاون واللطف، يمكننا أن نعيش أجمل المغامرات ونكتشف العجائب.''',
  audioPath: 'assets/audio/kingdom_story.mp3',
),
  ];

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
              const SizedBox(height: 100),
              const Center(
                child: Text(
                  'قائمة القصص',
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 20, 85, 129)),
                ),
              ),
              const SizedBox(height: 40),
              Expanded(
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: stories.map((story) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => StoryGameScreen(story: story)),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          width: 200,
                          height: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
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
                          child: Center(
                            child: Icon(
                              Icons.audiotrack,
                              size: 30,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
