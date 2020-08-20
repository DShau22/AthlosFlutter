import 'package:flutter/material.dart';

// to be used as a mixin for LoginModel
abstract class SignupModel with ChangeNotifier {
  String email = '';
  String password = '';
  String passwordConf = '';
  String firstName = '';
  String lastName = '';
  String userName = '';

  void onEmailChange(newEmail) {
    email = newEmail;
    notifyListeners();
  }
}