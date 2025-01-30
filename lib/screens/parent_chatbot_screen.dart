import 'package:flutter/material.dart';
import 'services/chatbot_service.dart';

class ParentChatbotScreen extends StatefulWidget {
  @override
  _ParentChatbotScreenState createState() => _ParentChatbotScreenState();
}

class _ParentChatbotScreenState extends State<ParentChatbotScreen> {
  final ChatbotService _chatbotService = ChatbotService();
  final TextEditingController _controller = TextEditingController();
  List<String> _messages = [];

  void _sendMessage() async {
    if (_controller.text.isNotEmpty) {
      String userMessage = _controller.text;
      setState(() {
        _messages.add(userMessage); // Add user message
      });

      String botReply = await _chatbotService.sendMessage(userMessage);
      setState(() {
        _messages.add(botReply); // Add bot reply
      });

      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "مساعد ساجـر",
          textAlign: TextAlign.center,
        ),
        backgroundColor: const Color(0xFF709E8F),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFE7F3FA),
              Color(0xFFB1D8E8),
            ],
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  bool isUserMessage = index % 2 == 0; // Alternate messages
                  return Align(
                    alignment: isUserMessage
                        ? Alignment
                            .centerRight // Align user messages to the right
                        : Alignment.centerLeft, // Align bot replies to the left
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: isUserMessage
                            ? Colors.white
                            : const Color(0x4D527566),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        _messages[index],
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: isUserMessage ? Colors.black : Colors.black,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  IconButton(
                    icon: Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationY(3.14159), // Mirror the icon
                      child: Icon(Icons.send, color: const Color(0xFF527566)),
                    ),
                    onPressed: _sendMessage,
                  ),
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      textAlign: TextAlign.right,
                      decoration: InputDecoration(
                        hintText: "أخبرني بما تحتاجه، أنا هنا لمساعدتك",
                        hintStyle: const TextStyle(color: Colors.grey),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
