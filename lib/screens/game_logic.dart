import 'package:supabase_flutter/supabase_flutter.dart';

// دالة لحفظ بيانات اللعبة بعد انتهائها
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
