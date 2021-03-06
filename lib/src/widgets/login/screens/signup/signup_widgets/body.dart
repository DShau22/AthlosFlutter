import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import './signupForm.dart';
import '../../signin/signin_screen.dart';
import '../../signin/signin_screen_alt.dart';

import './background.dart';
import './or_divider.dart';
import './social_icon.dart';
import '../../../login_widgets/already_have_an_account_acheck.dart';
import '../../../login_widgets/rounded_button.dart';
import '../../../login_widgets/rounded_input_field.dart';
import '../../../login_widgets/rounded_password_field.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "SIGNUP",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: size.height * 0.03),
              SignupForm(),
              SizedBox(height: size.height * 0.03),
              AlreadyHaveAnAccountCheck(
                login: false,
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        // return SigninScreen();
                        return SigninScreenAlt();
                      },
                    ),
                  );
                },
              ),
              // OrDivider(),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: <Widget>[
              //     SocalIcon(
              //       iconSrc: "assets/icons/facebook.svg",
              //       press: () {},
              //     ),
              //     SocalIcon(
              //       iconSrc: "assets/icons/twitter.svg",
              //       press: () {},
              //     ),
              //     SocalIcon(
              //       iconSrc: "assets/icons/google-plus.svg",
              //       press: () {},
              //     ),
              //   ],
              // )
            ],
          ),
        ),
      ),
    );
  }
}
