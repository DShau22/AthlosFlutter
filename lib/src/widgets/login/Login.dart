import 'package:AthlosFlutter/src/widgets/generic/LoadingScreen.dart';
import 'package:flutter/material.dart';
import '../generic/LoadingScreen.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  bool _isLoading = false;
  var _message = '';
  var _hasError = false;

  @override
  Widget build(BuildContext context) {
    return
      _isLoading ?
      new LoadingScreen()
          :
      Scaffold(
        body: Container(
          child: Text("hello there from Login.dart!")
        ),
      )
    ;
  }
}