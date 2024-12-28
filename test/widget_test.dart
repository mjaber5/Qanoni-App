import 'package:flutter_test/flutter_test.dart';
import 'package:qanoni/core/utils/helpers/app_regex.dart';

void main() {
  group('AppRegex Tests', () {
    // Test for Password Validation
    test('Valid password', () {
      expect(AppRegex.isPasswordValid('Password123!'), true);
    });

    test('Invalid password (too short)', () {
      expect(AppRegex.isPasswordValid('Pwd1!'), false); // Too short
    });

    test('Invalid password (too long)', () {
      expect(AppRegex.isPasswordValid('Password12345678!'),
          false); // > 12 characters
    });

    test('Invalid password (missing number)', () {
      expect(AppRegex.isPasswordValid('Password!'), false); // No number
    });

    test('Invalid password (missing special character)', () {
      expect(AppRegex.isPasswordValid('Password123'),
          false); // No special character
    });

    test('Invalid password (missing uppercase)', () {
      expect(AppRegex.isPasswordValid('password123!'),
          false); // No uppercase letter
    });

    test('Invalid password (missing lowercase)', () {
      expect(AppRegex.isPasswordValid('PASSWORD123!'),
          false); // No lowercase letter
    });

    // Test for Phone Number Validation
    test('Valid phone number', () {
      expect(AppRegex.isPhoneNumberValid('0778123456'),
          true); // Valid Kenyan phone number
    });

    test('Invalid phone number (wrong prefix)', () {
      expect(AppRegex.isPhoneNumberValid('0758123456'),
          false); // Wrong prefix (should be 07)
    });

    test('Invalid phone number (too short)', () {
      expect(AppRegex.isPhoneNumberValid('07781234'), false); // Too short
    });

    test('Invalid phone number (too long)', () {
      expect(AppRegex.isPhoneNumberValid('0778123456789'), false); // Too long
    });

    test('Invalid phone number (invalid second digit)', () {
      expect(AppRegex.isPhoneNumberValid('0768123456'),
          false); // Invalid second digit (should be between 7-9)
    });
  });
}
