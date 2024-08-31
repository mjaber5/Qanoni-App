part of 'signin_bloc.dart';

sealed class SigninState extends Equatable {
  const SigninState();

  @override
  List<Object> get props => [];
}

final class SigninInitial extends SigninState {}

class SignInSuccess extends SigninState {}

class SignInFailure extends SigninState {
  final String? message;

  const SignInFailure({this.message});
}

class SignInProcess extends SigninState {}
