
import 'package:flutter/material.dart';
import 'package:healthcheckup/models/data_model.dart';
import 'package:healthcheckup/tabs/invasive_tab.dart';
import 'package:healthcheckup/utils/constants.dart';

class InvasiveCardWidget extends StatelessWidget {

  DataModel data;
  InvasiveCardWidget({this.data});
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 15,
          color: Color(0xffF2F3F8),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          width: double.infinity,
          color: Color(0xfff0eefc),
          child: Text(
            data.date,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, color:orchid),
          ),
        ),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20,vertical: 6),
          child: Column(
            children: [
              SizedBox(
                height: 5,
              ),
              sleepDataDesign(
                title: "Heart Rate",
                value: "${data.averageHeartRate}         ",
                color: orangeLight,
              ),

              Divider(
                color: Colors.grey,
                thickness: 0.2,
              ),

              sleepDataDesign(
                title: "Deep Sleep",
                value: data.totalDeepSleep,
                color: blue,
              ),
              Divider(
                color: Colors.grey,
                thickness: 0.2,
              ),
              sleepDataDesign(
                title: "Light Sleep",
                value: data.totalLightSleep,
                color: orchid,
              ),
              Divider(
                color: Colors.grey,
                thickness: 0.2,
              ),
              sleepDataDesign(
                title: "Wake Sleep",
                value: data.totalWakeSleep,
                color: aqua,
              ),
              Divider(
                color: Colors.grey,
                thickness: 0.2,
              ),
              sleepDataDesign(
                title: "Rem Sleep",
                value: data.totalRemSleep,
                color: green,
              ),
              Divider(
                color: Colors.grey,
                thickness: 0.2,
              ),
              sleepDataDesign(
                title:"Total Bed Time",
                value: data.totalBedTime,
                color: yellow,
              ),
              Divider(
                color: Colors.grey,
                thickness: 0.2,
              ),
              sleepDataDesign(
                title: "Total Sleep Time",
                value: data.totalSleepTime,
                color: orange,
              ),
              Divider(
                color: Colors.grey,
                thickness: 0.2,
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        )
      ],
    );
  }
}
