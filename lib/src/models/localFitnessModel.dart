import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:AthlosFlutter/src/constants.dart';
import 'package:AthlosFlutter/src/widgets/fitness/fitnessConstants.dart';
import 'package:AthlosFlutter/src/endpoints.dart';

// a model containing the all the LOCAL OR SEARH user's fitness
class FitnessModel with ChangeNotifier {
  // takes in the userId that will be used to get the fitness data
  // if null, assume it is the current user's and get their token and id
  String userID;
  static const Map<String, String> activityToDataKey = {
    RUN: RUN_DATA_KEY,
    SWIM: SWIM_DATA_KEY,
    JUMP: JUMP_DATA_KEY
  };
  Future<SharedPreferences> prefsFuture = SharedPreferences.getInstance();
  Object runJson;
  Object swimJson;
  Object jumpJson;
  // optional userId parameter if we are creating a search user fitness model
  FitnessModel([String userID]) {
    this.userID = userID;
    // if (userID == null) {
    //   print('setting user fitness');
    //   this._setLocalUserFitness();
    // } else {
    //   print('setting search user fitness...');
    //   this._setSearchUserFitness();
    // }
  }

  // get the local user's id and sets the field accordingly
  // void _setUserIdFromStorage() async {
  //   print('setting user id...');
  //   SharedPreferences prefs = await this.prefsFuture;
  //   // first check if the id is present in local storage
  //   String potentialUserData = prefs.getString(USER_DATA_KEY);
  //   if (potentialUserData != null) {
  //     this.userID = json.decode(potentialUserData)['_id'];
  //     return;
  //   }
  //   String token = prefs.getString(TOKEN_KEY);
  //   if (token == null) {
  //     throw new Exception("Token is null. Please close the app and sign in again");
  //   }
  //   final tokenResponse = await http.get(
  //     TOKEN_TO_ID,
  //     headers: {
  //       HttpHeaders.authorizationHeader: 'Bearer $token',
  //     }
  //   );
  //   this.userID = json.decode(tokenResponse.body)['userID'];
  // }

  Future getActivityJson(activity) async {
    // CHANGE TO GET THE FIRST 10-50 ENTRIES MAYBE
    print('activity is: $activity, id is: ${this.userID}');
    SharedPreferences prefs = await this.prefsFuture;
    if (this.userID == null) {
      // check if the activity is already in local storage
      String potentialActivityData = prefs.getString(activityToDataKey[activity]);
      if (potentialActivityData != null) {
        return json.decode(potentialActivityData);
      }
      // else set the user Id and prepare to fetch from backend
      this.userID = prefs.getString(TOKEN_KEY);
    }
    var res = await http.post(GET_USER_FITNESS, body: {
      'activity': activity,
      'userID': this.userID,
    });
    var resBody = json.decode(res.body);
    print('resBody: $resBody');
    if (resBody['success']) {
      return json.decode(resBody['activityData']);
    } else {
      throw new Exception('faield getting activity json data :(');
    }
  }

  // void _setActivities() async {
  //   // get the recent fitness data of this user
  //   final activityJsons = await Future.wait([
  //     this._getActivityJson('run'),
  //     this._getActivityJson('swim'),
  //     this._getActivityJson('jump'),
  //   ]);
  //   this.runJson = {
  //     'action': RUN,
  //     'imageUrl': RUN_ICON,
  //     'activityData': activityJsons[0]
  //   };
  //   this.swimJson = {
  //     'action': SWIM,
  //     'imageUrl': SWIM_ICON,
  //     'activityData': activityJsons[1]
  //   };
  //   this.jumpJson = {
  //     'action': JUMP,
  //     'imageUrl': JUMP_ICON,
  //     'activityData': activityJsons[2]
  //   };
  // }

  // void _setSearchUserFitness() async {
  //   try {
  //     // get the recent fitness data of this user
  //     await this._setActivities();
  //     notifyListeners();
  //   } catch(e) {
  //     print(e);
  //     throw new Exception(e.toString());
  //   }
  // }

  // void _setLocalUserFitness() async {
  //   print('setting local user fitness');
  //   try {
  //     // first check if it's already stored in local storage
  //     SharedPreferences prefs = await this.prefsFuture;
  //     // prefs.remove(RUN_DATA_KEY);
  //     // prefs.remove(SWIM_DATA_KEY);
  //     // prefs.remove(JUMP_DATA_KEY);
  //     final potentialRunString = prefs.getString(RUN_DATA_KEY);
  //     final potentialSwimString = prefs.getString(SWIM_DATA_KEY);
  //     final potentialJumpString = prefs.getString(JUMP_DATA_KEY);
  //     if (potentialRunString != null && potentialSwimString != null && potentialJumpString != null) {
  //       print('fitness data already in local storage!');
  //       this.runJson =  json.decode(potentialRunString);
  //       this.swimJson = json.decode(potentialSwimString);
  //       this.jumpJson = json.decode(potentialJumpString);
  //       print('RUN JSON IS');
  //       print(this.runJson);
  //       return;
  //     }
  //     // set the user id field since it is null
  //     await _setUserIdFromStorage();
  //     // get the recent fitness data of this user
  //     await this._setActivities();
  //     print(this.runJson);
  //     // store in local storage if it is the local user's fitness
  //     prefs.setString(RUN_DATA_KEY,  json.encode(this.runJson));
  //     prefs.setString(SWIM_DATA_KEY, json.encode(this.swimJson));
  //     prefs.setString(JUMP_DATA_KEY, json.encode(this.jumpJson));
  //   } catch(e) {
  //     print(e);
  //     throw new Exception(e.toString());
  //   }
  // }
}