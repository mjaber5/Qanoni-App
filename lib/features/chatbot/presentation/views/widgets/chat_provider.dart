import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _messages = [];
  List<Map<String, dynamic>> get messages => _messages;

  // تحميل الرسائل من SharedPreferences
  Future<void> loadMessages() async {
    final prefs = await SharedPreferences.getInstance();
    final messageData = prefs.getString('messages');
    if (messageData != null) {
      final List<dynamic> jsonList = List.from(jsonDecode(messageData));
      _messages = jsonList.map((e) => Map<String, dynamic>.from(e)).toList();
      notifyListeners();
    }
  }

  // حفظ الرسائل في SharedPreferences
  Future<void> saveMessages() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('messages', jsonEncode(_messages));
  }

  // إضافة رسالة جديدة
  void addMessage(Map<String, dynamic> message) {
    _messages.insert(0, message);
    saveMessages(); // حفظ الرسالة بعد إضافتها
    notifyListeners();
  }
}
