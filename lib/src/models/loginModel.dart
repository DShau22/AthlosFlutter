import 'package:flutter/material.dart';
import 'package:AthlosFlutter/src/models/signinModel.dart';
import 'package:AthlosFlutter/src/models/signupModel.dart';

class LoginModel with ChangeNotifier, SignupModel, SigninModel {
  String token = '';

  void setToken(token) {
    this.token = token;
    notifyListeners();
  }
}