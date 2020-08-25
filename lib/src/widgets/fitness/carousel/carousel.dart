import 'dart:math';

import 'package:AthlosFlutter/src/constants.dart';
import 'package:AthlosFlutter/src/widgets/fitness/carousel/arrow.dart';
import 'package:AthlosFlutter/src/widgets/fitness/carousel/carouselDisplay.dart';
import 'package:AthlosFlutter/src/widgets/fitness/fitnessConstants.dart';
import 'package:flutter/material.dart';

import 'package:AthlosFlutter/src/utils/dates.dart';
// this is the top component of each fitness page with the circle, 
// image, main data display, arrows, and dropdown

final Map<String, Color> activityToColor = {
  RUN:  RUN_GRADIENT[0],
  SWIM: SWIM_GRADIENT[0],
  JUMP: JUMP_GRADIENT[0],
};
class Carousel extends StatefulWidget {
  final String activity;
  final String primaryDisplay;
  final String secondaryDisplay;
  // the activity session (for swim, run, or jump)
  final List activityData;
  final Function setActivityIndex;
  final int activityIndex;
  Carousel({
    @required this.activity,
    @required this.primaryDisplay,
    this.secondaryDisplay,
    @required this.activityData,
    @required this.activityIndex,
    @required this.setActivityIndex
  });
  @override
  _CarouselState createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {

  List<DropdownMenuItem<String>> _buildDropDownDates(List<String> dateTexts) {
    return dateTexts.map((dateText) => DropdownMenuItem<String>(
      value: dateText,
      child: Text(dateText)
    )).toList();
  }

  @override
  Widget build(BuildContext context) {
    Map session;
    List<String> dateTexts;
    if (widget.activityData.length == 0) {
      session = {};
      dateTexts = [];
    } else {
      session = widget.activityData[widget.activityIndex];
      dateTexts = widget.activityData.map<String>((session) => parseUploadDate(session['uploadDate'])).toList();
    }
    return Container(
      child: Column(
        children: <Widget>[
          // dropdown button
          Container(
            padding: EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width,
            color: Colors.blueGrey[50],
            child: DropdownButton<String>(
              value: dateTexts[widget.activityIndex],
              icon: Icon(
                Icons.arrow_drop_down,
                color: activityToColor[widget.activity]
              ),
              iconSize: 36,
              elevation: 16,
              // dropdownColor: Colors.red,
              style: TextStyle(
                color: activityToColor[widget.activity],
                fontSize: 20,
              ),
              isExpanded: true,
              underline: SizedBox(height: 0),
              onChanged: (String dateText) {
                widget.setActivityIndex(dateTexts.indexOf(dateText));
              },
              // dropdown should be disabled if this is empty
              items: this._buildDropDownDates(dateTexts)
            ),
          ),
          // carousel
          Container(
            padding: EdgeInsets.all(6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Arrow(
                  color: activityToColor[widget.activity],
                  onPress: () => widget.setActivityIndex(min(widget.activityData.length - 1, widget.activityIndex + 1)),
                  direction: 'left'
                ),
                CarouselDisplay(
                  activity: widget.activity,
                  primaryDisplay: widget.primaryDisplay,
                  secondaryDisplay: widget.secondaryDisplay,
                ),
                Arrow(
                  color: activityToColor[widget.activity],
                  onPress: () => widget.setActivityIndex(max(widget.activityIndex - 1, 0)),
                  direction: 'right'
                ),
              ],
            )
          )
        ]
      )
    );
  }
}