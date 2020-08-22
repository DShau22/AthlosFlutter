import 'package:flutter/material.dart';
import 'dart:core';
import 'package:AthlosFlutter/src/widgets/fitness/charts/fitnessLineChart.dart';

class Run extends StatefulWidget {
  final runJson;
  Run({@required this.runJson});

  @override
  _RunState createState() => _RunState();
}

class _RunState extends State<Run> {

  List<int> _makePaceLabels() {
    final runSession = widget.runJson['activityData'][0];
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
    final runSession = widget.runJson['activityData'][0];
    List<int> cadences = List.from(runSession['cadences']);
    cadences.insert(0, 0);
    return cadences;
  }

  @override
  Widget build(BuildContext context) {
    return FitnessLineChart(labels: this._makePaceLabels(), values: this._makeCadenceValues(), interval: 50);
  }
}