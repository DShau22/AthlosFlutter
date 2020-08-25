import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

import 'package:AthlosFlutter/src/widgets/fitness/fitnessConstants.dart';
import 'package:AthlosFlutter/src/constants.dart';

final Map activityToIcon = {
  RUN:  RUN_ICON,
  SWIM: SWIM_ICON,
  JUMP: JUMP_ICON,
};

final Map<String, Color> activityToColor = {
  RUN:  RUN_GRADIENT[0],
  SWIM: SWIM_GRADIENT[0],
  JUMP: JUMP_GRADIENT[0],
};

class CarouselDisplay extends StatefulWidget {
  // activity should never change
  final String activity;
  // can change based on parent state updates
  final String primaryDisplay;
  final String secondaryDisplay;

  CarouselDisplay({
    @required String this.activity,
    @required String this.primaryDisplay,
    String this.secondaryDisplay,
  });

  @override
  _CarouselDisplayState createState() => _CarouselDisplayState();
}

class _CarouselDisplayState extends State<CarouselDisplay> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: CircularPercentIndicator(
        radius: MediaQuery.of(context).size.width * .68,
        lineWidth: 5.0,
        percent: 1.0,
        center: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                activityToIcon[widget.activity],
                size: 68, 
                color: activityToColor[widget.activity], 
              ),
              SizedBox(height: 10),
              Text(
                widget.primaryDisplay,
                style: TextStyle(color: activityToColor[widget.activity], fontSize: 24)
              ),
              SizedBox(height: 10),
              widget.secondaryDisplay != null ? Text(widget.secondaryDisplay) : SizedBox(height: 0)
            ],
          )
        ),
        progressColor: activityToColor[widget.activity],
      )
    );
  }
}