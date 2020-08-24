import 'dart:math';

import 'package:AthlosFlutter/src/widgets/fitness/fitnessConstants.dart';
import 'package:flutter/material.dart';
import 'dart:core';

import 'package:AthlosFlutter/src/widgets/fitness/carousel/carousel.dart';
import 'package:AthlosFlutter/src/widgets/fitness/charts/fitnessLineChart.dart';
import 'package:AthlosFlutter/src/widgets/fitness/charts/fitnessPieChart.dart';
// import 'package:quiver/iterables.dart';

class Jump extends StatefulWidget {
  final jumpJson;
  Jump({@required this.jumpJson});

  @override
  _JumpState createState() => _JumpState();
}

class _JumpState extends State<Jump> {
  int activityIndex = 0;
  // create the labels for each jump
  List<int> _makeHeightLabels() {
    final jumpSession = widget.jumpJson['activityData'][this.activityIndex];
    return List.generate(jumpSession['heights'].length, (idx) => idx + 1);
  }

  List<double> _makeHeightValues() {
    final jumpSession = widget.jumpJson['activityData'][this.activityIndex];
    final heights = jumpSession['heights'];
    // use a for loop in case one of the data entries isn't actually a double
    List<double> result = [];
    for (int i = 0; i < heights.length; i++) {
      result.add(heights[i].toDouble());
    }
    return result;
  }

  void setActivityIndex(newIndex) {
    setState(() {
      this.activityIndex = newIndex;
    });
  }

  double maxHeight(heights) {
    double maxi = 0;
    for (var height in heights) {
      maxi = max(height.toDouble(), maxi);
    }
    return maxi;
  }

  @override
  Widget build(BuildContext context) {
    final List activityData = widget.jumpJson['activityData'];
    print(activityData is List<double>);
    if (activityData.length == 0) {
      return Text("No Activity data");
    }
    var highestJump = maxHeight(activityData[this.activityIndex]['heights']);
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Carousel(
            activity: JUMP,
            primaryDisplay: '$highestJump inches',
            secondaryDisplay: null,
            activityData: widget.jumpJson['activityData'],
            activityIndex: this.activityIndex,
            setActivityIndex: this.setActivityIndex
          ),
          FitnessLineChart(
            labels: this._makeHeightLabels(),
            values: this._makeHeightValues(),
            interval: 5
          ),
        ]
      )
    );
  }
}