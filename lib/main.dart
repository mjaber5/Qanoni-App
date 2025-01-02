import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:qanoni/core/services/base.dart';
import 'package:qanoni/features/home/data/contract_repo.dart';
import 'package:qanoni/features/home/presentation/view_model/contract_status/contract_status_cubit.dart';
import 'core/errors/failures.dart';
import 'package:user_repository/user_reposetory.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/chatbot/presentation/views/widgets/chat_provider.dart';
import 'features/notification/presentation/view_model/notification_cubit/notifications_cubit.dart';
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
  ContractRepo contractRepo = ContractRepo(baseUrl: ConfigApi.baseUri);
  FirebaseUserRepo userRepository = FirebaseUserRepo();

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (_) => ThemeCubit(prefs),
      ),
      BlocProvider(
        create: (_) => ContractCubit(contractRepo),
      ),
      BlocProvider(
        create: (_) => NotificationsCubit(
          FirebaseMessaging.instance,
          FirebaseFirestore.instance,
          FlutterLocalNotificationsPlugin(),
          userRepository,
        ),
      ),
    ],
    child: MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ChatProvider(),
        ),
      ],
      child: RepositoryProvider<UserRepository>(
        create: (_) => userRepository,
        child: Qanoni(
          userRepository,
          prefs: prefs,
        ),
      ),
    ),
  ));
}
