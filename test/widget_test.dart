import 'package:flutter_test/flutter_test.dart';
import 'package:qanoni/core/utils/helpers/app_regex.dart';

void main() {
  group('AppRegex', () {
    test('isUserNameValid should return true for valid usernames', () {
      expect(AppRegex.isUserNameValid("Mohammed Amjed Jaber"), true);
      expect(AppRegex.isUserNameValid("Ali Hasan Khalid"), true);
    });

    test('isUserNameValid should return false for invalid usernames', () {
      expect(AppRegex.isUserNameValid("Mohammed"), false); // Less than 3 words
      expect(
          AppRegex.isUserNameValid("Mohammed 123"), false); // Contains numbers
      expect(AppRegex.isUserNameValid("Mohammed@Jaber"),
          false); // Contains special characters
      expect(
          AppRegex.isUserNameValid(" Mohammed"), false); // Starts with a space
    });

    test('isPhoneNumberValid should return true for valid phone numbers', () {
      expect(AppRegex.isPhoneNumberValid("0771234567"), true);
      expect(AppRegex.isPhoneNumberValid("0789876543"), true);
    });

    test('isPhoneNumberValid should return false for invalid phone numbers',
        () {
      expect(AppRegex.isPhoneNumberValid("0671234567"),
          false); // Starts with invalid prefix
      expect(AppRegex.isPhoneNumberValid("07712345"), false); // Too short
      expect(AppRegex.isPhoneNumberValid("07712345678"), false); // Too long
      expect(
          AppRegex.isPhoneNumberValid("0771234abc"), false); // Contains letters
    });

    test('isEmailValid should return true for valid email addresses', () {
      expect(AppRegex.isEmailValid("test@example.com"), true);
      expect(AppRegex.isEmailValid("user.name@domain.co"), true);
    });

    test('isEmailValid should return false for invalid email addresses', () {
      expect(
          AppRegex.isEmailValid("test@com"), false); // Missing domain extension
      expect(AppRegex.isEmailValid("test@.com"), false); // Missing domain name
      expect(AppRegex.isEmailValid("test.com"), false); // Missing @ symbol
      expect(AppRegex.isEmailValid("@example.com"), false); // Missing username
    });

    group('Password Validation', () {
      test('isPasswordValid should return true for valid passwords', () {
        expect(AppRegex.isPasswordValid("Abc123!@"), true); // Valid
        expect(AppRegex.isPasswordValid("QwErTy12#"), true); // Valid
        expect(AppRegex.isPasswordValid("Aa1!@%&12"), true); // Valid
      });

      test('isPasswordValid should return false for invalid passwords', () {
        expect(
            AppRegex.isPasswordValid("abc123!@"), false); // No uppercase letter
        expect(
            AppRegex.isPasswordValid("ABC123!@"), false); // No lowercase letter
        expect(AppRegex.isPasswordValid("Abcdefg!"), false); // No digit
        expect(AppRegex.isPasswordValid("Abc123456"),
            false); // No special character
        expect(AppRegex.isPasswordValid("Aa1!@"), false); // Too short
        expect(AppRegex.isPasswordValid("Aa1!@%&123456"), false); // Too long
      });
    });

    test('hasLowerCase should return true for passwords with lowercase letters',
        () {
      expect(AppRegex.hasLowerCase("abc"), true);
      expect(AppRegex.hasLowerCase("AbC"), true);
    });

    test(
        'hasLowerCase should return false for passwords without lowercase letters',
        () {
      expect(AppRegex.hasLowerCase("ABC"), false);
      expect(AppRegex.hasLowerCase("123"), false);
    });

    test('hasUpperCase should return true for passwords with uppercase letters',
        () {
      expect(AppRegex.hasUpperCase("ABC"), true);
      expect(AppRegex.hasUpperCase("AbC"), true);
    });

    test(
        'hasUpperCase should return false for passwords without uppercase letters',
        () {
      expect(AppRegex.hasUpperCase("abc"), false);
      expect(AppRegex.hasUpperCase("123"), false);
    });

    test('hasNumber should return true for passwords with numbers', () {
      expect(AppRegex.hasNumber("123"), true);
      expect(AppRegex.hasNumber("a1b2c3"), true);
    });

    test('hasNumber should return false for passwords without numbers', () {
      expect(AppRegex.hasNumber("abc"), false);
      expect(AppRegex.hasNumber("!@#"), false);
    });

    test(
        'hasSpecialCharacter should return true for passwords with special characters',
        () {
      expect(AppRegex.hasSpecialCharacter("abc!"), true);
      expect(AppRegex.hasSpecialCharacter("123#"), true);
    });

    test(
        'hasSpecialCharacter should return false for passwords without special characters',
        () {
      expect(AppRegex.hasSpecialCharacter("abc"), false);
      expect(AppRegex.hasSpecialCharacter("123"), false);
    });

    test('hasMinLength should return true for passwords with sufficient length',
        () {
      expect(AppRegex.hasMinLength("12345678"), true);
      expect(AppRegex.hasMinLength("abcdefgh"), true);
    });

    test(
        'hasMinLength should return false for passwords with insufficient length',
        () {
      expect(AppRegex.hasMinLength("123"), false);
      expect(AppRegex.hasMinLength("abc"), false);
    });

    test('isNationalIdValid should return true for valid national IDs', () {
      expect(AppRegex.isNationalIdValid("9123456789"), true);
      expect(AppRegex.isNationalIdValid("9234567890"), true);
    });

    test('isNationalIdValid should return false for invalid national IDs', () {
      expect(AppRegex.isNationalIdValid("8123456789"),
          false); // Does not start with 9
      expect(AppRegex.isNationalIdValid("912345678"), false); // Too short
      expect(AppRegex.isNationalIdValid("91234567890"), false); // Too long
      expect(
          AppRegex.isNationalIdValid("91234567a9"), false); // Contains letters
    });
  });
}
