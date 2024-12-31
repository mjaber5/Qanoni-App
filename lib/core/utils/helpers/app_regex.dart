class AppRegex {
  static bool isUserNameValid(String username) {
    return RegExp(r'^[A-Za-z]+(?: [A-Za-z]+){2,}$').hasMatch(username) &&
        !username.contains(RegExp(r'[^A-Za-z\s]')) &&
        !username.startsWith(' ') &&
        username.trim().split(' ').length >= 3;
  }

  static bool isPhoneNumberValid(String phoneNumber) {
    return RegExp(r'^(07)[7-9][0-9]{7}$').hasMatch(phoneNumber);
  }

  static bool isEmailValid(String email) {
    return RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
        .hasMatch(email);
  }

  static bool isPasswordValid(String password) {
    return RegExp(
            r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@\$!%*?&])[A-Za-z\d@\$!%*?&]{8,12}$")
        .hasMatch(password);
  }

  static bool hasLowerCase(String password) {
    return RegExp(r'^(?=.*[a-z])').hasMatch(password);
  }

  static bool hasUpperCase(String password) {
    return RegExp(r'^(?=.*[A-Z])').hasMatch(password);
  }

  static bool hasNumber(String password) {
    return RegExp(r'^(?=.*?[0-9])').hasMatch(password);
  }

  static bool hasSpecialCharacter(String password) {
    return RegExp(r'^(?=.*?[#?!@$%^&*-])').hasMatch(password);
  }

  static bool hasMinLength(String password) {
    return RegExp(r'^(?=.{8,})').hasMatch(password);
  }

  static bool isNationalIdValid(String idNumber) {
    return RegExp(r'^9\d{9}$').hasMatch(idNumber);
  }
}
