import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:healthcheckup/components/Indicator.dart';
import 'package:healthcheckup/utils/constants.dart';




class PieChartSample extends StatefulWidget {

   final int totalSleep;
  final double lightSleep;
  final double deepSleep;
  final double remSleep;
  final double wakeSleep;


  PieChartSample({this.totalSleep,this.lightSleep,this.deepSleep,this.remSleep,this.wakeSleep});

  @override
  State<StatefulWidget> createState() => PieChart2State();
}

class PieChart2State extends State<PieChartSample>  {
  int touchedIndex = -1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.3,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              "${widget.totalSleep} Hrs",
              textAlign: TextAlign.center,
              style: TextStyle(fontFamily: "montserrat_semi", fontSize: 20),
            ),
          ),
          Row(
            children: <Widget>[
              const SizedBox(
                height: 18,
              ),
              Expanded(
                child: AspectRatio(
                  aspectRatio: 1,
                  child: widget.deepSleep != 0 && widget.lightSleep !=0?  PieChart(
                    PieChartData(
                        pieTouchData: PieTouchData(touchCallback:
                            (FlTouchEvent event, pieTouchResponse) {
                          setState(() {
                            if (!event.isInterestedForInteractions ||
                                pieTouchResponse == null ||
                                pieTouchResponse.touchedSection == null) {
                              touchedIndex = -1;
                              return;
                            }
                            touchedIndex = pieTouchResponse
                                .touchedSection.touchedSectionIndex;
                          });
                        }),
                        borderData: FlBorderData(
                          show: false,
                        ),
                        sectionsSpace: 0,
                        centerSpaceRadius: 60,
                        sections: showingSections()),
                  ):Container(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(4, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: blue,
            value: widget.deepSleep,
            title: '${widget.deepSleep.toInt()}%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 1:
          return PieChartSectionData(
            color: orchid,
            value: widget.lightSleep,
            title: '${widget.lightSleep.toInt()}%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 2:
          return PieChartSectionData(
            color: green,
            value: widget.remSleep,
            title: '${widget.remSleep.toInt()}%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 3:
          return PieChartSectionData(
            color: aqua,
            value: widget.wakeSleep,
            title: '${widget.wakeSleep.toInt()}%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        default:
          throw Error();
      }
    });
  }
}