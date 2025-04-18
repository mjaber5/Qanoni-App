import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../../../core/errors/failures.dart';
import 'package:user_repository/user_reposetory.dart';

part 'signin_event.dart';
part 'signin_state.dart';

class SigninBloc extends Bloc<SigninEvent, SigninState> {
  final UserRepository _userRepository;

  SigninBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(SigninInitial()) {
    on<SignInRequired>((event, emit) async {
      emit(SignInProcess());
      try {
        await _userRepository.signIn(event.email, event.password);
        emit(SignInSuccess());
      } on FirebaseAuthException catch (errorException) {
        emit(SignInFailure(message: errorException.code));
      } catch (error) {
        if (error is DioException) {
          emit(SignInFailure(
              message: ServerFailure.fromDioException(error) as String));
        }
      }
    });
    on<SignOutRequired>((event, emit) async {
      try {
        await _userRepository.logOut();
        emit(SignOutSuccess());
      } catch (error) {
        if (error is DioException) {
          emit(SignOutFailure(ServerFailure.fromDioException(error) as String));
        }
      }
    });
  }
}
