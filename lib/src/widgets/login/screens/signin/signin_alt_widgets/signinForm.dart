import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:AthlosFlutter/src/utils/dialogs.dart';
import 'package:AthlosFlutter/src/endpoints.dart';
import 'package:AthlosFlutter/src/widgets/login/login_widgets/fadeAnimation.dart';
import 'package:string_validator/string_validator.dart';
import 'package:AthlosFlutter/src/widgets/login/login_widgets/fadeAnimation.dart';
import 'package:AthlosFlutter/src/widgets/login/screens/signin/signin_alt_widgets/signinButton.dart';

class SigninForm extends StatelessWidget {
  SigninForm({@required this.setToken});
  final Function setToken;

  final _formKey = GlobalKey<FormState>();
  final PASSWORD_ERROR = 'Password must only contain alphanumeric characters or any of the !.@#\$%^&*-= special characters';

  String _signinEmail;
  String _signinPassword;

  _onSignin(BuildContext context) async {
    print("singing in...");
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      // make a request to the Athlos backend and set the token
      try {
        var response = await http.post(SIGNIN, body: {
          'email': _signinEmail,
          'password': _signinPassword,
        });
        final body = json.decode(response.body);
        if (body['success']) {
          // set the token
          await setToken(body['token']);
          print("token ${body['token']} has been set!");
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
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(143, 148, 251, .2),
                  blurRadius: 20.0,
                  offset: Offset(0, 10)
                )
              ]
            ),
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.grey[100]))
                  ),
                  child: TextFormField(
                    validator: (value) => !isEmail(value) ? 'Not a valid email.' : null,
                    onSaved: (val) => this._signinEmail = val,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Email or Phone number",
                      hintStyle: TextStyle(color: Colors.grey[400])
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(8.0),
                  child: TextFormField(
                    // validator: (value) => !matches(value, r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$') ? PASSWORD_ERROR : null,
                    onSaved: (val) => this._signinPassword = val,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Password",
                      hintStyle: TextStyle(color: Colors.grey[400])
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 30,),
          FadeAnimation(2, SigninButton(onPressed: () => this._onSignin(context))),
        ]
      ),
    );
  }
}