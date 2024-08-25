import 'package:flutter/material.dart';
import 'package:qanoni/core/utils/constants/colors.dart';

class LoginTextFeilds extends StatelessWidget {
  const LoginTextFeilds({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            decoration: InputDecoration(
              labelText: 'Username',
              labelStyle: const TextStyle(color: QColors.textSecondary),
              border: const OutlineInputBorder(),
              prefixIcon: const Icon(Icons.person, color: QColors.secondary),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: QColors.secondary),
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).primaryColor),
              ),
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            decoration: InputDecoration(
              labelText: 'Password',
              labelStyle: const TextStyle(color: QColors.textSecondary),
              border: const OutlineInputBorder(),
              prefixIcon: const Icon(Icons.lock, color: QColors.secondary),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: QColors.secondary),
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).primaryColor),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            obscureText: true,
          ),
        ],
      ),
    );
  }
}
