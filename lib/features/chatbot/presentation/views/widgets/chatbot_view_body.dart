import 'package:flutter/material.dart';
import 'package:qanoni/constant.dart';
// ignore: unused_import
import 'package:qanoni/core/utils/styles.dart';

class ChatbotViewBody extends StatefulWidget {
  const ChatbotViewBody({super.key});

  @override
  _ChatbotViewBodyState createState() => _ChatbotViewBodyState();
}

class _ChatbotViewBodyState extends State<ChatbotViewBody> {
  final List<Map<String, dynamic>> _messages = [];
  final TextEditingController _controller = TextEditingController();

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        _messages.insert(0, {'text': text, 'isUserMessage': true});
        _controller.clear();

        // Simulating bot response for demonstration purposes.
        Future.delayed(const Duration(milliseconds: 500), () {
          setState(() {
            _messages.insert(
                0, {'text': 'Bot response to "$text"', 'isUserMessage': false});
          });
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ChatBot'),
        backgroundColor: kSecondaryColor,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                bool isUserMessage = _messages[index]['isUserMessage'] as bool;
                return Align(
                  alignment: isUserMessage
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    padding: const EdgeInsets.all(12.0),
                    margin: const EdgeInsets.symmetric(
                        vertical: 4.0, horizontal: 8.0),
                    decoration: BoxDecoration(
                      color: isUserMessage ? kSecondaryColor : kGreyColor,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Text(
                      _messages[index]['text'] as String,
                      style: TextStyle(
                        color: isUserMessage ? Colors.white : Colors.black,
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
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Type your message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: const BorderSide(color: kSecondaryColor),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  color: kSecondaryColor,
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
