import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';

class LoadingScreen extends StatelessWidget {
  @override
  StatelessWidget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Text("hello!")
    );
  }
}