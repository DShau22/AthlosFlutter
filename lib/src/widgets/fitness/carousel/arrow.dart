import 'package:flutter/material.dart';

class Arrow extends StatelessWidget {
  // onPress will increase or decrease the activity index by 1
  final Function onPress;
  final String direction;
  Arrow({@required this.onPress, @required this.direction});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: IconButton(
        icon: Icon(this.direction == 'left' ? Icons.chevron_left : Icons.chevron_right),
        onPressed: this.onPress
      ),
    );
  }
}