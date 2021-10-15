import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:healthcheckup/components/Indicator.dart';
import 'package:healthcheckup/tabs/non_invasive_tab.dart';
import 'package:healthcheckup/utils/constants.dart';

class PieChartNonInvasive extends StatefulWidget {
  double totalSleep = 0;
  double lightSleep = 0;
  double deepSleep = 0;
  double remSleep = 0;
  double wakeSleep = 0;

  PieChartNonInvasive(
      {this.totalSleep,
      this.lightSleep,
      this.deepSleep,
      this.remSleep,
      this.wakeSleep});

  @override
  State<StatefulWidget> createState() => PieChart2State();
}

class PieChart2State extends State<PieChartNonInvasive> {
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
                widget.deepSleep != 0 && widget.lightSleep !=0?"${formatHH(widget.totalSleep)} Hrs":"Empty Data",
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
                  child: widget.deepSleep != 0 && widget.lightSleep !=0? PieChart(
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
    return List.generate(2, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: blue,
            value: widget.deepSleep,
            title: '${widget.deepSleep.round()}%',
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
            title: '${widget.lightSleep.round()}%',
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
