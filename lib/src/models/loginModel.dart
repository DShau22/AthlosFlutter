import 'package:flutter/material.dart';

import 'package:AthlosFlutter/src/models/signinModel.dart';
import 'package:AthlosFlutter/src/models/signupModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginModel with ChangeNotifier, SignupModel, SigninModel {
  String token;
  Future<SharedPreferences> prefsFuture = SharedPreferences.getInstance();
  LoginModel() {
    // get the token from storage if it's present
    this._getToken();
  }

  // async function for getting token from localstorage if present
  Future<void> _getToken() async {
    print("getting token...");
    try {
      SharedPreferences prefs = await this.prefsFuture;
      // prefs.remove('token');
      String token = prefs.getString('token');
      this.token = token;
      print('token is $token');
      notifyListeners();
    } catch(e) {
      print(e);
      throw new Exception(e.toString());
    }
  }

  // sets the token instance variable, and also stores it in local storage
  void setToken(token) async {
    print('setting token...');
    try {
      SharedPreferences prefs = await this.prefsFuture;
      await prefs.setString('token', token);
      this.token = token;
      notifyListeners();
    } catch(e) {
      print(e);
      throw new Exception(e.toStrin());
    }
  }
}