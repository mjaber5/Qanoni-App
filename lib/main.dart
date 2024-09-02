import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qanoni/core/utils/theme/change_theme_notifire.dart';

import 'package:qanoni/qanoni.dart';
import 'package:qanoni/simple_bloc_observer.dart';
import 'package:user_repository/user_reposetory.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = SimpleBlocObserver();
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: Qanoni(
        FirebaseUserRepo(),
      ),
    ),
  );
}
