import 'package:flutter/material.dart';
import '../model/UserService.dart';

class LoginViewModel extends ChangeNotifier {
  String _email = '';
  String _password = '';
  String? emailError;
  String? passwordError;
  final UserService _userService = UserService();

  set email(String value) {
    _email = value;
    notifyListeners();
  }

  set password(String value) {
    _password = value;
    notifyListeners();
  }

  bool validateEmail(String email) {
    final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return email.isNotEmpty && emailRegex.hasMatch(email);
  }

  bool validatePassword(String password) {
    final passwordRegex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{6,24}$');
    return password.isNotEmpty && passwordRegex.hasMatch(password);
  }

  Future<bool> validateCredentials() async {
    bool isValidEmail = validateEmail(_email);
    bool isValidPassword = validatePassword(_password);

    // In ra giá trị của email và password
    print('Email: $_email');
    print('Password: $_password');
    print('Is valid email: $isValidEmail');
    print('Is valid password: $isValidPassword');

    // Cập nhật các thông báo lỗi
    emailError = isValidEmail ? null : 'Invalid email address';
    passwordError = isValidPassword ? null : 'Password must be at least 6 characters long and include one uppercase letter, one lowercase letter, and one digit';

    // In ra các thông báo lỗi
    print('Email error: $emailError');
    print('Password error: $passwordError');

    if (isValidEmail && isValidPassword) {
      try {
        bool isUserValid = await _userService.validateUser(_email, _password);

        // In ra kết quả xác thực người dùng
        print('Is user valid: $isUserValid');

        if (isUserValid) {
          emailError = 'Valid email or password';
          return true; // Credentials are valid
        } else {
          emailError = 'Invalid email or password';
          return false; // Invalid credentials
        }
      } catch (e) {
        // In ra lỗi nếu có
        print('Error validating user: $e');
        return false;
      }
    }

    notifyListeners();
    return false; // Invalid email or password format
  }

}
