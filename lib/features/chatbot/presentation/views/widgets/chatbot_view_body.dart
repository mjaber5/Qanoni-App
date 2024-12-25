import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:retry/retry.dart';
import 'package:provider/provider.dart'; // إضافة المكتبة الخاصة بـ Provider
import 'chat_provider.dart';
import 'chatbot_messages_list_view.dart';
import 'chatbot_text_feild.dart';
import 'custom_chatbot_app_bar.dart';
import 'package:dash_chat_2/dash_chat_2.dart';

class ChatbotViewBody extends StatefulWidget {
  const ChatbotViewBody({super.key});

  @override
  ChatbotViewBodyState createState() => ChatbotViewBodyState();
}

class ChatbotViewBodyState extends State<ChatbotViewBody> {
  final TextEditingController _controller = TextEditingController();
  final List<ChatUser> _typing = [];

  final String apiUrl =
      "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=AIzaSyClGN75ksKSYqzfo8S9ypmygky5dZ86tm4";
  final Map<String, String> header = {'Content-Type': 'application/json'};

  Future<void> _fetchBotResponse(String userMessage) async {
    final data = {
      "contents": [
        {
          "parts": [
            {"text": userMessage}
          ]
        }
      ]
    };

    final client = http.Client();
    try {
      final response = await retry(
        () async {
          final request = http.Request('POST', Uri.parse(apiUrl));
          request.headers.addAll(header);
          request.body = jsonEncode(data);
          final streamedResponse = await client.send(request);
          return http.Response.fromStream(streamedResponse);
        },
        retryIf: (e) => e is SocketException,
        maxAttempts: 3,
      );

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        final botResponse = result['candidates'][0]['content']['parts'][0]['text'];

        // إضافة الرد من البوت إلى الرسائل
        context.read<ChatProvider>().addMessage({
          'text': botResponse,
          'isUserMessage': false,
        });
        _typing.clear();
      } else {
        log('Error: ${response.statusCode}');
      }
    } catch (e) {
      log('Error: $e');
    } finally {
      client.close();
    }
  }

  void _handleSend() {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      // إضافة الرسالة من المستخدم إلى الرسائل
      context.read<ChatProvider>().addMessage({
        'text': text,
        'isUserMessage': true,
      });
      _controller.clear();

      // إضافة المستخدم إلى قائمة الذين يكتبون
      _typing.add(ChatUser(id: '1', firstName: 'Lawyer AI'));

      _fetchBotResponse(text);
    }
  }

  @override
  void initState() {
    super.initState();
    // تحميل الرسائل عند بدء التطبيق
    context.read<ChatProvider>().loadMessages();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CustomAppBar(),
        Consumer<ChatProvider>(
          builder: (context, provider, child) {
            return ChatbotMessagesListView(
              messages: provider.messages,
              typingUsers: _typing,
            );
          },
        ),
        ChatbotTextField(
          chatbotMessageController: _controller,
          onSend: _handleSend,
        ),
      ],
    );
  }
}
