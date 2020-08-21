import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:AthlosFlutter/src/widgets/fitness/fitnessConstants.dart';
import 'package:AthlosFlutter/src/endpoints.dart';
import 'package:AthlosFlutter/src/constants.dart';

// a model containing the all the user's basic information for widgets to access
// this DOES NOT include data about user's community of fitness
class UserDataModel with ChangeNotifier {
  Future<SharedPreferences> prefsFuture = SharedPreferences.getInstance();
  String id;
  String firstName;
  String lastName;
  String username;
  String gender;
  String bio;
  int height;
  int weight;
  int age;
  dynamic profilePicture;
  dynamic settings;

  UserDataModel() {
    this._getUserData();
  }


  // async function for getting token from localstorage if present
  Future<String> _getToken() async {
    try {
      SharedPreferences prefs = await this.prefsFuture;
      // prefs.remove('token');
      return prefs.getString('token');
    } catch(e) {
      print(e);
      throw new Exception(e.toString());
    }
  }

  void _getUserData() async {
    try {
      SharedPreferences prefs = await this.prefsFuture;
      // first see if user data is in local storage
      String potentialUserData = prefs.getString(USER_DATA_KEY);
      if (potentialUserData != null) {
        final decodedUserData = json.decode(potentialUserData);
        this.id = decodedUserData['_id'];
        this.firstName = decodedUserData['firstName'];
        this.lastName = decodedUserData['lastName'];
        this.username = decodedUserData['username'];
        this.gender = decodedUserData['gender'];
        this.bio = decodedUserData['bio'];
        this.height = decodedUserData['height'];
        this.weight = decodedUserData['weight'];
        this.age = decodedUserData['age'];
        this.profilePicture = decodedUserData['profilePicture']; 
        this.settings = decodedUserData['settings'];
        notifyListeners();
        return;
      }

      String token = await this._getToken();
      if (token == null) {
        throw new Exception("Token is null. Please close the app and sign in again");
      }
      var res = await http.get(
        GET_USER_INFO,
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
        }
      );
      // store in local storage
      prefs.setString(USER_DATA_KEY, res.body);

      final resBody = json.decode(res.body);
      this.id = resBody['_id'];
      this.firstName = resBody['firstName'];
      this.lastName = resBody['lastName'];
      this.username = resBody['username'];
      this.gender = resBody['gender'];
      this.bio = resBody['bio'];
      this.height = resBody['height'];
      this.weight = resBody['weight'];
      this.age = resBody['age'];
      this.profilePicture = resBody['profilePicture']; 
      this.settings = resBody['settings'];
      notifyListeners();
    } catch(e) {
      print('error: $e');
      throw new Exception(e);
    }
  }
}