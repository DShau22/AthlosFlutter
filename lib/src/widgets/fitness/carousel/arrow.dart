import 'package:flutter/material.dart';

import 'package:AthlosFlutter/src/constants.dart';

class Arrow extends StatelessWidget {
  // onPress will increase or decrease the activity index by 1
  final Function onPress;
  final String direction;
  final Color color;
  Arrow({@required this.onPress, @required this.direction, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: IconButton(
        iconSize: 40,
        color: this.color,
        icon: Icon(this.direction == 'left' ? Icons.chevron_left : Icons.chevron_right),
        onPressed: this.onPress
      ),
    );
  }
}