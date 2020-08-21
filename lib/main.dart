import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './src/models/loginModel.dart';
import './src/widgets/home/navigationApp.dart';
import './src/widgets/login/loginEntry.dart';

void main() {
  runApp(AthlosApp());
}

class AthlosApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginModel>(
      create: (context) => LoginModel(),
      child: Consumer<LoginModel>(
        builder: (context, loginModel, child) {
          return MaterialApp(
            title: 'flutter home',
            theme: ThemeData(
              // This is the theme of your application.
              //
              // Try running your application with "flutter run". You'll see the
              // application has a blue toolbar. Then, without quitting the app, try
              // changing the primarySwatch below to Colors.green and then invoke
              // "hot reload" (press "r" in the console where you ran "flutter run",
              // or simply save your changes to "hot reload" in a Flutter IDE).
              // Notice that the counter didn't reset back to zero; the application
              // is not restarted.
              primarySwatch: Colors.indigo,
              // This makes the visual density adapt to the platform that you run
              // the app on. For desktop platforms, the controls will be smaller and
              // closer together (more dense) than on mobile platforms.
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            // if the token is empty, display login, else the main navigation app
            home: 
              loginModel.token == null ?
              LoginEntry() : 
              NavigationApp(),
          );
        }
      )
    );
  }
}