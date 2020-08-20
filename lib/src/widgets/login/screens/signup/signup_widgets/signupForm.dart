import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:AthlosFlutter/src/utils/dialogs.dart';
import 'package:AthlosFlutter/src/endpoints.dart';
import 'package:AthlosFlutter/src/widgets/login/login_widgets/fadeAnimation.dart';
import 'package:string_validator/string_validator.dart';
import 'package:AthlosFlutter/src/widgets/login/login_widgets/fadeAnimation.dart';
import 'package:AthlosFlutter/src/widgets/login/screens/signup/signup_widgets/signupButton.dart';
import 'package:AthlosFlutter/src/widgets/login/screens/signin/signin_alt_widgets/signinButton.dart';

class SignupForm extends StatelessWidget {

  final _formKey = GlobalKey<FormState>();
  // controllers for password and conf pass to check for equality
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _passConfController = TextEditingController();

  final PASSWORD_ERROR = r'Password must have 1 capital letter, 1 lowercase letter, 1 number, 1 of @$!%*?& special symbols.';
  final PASSWORD_PATTERN = r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$';
  final NAME_PATTERN = r'^[a-zA-Z]{1,30}$';
  final NAME_ERROR = r'Can only contain letters. Must be less than 30 characters.';
  final USERNAME_PATTERN = r'^[a-zA-Z\d]{1,30}$';
  final USERNAME_ERROR = r'Can only contain letters and numbers. Must be less than 30 characters';
  final double INPUT_SPACING = 20;
  String _email;
  String _password;
  String _passwordConf;
  String _firstName;
  String _lastName;
  String _username;

  _onSignup(BuildContext context) async {
    print("signing up...");
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      // make a request to the Athlos backend and set the token
      try {
        var response = await http.post(SIGNUP, body: {
          'email': _email,
          'password': _password,
          'passwordConf': _passwordConf,
          'firstName': _firstName,
          'lastName': _lastName,
          'username': _username
        });
        final body = json.decode(response.body);
        if (body['success']) {
          showButtonlessDialog(context, "Almost There!", "Check your inbox at $_email for a confirmation email!");
        } else {
          print(body);
          throw new Exception(body['messages'][0]);
        }
      } catch(e) {
        print(e);
        showButtonlessDialog(context, "Oh No :(", e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
              validator: (value) => !isEmail(value) ? 'Not a valid email.' : null,
              onSaved: (val) => this._email = val,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Email",
                hintStyle: TextStyle(color: Colors.grey[400])
              ),
            ),
          ),
          SizedBox(height: INPUT_SPACING),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _passController,
              validator: (value) => !matches(value, PASSWORD_PATTERN) ? PASSWORD_ERROR : null,
              onSaved: (val) => this._password = val,
              obscureText: true,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Password",
                hintStyle: TextStyle(color: Colors.grey[400])
              ),
            ),
          ),
          SizedBox(height: INPUT_SPACING),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _passConfController,
              validator: (value) {
                if (this._passController.text != value) {
                  print('${this._passController.text}, $value');
                  return "Must match password";
                }
                return !matches(value, PASSWORD_PATTERN) ? PASSWORD_ERROR : null;
              },
              onSaved: (val) => this._passwordConf = val,
              obscureText: true,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Confirm Password",
                hintStyle: TextStyle(color: Colors.grey[400])
              ),
            ),
          ),
          SizedBox(height: INPUT_SPACING),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
              validator: (value) => !matches(value, NAME_PATTERN) ? NAME_ERROR : null,
              onSaved: (val) => this._firstName = val,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "first name",
                hintStyle: TextStyle(color: Colors.grey[400])
              ),
            ),
          ),
          SizedBox(height: INPUT_SPACING),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
              validator: (value) => !matches(value, NAME_PATTERN) ? NAME_ERROR : null,
              onSaved: (val) => this._lastName = val,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "last name",
                hintStyle: TextStyle(color: Colors.grey[400])
              ),
            ),
          ),
          SizedBox(height: INPUT_SPACING),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
              validator: (value) => !matches(value, USERNAME_PATTERN) ? USERNAME_ERROR : null,
              onSaved: (val) => this._username = val,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "username",
                hintStyle: TextStyle(color: Colors.grey[400])
              ),
            ),
          ),
          SizedBox(height: INPUT_SPACING),
          SignupButton(onPressed: () => this._onSignup(context)),
        ],
      ),
    );
  }
}