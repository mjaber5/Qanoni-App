import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qanoni/core/errors/failures.dart';
import 'package:user_repository/user_reposetory.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/theme/presentation/view_model/cubit/change_theme_cubit.dart';
import 'qanoni.dart';
import 'simple_bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
 
  try {
    await Firebase.initializeApp();
  } catch (e) {
    if (e is DioException) {
      ServerFailure.fromDioException(e);
    }
  }

  Bloc.observer = SimpleBlocObserver();

  final prefs = await SharedPreferences.getInstance();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => ThemeCubit(prefs),
        ),
      ],
      child: RepositoryProvider(
        create: (_) => FirebaseUserRepo(),
        child: Qanoni(
          FirebaseUserRepo(),
          prefs: prefs,
        ),
      ),
    ),
  );
}
