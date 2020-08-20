import 'package:flutter/material.dart';
import 'package:AthlosFlutter/src/widgets/login/login_widgets/fadeAnimation.dart';
import 'package:string_validator/string_validator.dart';
import 'package:AthlosFlutter/src/widgets/login/login_widgets/fadeAnimation.dart';
import 'package:AthlosFlutter/src/widgets/login/screens/signin/signin_alt_widgets/signinButton.dart';

class SigninForm extends StatelessWidget {

  final _formKey = GlobalKey<FormState>();
  final PASSWORD_ERROR = 'Password must only contain alphanumeric characters or any of the !.@#\$%^&*-= special characters';
  final RegExp regExp = new RegExp(
    r"^(?=.*[A-Za-z])(?=.*\d)[!@#$%^&*-=.A-Za-z\d]{8,}$",
    caseSensitive: false,
    multiLine: false,
  );

  String _signinEmail;
  String _signinPassword;
  
  onSignin() {
    print("singing in...");
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
                    onSaved: (val) => _signinEmail = val,
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
                    validator: (value) => matches(value, regExp) ? PASSWORD_ERROR : null,
                    onSaved: (val) => _signinEmail = val,
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
          FadeAnimation(2, SigninButton(onPressed: this.onSignin)),
        ]
      ),
    );
  }
}