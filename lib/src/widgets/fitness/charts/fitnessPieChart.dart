import 'package:collection/collection.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:quiver/iterables.dart';

import './legendKey.dart';
class FitnessPieChart extends StatefulWidget {
  // need to pass in the following data:
  // Pie chart data (doesn't have to add up to 100 or 1)
  // Pie chart labels (the stuff that is displayed on top of the donut sections)
  // colors (array of colors for each pie chart section)
  // key labels (array of strings for the labels for each key in the legend)
  final chartData;
  final sectionLabels;
  final colors;
  final keyLabels;
  FitnessPieChart(this.chartData, this.sectionLabels, this.colors, this.keyLabels) {
    assert (chartData.length == sectionLabels.length && chartData.length == colors.length && chartData.length == keyLabels.length,
      'array lengths must be equal.');
  } 

  @override
  _FitnessPieChartState createState() => _FitnessPieChartState();
}

class _FitnessPieChartState extends State<FitnessPieChart> {
  int touchedIndex;

  // returns an array of widgets to be passed into a column for the chart legend
  List<Widget> _createLegend() {
    List<Widget> legend = [];
    for (int i = 0; i < widget.colors.length; i++) {
      var color = widget.colors[i];
      var key = widget.keyLabels[i];
      legend.add(LegendKey(color: color, text: key, isSquare: true));
      legend.add(SizedBox(height: 4));
    }
    legend.add(SizedBox(height: 12));
    return legend;
  }

  List<PieChartSectionData> _createSections() {
    List<PieChartSectionData> sections = [];
    for (int i = 0; i < widget.colors.length; i++) {
      final bool isTouched = i == this.touchedIndex;
      final double fontSize = isTouched ? 25 : 16;
      final double radius = isTouched ? 60 : 50;
      var color = widget.colors[i];
      var label = widget.sectionLabels[i];
      var data  = widget.chartData[i];
      sections.add(PieChartSectionData(
        color: color,
        value: data,
        title: isTouched ? label : '',
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)
        ),
      ));
    }
    return sections;
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.3,
      child: Card(
        color: Colors.white,
        child: Row(
          children: <Widget>[
            const SizedBox(
              height: 18,
            ),
            Expanded(
              child: AspectRatio(
                aspectRatio: 1,
                child: PieChart(
                  PieChartData(
                    pieTouchData: PieTouchData(touchCallback: (pieTouchResponse) {
                      setState(() {
                        if (pieTouchResponse.touchInput is FlLongPressEnd ||
                            pieTouchResponse.touchInput is FlPanEnd) {
                          touchedIndex = -1;
                        } else {
                          touchedIndex = pieTouchResponse.touchedSectionIndex;
                        }
                      });
                    }),
                    borderData: FlBorderData(
                      show: false,
                    ),
                    sectionsSpace: 3,
                    centerSpaceRadius: 40,

                    // function call that returns list of PieChartSectionData to display
                    // sections: this.showingSections()
                    sections: this._createSections()
                  ),
                ),
              ),
            ),
            // this is the column that contains the chart legend
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              // this should be a map function using the this.colors and this.keyLabels fields
              children: _createLegend(),
            ),
            // for spacing on the right
            const SizedBox(
              width: 28,
            ),
          ],
        ),
      ),
    );
  }

  // this function actually returns the pie chart data
  // sum of pie chart section values don't have to equal 100
  List<PieChartSectionData> showingSections() {
    // this should be a map using the this.colors, this.data, this.sectionLabels fields
    return List.generate(4, (i) {
      final isTouched = i == touchedIndex;
      final double fontSize = isTouched ? 25 : 16;
      final double radius = isTouched ? 60 : 50;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: const Color(0xff0293ee),
            value: 40,
            title: '40%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
          );
        case 1:
          return PieChartSectionData(
            color: const Color(0xfff8b250),
            value: 30,
            title: '30%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
          );
        case 2:
          return PieChartSectionData(
            color: const Color(0xff845bef),
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
          );
        case 3:
          return PieChartSectionData(
            color: const Color(0xff13d38e),
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
          );
        default:
          return null;
      }
    });
  }
}