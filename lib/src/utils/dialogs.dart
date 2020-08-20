// a bunch of functions for showing dialogs
import 'package:flutter/material.dart';

void showButtonlessDialog(BuildContext outerContext, String title, String body) {
  // flutter defined function
  showDialog(
    context: outerContext,
    builder: (BuildContext context) {
      // return object of type Dialog
      return AlertDialog(
        title: new Text(title),
        content: new Text(body),
        // actions: <Widget>[
        //   // usually buttons at the bottom of the dialog
        //   new FlatButton(
        //     child: new Text("Close"),
        //     onPressed: () {
        //       Navigator.of(context).pop();
        //     },
        //   ),
        // ],
      );
    },
  );
}

void showButtonWithDialog(BuildContext outerContext, String title, String body, List<Widget> buttons) {
  showDialog(
    context: outerContext,
    builder: (BuildContext context) {
      // return object of type Dialog
      return AlertDialog(
        title: new Text(title),
        content: new Text(body),
        actions: buttons
      );
    },
  );
}