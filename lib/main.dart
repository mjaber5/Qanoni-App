import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:qanoni/features/home/data/contract_repo.dart';
import 'package:qanoni/features/home/presentation/view_model/contract_status/contract_status_cubit.dart';
import 'core/errors/failures.dart';
import 'package:user_repository/user_reposetory.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/chatbot/presentation/views/widgets/chat_provider.dart';
import 'features/theme/presentation/view_model/cubit/change_theme_cubit.dart';
import 'qanoni.dart';
import 'simple_bloc_observer.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  log('Handling a background message: ${message.notification?.title}');
  // Handle background message here
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  try {
    await Firebase.initializeApp();
  } catch (e) {
    if (e is DioException) {
      ServerFailure.fromDioException(e);
    }
  }

  Bloc.observer = SimpleBlocObserver();

  final prefs = await SharedPreferences.getInstance();
  ContractRepo contractRepo = ContractRepo();

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (_) => ThemeCubit(prefs),
      ),
      BlocProvider(
        create: (_) => ContractCubit(contractRepo),
      ),
    ],
    child: MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => ChatProvider()), // إضافة ChatProvider هنا
      ],
      child: RepositoryProvider(
        create: (_) => FirebaseUserRepo(),
        child: Qanoni(
          FirebaseUserRepo(),
          prefs: prefs,
        ),
      ),
    ),
  ));
}
