import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:AthlosFlutter/src/widgets/login/login_widgets/fadeAnimation.dart';
import 'package:AthlosFlutter/src/widgets/login/screens/signup/signup_screen.dart';
import 'package:AthlosFlutter/src/widgets/login/login_widgets/already_have_an_account_acheck.dart';
import 'package:AthlosFlutter/src/widgets/login/screens/signin/signin_alt_widgets/signinBackground.dart';
import 'package:AthlosFlutter/src/widgets/login/screens/signin/signin_alt_widgets/signinForm.dart';
import 'package:AthlosFlutter/src/widgets/login/screens/signin/signin_alt_widgets/signinButton.dart';
import 'package:AthlosFlutter/src/models/loginModel.dart';

class SigninBodyAlt extends StatefulWidget {
  @override
  _SigninBodyAltState createState() => _SigninBodyAltState();
}

class _SigninBodyAltState extends State<SigninBodyAlt> {
  @override
  Widget build(BuildContext context) {
    // consume loginModel so that it can set the token
    return Consumer<LoginModel>(
      builder: (context, loginModel, child) => SigninBackgroundAlt(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(30.0),
                  child: Column(
                    children: <Widget>[
                      FadeAnimation(1.8, SigninForm()),
                      SizedBox(height: 40,),
                      FadeAnimation(2.2, 
                        Text(
                          "Forgot Password?",
                          style: TextStyle(color: Color.fromRGBO(143, 148, 251, 1)),
                        )
                      ),
                      SizedBox(height: 30,),
                      FadeAnimation(2.5, AlreadyHaveAnAccountCheck(
                        login: false,
                        press: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                // return SigninScreen();
                                return SignupScreen();
                              },
                            ),
                          );
                        },
                      )),
                    ],
                  ),
                ),
              ],
            ),
          )
        )
      ),
    );
  }
}