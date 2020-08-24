import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:AthlosFlutter/src/constants.dart';
import 'package:AthlosFlutter/src/widgets/fitness/fitnessConstants.dart';
import 'package:AthlosFlutter/src/endpoints.dart';

const activityToKey = {
  RUN:  RUN_DATA_KEY,
  SWIM: SWIM_DATA_KEY,
  JUMP: JUMP_DATA_KEY
};

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
    // prefsFuture.then((prefs){
    //   prefs.remove(JUMP_DATA_KEY);
    //   prefs.remove(RUN_DATA_KEY);
    //   prefs.remove(SWIM_DATA_KEY);
    // });
  }

  Future getActivityJson(activity) async {
    // CHANGE TO GET THE FIRST 10-50 ENTRIES MAYBE
    print('activity is: $activity, id is: ${this.userID}');
    SharedPreferences prefs = await this.prefsFuture;

    if (this.userID == null) {
      // check if the activity is already in local storage
      String potentialActivityData = prefs.getString(activityToDataKey[activity]);
      if (potentialActivityData != null) {
        // print("already in local storage: $potentialActivityData");
        return json.decode(potentialActivityData);
      }
      // else set the user Id and prepare to fetch from backend
      String token = prefs.getString(TOKEN_KEY);
      if (token == null) {
        throw new Exception("Token is null. Please close the app and sign in again");
      }
      final tokenResponse = await http.get(
        TOKEN_TO_ID,
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
        }
      );
      this.userID = json.decode(tokenResponse.body)['userID'];
    }

    // fetch activity data from the server
    var res = await http.post(GET_USER_FITNESS, body: {
      'activity': activity,
      'userID': this.userID,
    });
    var resBody = json.decode(res.body);
    if (resBody['success']) {
      // store in local storage, and return the decoded data
      Map activityJson = {
        'activity': activity,
        'activityData': resBody['activityData']
      };
      prefs.setString(activityToDataKey[activity], json.encode(activityJson));
      // this is the run/jump/swim json
      return activityJson;
    } else {
      throw new Exception('failed getting activity json data :(');
    }
  }
}