import 'dart:math';

import 'package:AthlosFlutter/src/widgets/fitness/carousel/arrow.dart';
import 'package:AthlosFlutter/src/widgets/fitness/carousel/carouselDisplay.dart';
import 'package:AthlosFlutter/src/widgets/fitness/fitnessConstants.dart';
import 'package:flutter/material.dart';

import 'package:AthlosFlutter/src/utils/dates.dart';
// this is the top component of each fitness page with the circle, 
// image, main data display, arrows, and dropdown
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
          Container(
            width: MediaQuery.of(context).size.width * .9,
            child: DropdownButton<String>(
              value: dateTexts[widget.activityIndex],
              icon: Icon(Icons.arrow_drop_down),
              iconSize: 24,
              elevation: 16,
              style: TextStyle(color: Colors.deepPurple),
              underline: Container(
                height: 2,
                color: Colors.deepPurpleAccent,
              ),
              onChanged: (String dateText) {
                widget.setActivityIndex(dateTexts.indexOf(dateText));
              },
              // dropdown should be disabled if this is empty
              items: this._buildDropDownDates(dateTexts)
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Arrow(
                  onPress: () => widget.setActivityIndex(min(widget.activityData.length - 1, widget.activityIndex + 1)),
                  direction: 'left'
                ),
                CarouselDisplay(
                  activity: widget.activity,
                  primaryDisplay: widget.primaryDisplay,
                  secondaryDisplay: widget.secondaryDisplay,
                ),
                Arrow(
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