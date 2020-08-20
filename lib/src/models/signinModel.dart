import 'package:flutter/material.dart';

// to be used as a mixin for LoginModel
abstract class SigninModel with ChangeNotifier {
  String signinEmail = '';
  String signinPassword = '';

  void onEmailChange(newEmail) {
    signinEmail = newEmail;
    notifyListeners();
  }
}