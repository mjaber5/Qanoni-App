import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qanoni/core/utils/theme/change_theme_notifire.dart';
import 'package:qanoni/qanoni.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: const Qanoni(),
    ),
  );
}
