import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HiUserText extends StatefulWidget {
  const HiUserText({super.key});

  @override
  State<HiUserText> createState() => _HiUserTextState();
}

class _HiUserTextState extends State<HiUserText> {
  String? cachedFirstName;
  bool isUpdating = false;

  @override
  void initState() {
    super.initState();
    _loadAndUpdateUserName();
  }

  Future<void> _loadAndUpdateUserName() async {
    final prefs = await SharedPreferences.getInstance();

    final cachedName = prefs.getString('cachedFirstName');
    if (cachedName != null) {
      setState(() {
        cachedFirstName = cachedName;
      });
    }

    await _updateUserName();
  }

  Future<void> _updateUserName() async {
    if (isUpdating) return;
    isUpdating = true;

    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final docSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      if (docSnapshot.exists) {
        final userData = docSnapshot.data() as Map<String, dynamic>;
        final fullName = userData['userName'] ?? 'Unknown User';
        final firstName = fullName.split(' ').first;

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('cachedFirstName', firstName);

        setState(() {
          cachedFirstName = firstName;
        });
      } else {
        setState(() {
          cachedFirstName = 'Unknown User';
        });
      }
    } else {
      setState(() {
        cachedFirstName = 'User not logged in';
      });
    }

    isUpdating = false;
  }

  @override
  Widget build(BuildContext context) {
    if (cachedFirstName == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hello, $cachedFirstName',
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
