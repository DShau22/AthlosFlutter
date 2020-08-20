import 'package:flutter/material.dart';
import 'package:AthlosFlutter/src/widgets/login/login_widgets/fadeAnimation.dart';

class SigninBackgroundAlt extends StatelessWidget {
  final Widget child;
  const SigninBackgroundAlt({
    Key key,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
          image: AssetImage('assets/images/background.png'),
          fit: BoxFit.fill
        )
      ),
      child: Stack(
        children: <Widget>[
          Positioned(
            left: 30,
            width: 80,
            height: 200,
            child: FadeAnimation(1, Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/light-1.png')
                )
              ),
            )),
          ),
          Positioned(
            left: 140,
            width: 80,
            height: 150,
            child: FadeAnimation(1.3, Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/light-2.png')
                )
              ),
            )),
          ),
          Positioned(
            right: 40,
            top: 40,
            width: 80,
            height: 150,
            child: FadeAnimation(1.5, Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/clock.png')
                )
              ),
            )),
          ),
          child,
        ],
      ),
    );
  }
}