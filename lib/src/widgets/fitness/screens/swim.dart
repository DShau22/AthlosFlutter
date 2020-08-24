import 'package:AthlosFlutter/src/widgets/fitness/fitnessConstants.dart';
import 'package:flutter/material.dart';
import 'dart:core';

import 'package:AthlosFlutter/src/widgets/fitness/carousel/carousel.dart';
import 'package:AthlosFlutter/src/widgets/fitness/charts/fitnessLineChart.dart';
import 'package:AthlosFlutter/src/widgets/fitness/charts/fitnessPieChart.dart';

const FLY    = 'u';
const BACK   = 'b';
const BREAST = 'r';
const FREE   = 'f';

class Swim extends StatefulWidget {
  final swimJson;
  Swim({@required this.swimJson});

  @override
  _SwimState createState() => _SwimState();
}

class _SwimState extends State<Swim> {
  int activityIndex = 0;
  void setActivityIndex(newIndex) {
    setState(() {
      this.activityIndex = newIndex;
    });
  }

  List<int> _makeTimesLabels() {
    final session = widget.swimJson['activityData'][this.activityIndex];
    return List.generate(session['lapTimes'].length, (idx) => idx + 1);
  }

  List<double> _makeTimesValues() {
    final session = widget.swimJson['activityData'][this.activityIndex];
    List<double> times = [];
    for (Map lap in session['lapTimes']) {
      times.add(lap['lapTime'].toDouble());
    }
    return times;
  }

  // calculates percentage where user was running, walking, resting.
  List<double> _makeDonutData() {
    final session = widget.swimJson['activityData'][this.activityIndex];
    double flyCount = 0, backCount = 0, breastCount = 0, freeCount = 0;
    for (String stroke in session['strokes']) {
      switch(stroke.toLowerCase()) {
        case FLY:
          flyCount++;
          break;
        case BACK:
          backCount++;
          break;
        case BREAST:
          breastCount++;
          break;
        case FREE:
          freeCount++;
          break;
        default:
          break;
      }
    }
    int totalLaps = session['strokes'].length;
    return [flyCount, backCount, breastCount, freeCount];
  }

  @override
  Widget build(BuildContext context) {
    print('swim json: ${widget.swimJson}');
    final activityData = widget.swimJson['activityData'];
    if (activityData.length == 0) {
      return Text("No Activity data");
    }
    final List donutData = this._makeDonutData();
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Carousel(
            activity: SWIM,
            primaryDisplay: '${activityData[this.activityIndex]['num']} laps',
            secondaryDisplay: null,
            activityData: activityData,
            activityIndex: this.activityIndex,
            setActivityIndex: this.setActivityIndex
          ),
          FitnessLineChart(
            labels: this._makeTimesLabels(),
            values: this._makeTimesValues(),
            interval: 10
          ),
          FitnessPieChart(
            donutData, // pie chart values
            donutData.map((numLaps) => '${numLaps.toInt()} laps').toList(), // pie chart section labels
            [Color(0xfff8b250), Color(0xff845bef), Color(0xff13d38e), Colors.blueGrey], // pie chart section colors
            ['Butterfly', 'Backstroke', 'Breastroke', 'Freestyle'], // pie chart legend labels
          ),
        ]
      )
    );
  }
}