import 'package:autism_app/screens/reset_password.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// استيراد الشاشات المختلفة
import 'package:autism_app/screens/games/games_home_screen.dart' as games;
import 'screens/games/simulation_game_screen.dart';
import 'screens/games/story_game_screen.dart';
import 'screens/games/arabic_learning_screen.dart';
import 'screens/games/sentence_building_game_screen.dart';
import 'screens/games/games_list_screen.dart';
import 'screens/games/stories_list_screen.dart';
import 'screens/games/number_drawing_screen.dart';
import 'screens/login_screen.dart';
import 'screens/registration_screen.dart';
import 'package:autism_app/screens/home_screen.dart' as home;
import 'screens/settings_screen.dart';
import 'screens/progress_screen.dart';
import 'screens/games/story.dart';
import 'screens/parent_login_screen.dart';
import 'screens/parent_dashboard.dart';
import 'screens/parent_chatbot_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://uwkfmgboqijhgkkiyuwy.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InV3a2ZtZ2JvcWlqaGdra2l5dXd5Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzYxODg2MzAsImV4cCI6MjA1MTc2NDYzMH0.V9cA6xtC5y-1TJysVHhCq5QbL8An93neMcdsDWn0H1s',
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Autism App',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/home',
      routes: {
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegistrationScreen(),
        '/reset_password': (context) => ResetPasswordScreen(),
        '/games': (context) => games.GamesHomeScreen(),
        '/home': (context) => home.HomeScreen(),
        '/simulation_game': (context) => SimulationGameScreen(),
        '/arabic_learning': (context) => ArabicLearningScreen(),
        '/picture_sentence': (context) => SentenceBuildingGameScreen(),
        '/gameslist': (context) => GamesListScreen(),
        '/storieslist': (context) => StoriesListScreen(),
        '/number_drawing': (context) => NumbersLearningGame(),
        '/settings': (context) => SettingsScreen(),
        '/progress': (context) => ProgressScreen(),
        '/parent_login': (context) => ParentLoginScreen(),
        '/parent_dashboard': (context) => ParentDashboard(),
        '/chatbot': (context) => ParentChatbotScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/story_game') {
          final story = settings.arguments as Story;
          return MaterialPageRoute(
            builder: (context) => StoryGameScreen(story: story),
          );
        }
        return null;
      },
    );
  }
}
