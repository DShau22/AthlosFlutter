import 'package:flutter/material.dart';
import 'dart:core';

import 'package:AthlosFlutter/src/widgets/fitness/carousel/carousel.dart';
import 'package:AthlosFlutter/src/widgets/fitness/charts/fitnessLineChart.dart';
import 'package:AthlosFlutter/src/widgets/fitness/charts/fitnessPieChart.dart';

// btw restPaceMin and walkPaceMax is walking
// greater that walkPaceMax is running
const walkCadenceMax = 65; // 130 steps per minute is a fast walk, which is 2.16 steps/sec, 2.314 (.2sec) / step
// anything above restcadenceMax is resting
const restCadenceMin = 30; // say 60 steps per minute is basically resting. 1 step/sec, 5 (.2sec) / step

class Run extends StatefulWidget {
  final runJson;
  Run({@required this.runJson});

  @override
  _RunState createState() => _RunState();
}

class _RunState extends State<Run> {
  int activityIndex = 0;
  List<int> _makePaceLabels() {
    final runSession = widget.runJson['activityData'][this.activityIndex];
    // final int totalTime = runSession['time'];
    final List paces = runSession['cadences'];
    // final double timeInterval = totalTime / paces.length;
    List<int> timeSeries = [];

    // add 1 to length of paces array cuz you wanna start with 0
    // on the display chart
    for (int i = 0; i < paces.length + 1; i++) {
      timeSeries.add(i);
    }
    return timeSeries;
  }

  List<int> _makeCadenceValues() {
    final runSession = widget.runJson['activityData'][this.activityIndex];
    List<int> cadences = List.from(runSession['cadences']);
    cadences.insert(0, 0);
    return cadences;
  }

  // calculates percentage where user was running, walking, resting.
  List _makeDonutData() {
    final runSession = widget.runJson['activityData'][this.activityIndex];
    int runCount = 0;
    int walkCount = 0;
    for (int cadence in runSession['cadences']) {
      if (cadence > walkCadenceMax) {
        runCount++;
      } else if (cadence <= walkCadenceMax && cadence > restCadenceMin) {
        walkCount++;
      }
    }
    int numEntries = runSession['cadences'].length;
    double runPercent = (100 * runCount / numEntries).floorToDouble();
    double walkPercent = (100 * walkCount / numEntries).floorToDouble();
    return [runPercent, walkPercent, 100 - (runPercent + walkPercent)];
  }

  void setActivityIndex(newIndex) {
    setState(() {
      this. activityIndex = newIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    final activityData = widget.runJson['activityData'];
    if (activityData.length == 0) {
      return Text("No Activity data");
    }
    final runSession = activityData[this.activityIndex];
    final List donutData = this._makeDonutData();
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Carousel(
            activityData: widget.runJson['activityData'],
            activityIndex: this.activityIndex,
            setActivityIndex: this.setActivityIndex
          ),
          FitnessLineChart(
            labels: this._makePaceLabels(),
            values: this._makeCadenceValues(),
            interval: 50
          ),
          FitnessPieChart(
            donutData, // pie chart values
            donutData.map((percentage) => '$percentage%').toList(), // pie chart section labels
            [Color(0xfff8b250), Color(0xff845bef), Color(0xff13d38e)], // pie chart section colors
            ['running', 'walking', 'resting'], // pie chart legend labels
          ),
        ]
      )
    );
  }
}