import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:healthcheckup/global_methods.dart';
import 'package:healthcheckup/models/data_model.dart';
import 'package:healthcheckup/providers/data_provider.dart';
import 'package:healthcheckup/utils/constants.dart';
import 'package:healthcheckup/widgets/LineChartSample.dart';
import 'package:healthcheckup/widgets/PieChart.dart';
import 'package:healthcheckup/widgets/invasive_card_widget.dart';
import 'package:provider/provider.dart';

class InvasiveTab extends StatefulWidget {

  InvasiveTab();

  @override
  _InvasiveTabState createState() => _InvasiveTabState();
}

class _InvasiveTabState extends State<InvasiveTab> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF2F3F8),
      body: Consumer<DataProvider>(builder: (_, vlue, __) {
        return Container(
          color: Colors.white,
          margin: EdgeInsets.only(top: 10),
          child: ListView(
            children: [
              SizedBox(
                height: 20,
              ),
              titleDesign(
                  title1: "ACCORDING TO AVERAGE OF SLEEP",
                  title2: "Your Mental Health Status",
                  predectionValue: vlue.sleepprediction),
              Center(
                child: PieChartSample(
                  totalSleep: vlue.avgTotalSleepTime != null?vlue.avgTotalSleepTime.inHours:0,
                  deepSleep: vlue.deepSleepPr,
                  wakeSleep: vlue.wakeSleepPr,
                  remSleep: vlue.remSleepPr,
                  lightSleep: vlue.lightSleepPr,
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
                      value: timeFormate(vlue.avgDeep),
                      color: blue,
                    ),
                    Divider(
                      color: Colors.grey,
                      thickness: 0.2,
                    ),
                    sleepDataDesign(
                      title: "Light Sleep",
                      value: timeFormate(vlue.avgLight),
                      color: orchid,
                    ),
                    Divider(
                      color: Colors.grey,
                      thickness: 0.2,
                    ),
                    sleepDataDesign(
                      title: "Wake Sleep",
                      value: timeFormate(vlue.avgWake),
                      color: aqua,
                    ),
                    Divider(
                      color: Colors.grey,
                      thickness: 0.2,
                    ),
                    sleepDataDesign(
                      title: "Rem Sleep",
                      value: timeFormate(vlue.avgRem),
                      color: green,
                    ),
                    Divider(
                      color: Colors.grey,
                      thickness: 0.2,
                    ),
                    sleepDataDesign(
                      title: "Total Bed Time",
                      value: timeFormate(vlue.avgTotalBedTime),
                      color: yellow,
                    ),
                    Divider(
                      color: Colors.grey,
                      thickness: 0.2,
                    ),
                    sleepDataDesign(
                      title: "Total Sleep Time",
                      value: timeFormate(vlue.avgTotalSleepTime),
                      color: orange,
                    ),
                    SizedBox(
                      height: 15,
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
                  predectionValue: vlue.heartRateprediction),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: LineChartSample2(listHeartRate:vlue.listHeartRate,),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  "AVERAGE SLEEP ACTIVITY",
                  style: TextStyle(
                      fontSize: 10,
                      color: aquaDark,
                      fontFamily: "montserrat_semi"),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
                child: sleepDataDesign(
                  title: "Heart Rate",
                  value: vlue.avgHeartRate != null
                      ? "${vlue.avgHeartRate.toStringAsFixed(0)}"
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
                itemCount: vlue.dataList.length,
                itemBuilder: (context, index) {
                  DataModel _data = vlue.dataList[index];
                  return InvasiveCardWidget(data: _data);
                },
              ),
              Container(
                height: 15,
                color: Color(0xffF2F3F8),
              ),
            ],
          ),
        );
      }),
    );
  }
}


Widget titleDesign({title1, title2, predectionValue}) {
  return Column(
    children: [
      Center(
        child: Text(
          title1,
          style: TextStyle(
              fontSize: 10, color: aquaDark, fontFamily: "montserrat_semi"),
        ),
      ),
      SizedBox(
        height: 5,
      ),
      Center(
        child: Text(
          title2,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 18,
              color: Colors.black,
              fontFamily: "montserrat_regular",
              fontWeight: FontWeight.w500),
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Is ",
            style: TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontFamily: "montserrat_regular",
                fontWeight: FontWeight.w500),
          ),
          Text(
            predectionValue,
            style: TextStyle(
                fontSize: 18,
                color: aquaDark,
                fontFamily: "montserrat_regular",
                fontWeight: FontWeight.w500),
          ),
        ],
      ),
    ],
  );
}

Widget sleepDataDesign({title, value, color}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      roundContanner(color: color),
      Text(title, style: textStyle1,textAlign: TextAlign.start,),
      Text(
        "$value",
        style: textStyle1,
      ),
    ],
  );
}
