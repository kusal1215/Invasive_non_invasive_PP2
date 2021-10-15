
import 'package:flutter/material.dart';
import 'package:healthcheckup/models/data_model.dart';
import 'package:healthcheckup/tabs/invasive_tab.dart';
import 'package:healthcheckup/tabs/non_invasive_tab.dart';
import 'package:healthcheckup/utils/constants.dart';

class NonInvasiveCardWidget extends StatelessWidget {

  DataModel data;
  NonInvasiveCardWidget({this.data});
  
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
                value: "${data.averageHeartRate}",
                color: orangeLight,
              ),

              Divider(
                color: Colors.grey,
                thickness: 0.2,
              ),

              sleepDataDesign(
                title: "Deep Sleep",
                value: convertStringToInt(data.totalDeepSleep),
                color: blue,
              ),
              Divider(
                color: Colors.grey,
                thickness: 0.2,
              ),
              sleepDataDesign(
                title: "Light Sleep",
                value: convertStringToInt(data.totalLightSleep),
                color: orchid,
              ),
              Divider(
                color: Colors.grey,
                thickness: 0.2,
              ),
              sleepDataDesign(
                title: "Wake Sleep",
                value: "${convertStringToInt(data.totalWakeSleep)}",
                color: aqua,
              ),
              Divider(
                color: Colors.grey,
                thickness: 0.2,
              ),
              sleepDataDesign(
                title: "Total Sleep Time",
                value: "${convertStringToInt(data.totalSleepTime)}",
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
        ),
      ],
    );
  }
}


String convertStringToInt(String value){

  if(value.isNotEmpty && value != "0.00"){
    return formatHHMMSS(double.parse(value).toInt());
  }else{
    return "0.0";
  }

}