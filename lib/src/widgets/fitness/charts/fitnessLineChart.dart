  
import 'package:AthlosFlutter/src/constants.dart';
import 'package:AthlosFlutter/src/widgets/fitness/carousel/carousel.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class FitnessLineChart extends StatefulWidget {
  // expects to take in numeric labels and values
  final List<Color> gradientColors;
  final List labels;
  final List values;
  final double interval;
  FitnessLineChart({
    @required List<Color> this.gradientColors,
    @required List this.labels,
    @required List this.values,
    @required double this.interval,
  });

  @override
  _FitnessLineChartState createState() => _FitnessLineChartState();
}

class _FitnessLineChartState extends State<FitnessLineChart> {

  bool showAvg = false;

  double _getMaxValue() {
    double maxi = -1;
    for (int i = 0; i < widget.values.length; i++) {
      maxi = max(widget.values[i].toDouble(), maxi);
    }
    return maxi;
  }

  double _getAverageValue() {
    return widget.values.fold(0, (p, c) => p + c) / widget.values.length;
  }

  double _getMinLabel() {
    double mini = 100;
    for (int i = 0; i < widget.labels.length; i++) {
      mini = min(widget.labels[i].toDouble(), mini);
    }
    return mini;
  }

  List<FlSpot> _createChartData() {
    assert (widget.labels.length == widget.values.length, 
              'labels and values are not the same length. Labels.length: ${widget.labels.length}, Values.length: ${widget.values.length}');
    List<FlSpot> data = [];
    for (int i = 0; i < widget.labels.length; i++) {
      data.add(FlSpot(widget.labels[i].toDouble(), widget.values[i].toDouble()));
    }
    return data;
  }

  List<FlSpot> _createAvgChartData() {
    assert (widget.labels.length == widget.values.length, 
              'labels and values are not the same length. Labels: $widget.labels, Values: $widget.values');
    List<FlSpot> avgData = [];
    double valueAverage = this._getAverageValue().floorToDouble();
    for (int i = 0; i < widget.labels.length; i++) {
      avgData.add(FlSpot(widget.labels[i].toDouble(), valueAverage));
    }
    return avgData;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        // BOX FOR THE AVERAGE TOGGLE
        Align(
          alignment: Alignment(-.8, 0),
          child: FloatingActionButton.extended(
            elevation: 5,
            onPressed: () {
              setState(() {
                showAvg = !showAvg;
              });
            },
            backgroundColor: widget.gradientColors[0],
            label: Text(
              showAvg ? 'Back' : 'See Average',
              style: TextStyle(
                  fontSize: 20, color: Colors.white),
            ),
          ),
        ),
        // CONTAINER FOR THE LINE CHART
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
            constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width * .9),
            height: 300,
            width: (widget.labels.length * 20).toDouble(),
            decoration: const BoxDecoration(
              // color: Color(0xff232d37)
            ),
            child: Padding(
              padding: const EdgeInsets.only(right: 18.0, left: 12.0, top: 24, bottom: 12),
              // SECTION THAT DISPLAYS THE LINE CHART DATA
              child: LineChart(
                showAvg ? avgData() : mainData(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  LineChartData mainData() {
    return LineChartData(
      // options for the grid appearance
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: this._getMaxValue() / 5,
        verticalInterval: min(5, (widget.labels.length/5).roundToDouble()),
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: TEXT_COLOR_LIGHT.withOpacity(.2),
            strokeWidth: 1,
            dashArray: [8, 10],
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            // color: const Color(0xff37434d),
            color: TEXT_COLOR_LIGHT.withOpacity(.2),
            strokeWidth: 1,
            dashArray: [8, 10],
          );
        },
      ),
      // options for the chart x and y labels, as well as title. It technically has
      // top, right, bottom, and left 'titles'
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          interval: (widget.values.length / 10).floorToDouble(),
          showTitles: true,
          reservedSize: 22,
          textStyle:
              const TextStyle(color: Color(0xff68737d), fontWeight: FontWeight.bold, fontSize: 16),
          // getTitles: (value) {
          //   switch (value.toInt()) {
          //     case 2:
          //       return 'MAR';
          //     case 5:
          //       return 'JUN';
          //     case 8:
          //       return 'SEP';
          //   }
          //   return '';
          // },
          margin: 8,
        ),
        leftTitles: SideTitles(
          interval: widget.interval,
          showTitles: true,
          textStyle: const TextStyle(
            color: Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          // getTitles: (value) {
          //   int numEntries = widget.values.length;
          //   if (value.toInt() % 25 == 0) return value;
          //   return '';
          // },
          reservedSize: 28,
          margin: 12,
        ),
      ),
      // options for the chart border styles
      borderData:
        FlBorderData(show: false, border: Border.all(color: TEXT_COLOR_LIGHT.withOpacity(.1), width: 1)),
      minX: this._getMinLabel(),
      // maxX: ,
      minY: 0,
      maxY: this._getMaxValue() + 10,
      // where the line data actually is in x, y pairs
      lineBarsData: [
        LineChartBarData(
          spots: this._createChartData(),
          isCurved: false,
          colors: widget.gradientColors,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors: widget.gradientColors.map((color) => color.withOpacity(0.3)).toList(),
          ),
        ),
      ],
    );
  }

  LineChartData avgData() {
    return LineChartData(
      // lineTouchData: LineTouchData(enabled: false),
      gridData: FlGridData(
        show: true,
        drawHorizontalLine: true,
        horizontalInterval: this._getMaxValue() / 5,
        verticalInterval: min(5, (widget.labels.length/5).roundToDouble()),
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: TEXT_COLOR_LIGHT.withOpacity(.2),
            strokeWidth: 1,
            dashArray: [8, 10],
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            // color: const Color(0xff37434d),
            color: TEXT_COLOR_LIGHT.withOpacity(.2),
            strokeWidth: 1,
            dashArray: [8, 10],
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          interval: (widget.values.length / 10).floorToDouble(),
          showTitles: true,
          reservedSize: 22,
          textStyle:
              const TextStyle(color: Color(0xff68737d), fontWeight: FontWeight.bold, fontSize: 16),
          // getTitles: (value) {
          //   double average = widget._getAverageValue();
          //   if (value == average) return '${average.toInt()}';
          //   return '';
          // },
          margin: 8,
        ),
        leftTitles: SideTitles(
          interval: widget.interval,
          showTitles: true,
          textStyle: const TextStyle(
            color: Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          reservedSize: 28,
          margin: 12,
          // this is for the average data
          // getTitles: (value) {
          //   switch (value.toInt()) {
          //     case 1:
          //       return '10k';
          //     case 3:
          //       return '30k';
          //     case 5:
          //       return '50k';
          //   }
          //   return '';
          // },
        ),
      ),
      borderData:
          FlBorderData(show: false, border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: this._getMinLabel(),
      // maxX: 11,
      minY: 0,
      maxY: this._getMaxValue() + 10,
      lineBarsData: [
        LineChartBarData(
          spots: this._createAvgChartData(),
          isCurved: true,
          colors: [
            ColorTween(begin: widget.gradientColors[0], end: widget.gradientColors[1]).lerp(0.2),
            ColorTween(begin: widget.gradientColors[0], end: widget.gradientColors[1]).lerp(0.2),
          ],
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(show: true, colors: [
            ColorTween(begin: widget.gradientColors[0], end: widget.gradientColors[1]).lerp(0.2).withOpacity(0.1),
            ColorTween(begin: widget.gradientColors[0], end: widget.gradientColors[1]).lerp(0.2).withOpacity(0.1),
          ]),
        ),
      ],
    );
  }
}