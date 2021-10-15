import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:healthcheckup/models/data_model.dart';
import 'package:healthcheckup/providers/non_invasive_provider.dart';
import 'package:healthcheckup/tabs/invasive_tab.dart';
import 'package:healthcheckup/utils/constants.dart';
import 'package:healthcheckup/widgets/LineChartSample.dart';
import 'package:healthcheckup/widgets/PieChart.dart';
import 'package:healthcheckup/widgets/heart_rate_wight.dart';
import 'package:healthcheckup/widgets/non_invasive_card_widget.dart';
import 'package:healthcheckup/widgets/pie_chart_non_invasive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';
import 'package:csv/csv.dart';

class NonInvasiveTab extends StatefulWidget {

  NonInvasiveTab();

  @override
  _NonInvasiveTabState createState() => _NonInvasiveTabState();
}

class _NonInvasiveTabState extends State<NonInvasiveTab> {
  @override
  Widget build(BuildContext context) {
    return Consumer<NonInvasiveProvider>(builder: (context, provider, child) {
      return Container(
        color: Colors.white,
        margin: EdgeInsets.only(top: 10),
        child: ListView(
          children: [
            SizedBox(
              height: 10,
            ),
            Container(
              height: 15,
              color: Color(0xffF2F3F8),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HeartRateWidgt()));
              },
              child: Container(
                height: 50,
                margin: EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                    color: Colors.grey, borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: Text(
                    "Click here to give us your heart rate",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),

            titleDesign(
                title1: "ACCORDING TO AVERAGE OF SLEEP",
                title2: "Your Mental Health Status",
                predectionValue: provider.sleepprediction),
            Center(
              child: PieChartNonInvasive(
                totalSleep: provider.averageSleepTime != null
                    ? provider.averageSleepTime
                    : 0,
                deepSleep: provider.deepSleepPr,
                wakeSleep: provider.wakeSleepPr,
                remSleep: 1,
                lightSleep: provider.lightSleepPr,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "AVERAGE SLEEP ACTIVITY",
                    style: TextStyle(
                        fontSize: 10,
                        color: aquaDark,
                        fontFamily: "montserrat_semi"),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  sleepDataDesign(
                    title: "Deep Sleep",
                    value: "${formatHHMMSS(provider.averageDeepSleep.toInt())}",
                    color: blue,
                  ),
                  Divider(
                    color: Colors.grey,
                    thickness: 0.2,
                  ),
                  sleepDataDesign(
                    title: "Light Sleep",
                    value: "${formatHHMMSS(provider.averageLightSleep.toInt())}",
                    color: orchid,
                  ),
                  Divider(
                    color: Colors.grey,
                    thickness: 0.2,
                  ),
                  sleepDataDesign(
                    title: "Wake Sleep",
                    value: "${formatHHMMSS(provider.averageWakeSleep.toInt())}",
                    color: aqua,
                  ),
                  Divider(
                    color: Colors.grey,
                    thickness: 0.2,
                  ),
                  sleepDataDesign(
                    title: "Total Sleep Time",
                    value: "${formatHHMMSS(provider.averageSleepTime.toInt())}",
                    color: orange,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
            Container(
              height: 15,
              color: Color(0xffF2F3F8),
            ),
            SizedBox(
              height: 20,
            ),
            titleDesign(
                title1: "ACCORDING TO AVERAGE OF HEART RATE",
                title2: "Your Mental Health Status",
                predectionValue: provider.heartRateprediction),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: LineChartSample2(
                listHeartRate: provider.listHeartRate,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                "AVERAGE SLEEP ACTIVITY",
                style: TextStyle(
                    fontSize: 10, color: aquaDark, fontFamily: "montserrat_semi"),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
              child: sleepDataDesign(
                title: "Heart Rate",
                value: provider.averageHeartRate != null
                    ? "${provider.averageHeartRate.toStringAsFixed(0)}"
                    : "please wait",
                color: orangeLight,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: provider.dataList.length,
              itemBuilder: (context, index) {
                DataModel _data = provider.dataList[index];
                return NonInvasiveCardWidget(data: _data);
              },
            ),
          ],
        ),
      );
    });
  }
}

String formatHHMMSS(int seconds) {
  print("SECONDS: $seconds");
  if (seconds == 0) {
    return "0.0";
  } else if (seconds != null && seconds != 0) {
    int hours = (seconds / 3600).truncate();
    seconds = (seconds % 3600).truncate();
    int minutes = (seconds / 60).truncate();

    String hoursStr = (hours).toString().padLeft(2, '0');
    String minutesStr = (minutes).toString().padLeft(2, '0');
    String secondsStr = (seconds % 60).toString().padLeft(2, '0');

    if (hours == 0) {
      return "00:$minutesStr:$secondsStr";
    }
    return "$hoursStr:$minutesStr:$secondsStr";
  } else {
    return "00:00:00";
  }
}

String formatHH(double seconds) {
  print("SECONDS: formatHH $seconds");

  if (seconds == 0) {
    return "0.0";
  }else if (seconds != null && seconds != 0) {
    int hours = (seconds / 3600).truncate();
    seconds = (seconds % 3600).truncate().toDouble();
    int minutes = (seconds / 60).truncate();

    String hoursStr = (hours).toString().padLeft(2, '0');
    String minutesStr = (minutes).toString().padLeft(2, '0');
    String secondsStr = (seconds % 60).toString().padLeft(2, '0');

    if (hours == 0) {
      return "0.$minutesStr";
    }
    return "$hoursStr";
  } else {
    return "0";
  }
}
