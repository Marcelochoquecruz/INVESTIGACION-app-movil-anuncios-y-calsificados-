// lib/providers/auth_provider.dart
import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  String email = '';
  String password = '';
  String confirmPassword = '';

  bool get isEmailValid => RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email);
  bool get isPasswordValid => password.length >= 6;
  bool get isConfirmPasswordValid => password == confirmPassword;

  void setEmail(String value) {
    email = value;
    notifyListeners();
  }

  void setPassword(String value) {
    password = value;
    notifyListeners();
  }

  void setConfirmPassword(String value) {
    confirmPassword = value;
    notifyListeners();
  }

  bool get canSubmit =>
      isEmailValid && isPasswordValid && isConfirmPasswordValid;
}
