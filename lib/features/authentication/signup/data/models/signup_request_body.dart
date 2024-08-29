class SignupRequestBody {
  final String name;
  final String email;
  final String phone;
  final String password;
  final String passwordConfirmation;

  SignupRequestBody({
    required this.passwordConfirmation,
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
  });
}
