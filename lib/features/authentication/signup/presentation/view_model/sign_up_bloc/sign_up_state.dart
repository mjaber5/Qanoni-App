part of 'sign_up_bloc.dart';

sealed class SignUpBlocState extends Equatable {
  const SignUpBlocState();

  @override
  List<Object> get props => [];
}

final class SignUpBlocInitial extends SignUpBlocState {}

class SignUpSuccess extends SignUpBlocState {}

class SignUpFailure extends SignUpBlocState {
  final String errorMessage;

  const SignUpFailure(this.errorMessage);
}

class SignUpProcess extends SignUpBlocState {}
