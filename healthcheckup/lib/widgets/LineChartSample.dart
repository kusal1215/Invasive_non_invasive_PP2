import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineChartSample2 extends StatefulWidget {

  final List<int> listHeartRate;
  LineChartSample2({this.listHeartRate});

  @override
  _LineChartSample2State createState() => _LineChartSample2State();
}

class _LineChartSample2State extends State<LineChartSample2> {
  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  bool showAvg = false;


  List<FlSpot> getPoint(){
    print("LENGTH: ${widget.listHeartRate.length}");
    List<FlSpot> points = new List();

    if(widget.listHeartRate.length >1) {
      for (int i = 0; i < widget.listHeartRate.length; i++) {
        print("LENGTH: ${widget.listHeartRate[i]}");

        points.add(FlSpot(i.toDouble(), widget.listHeartRate[i].toDouble()));
      }
    }else if(widget.listHeartRate.length ==1){
      points.add(FlSpot(0, widget.listHeartRate[0].toDouble()));
      points.add(FlSpot(1, 0));
      points.add(FlSpot(2,0));
      points.add(FlSpot(3, 0));
      points.add(FlSpot(4, 0));
      points.add(FlSpot(5,0));
      points.add(FlSpot(6, 0));

    }

    return points;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 190,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(18),
        ),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 24, bottom: 12),
        child: LineChart(
          mainData(),
        ),
      ),
    );
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,

        drawHorizontalLine: false,
        drawVerticalLine: false,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: Colors.white,
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: Colors.white,
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: false,
        rightTitles: SideTitles(showTitles: false),
        topTitles: SideTitles(showTitles: false),
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          interval: 1,
          getTextStyles: (context, value) => const TextStyle(
              color: Color(0xff68737d),
              fontWeight: FontWeight.bold,
              fontSize: 16),
          getTitles: (value) {
            switch (value.toInt()) {
              case 2:
                return '';
              case 5:
                return '';
              case 8:
                return '';
            }
            return '';
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          interval: 1,
          getTextStyles: (context, value) => const TextStyle(
            color: Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return '';
              case 3:
                return '';
              case 5:
                return '';
            }
            return '';
          },
          reservedSize: 32,

        ),
      ),
      borderData: FlBorderData(
          show: true, border: Border.all(color: Colors.white, width: 1)),

      lineBarsData: [
        LineChartBarData(
          spots: getPoint(),
          isCurved: true,
          colors: gradientColors,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors: gradientColors.map((color) => color.withOpacity(0.3)).toList(),
          ),
        ),
      ],
    );
  }
}
