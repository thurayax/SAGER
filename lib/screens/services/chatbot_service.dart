import 'package:dialog_flowtter/dialog_flowtter.dart';

class ChatbotService {
  late DialogFlowtter dialogFlowtter;

  ChatbotService() {
    DialogFlowtter.fromFile(path: "assets/dialogflow_key.json").then((instance) {
      dialogFlowtter = instance;
    }).catchError((error) {
      print("Error initializing DialogFlowtter: $error");
    });
  }

  Future<String> sendMessage(String message) async {
    try {
      DetectIntentResponse response = await dialogFlowtter.detectIntent(
        queryInput: QueryInput(text: TextInput(text: message, languageCode: "ar")),
      );

      if (response.message?.text?.text?.isNotEmpty ?? false) {
        return response.message!.text!.text![0];
      } else {
        return "لم يتم تلقي رد.";
      }
    } catch (e) {
      print("Error communicating with chatbot: $e");
      return "حدث خطأ أثناء الاتصال بالشات بوت.";
    }
  }
}
