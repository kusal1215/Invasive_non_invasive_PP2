import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

var heartRateUrl = "https://apiheartrateinvasive.herokuapp.com/predict";
var sleepPredictUrl = "https://apisleepinvasive.herokuapp.com/predict";
var accelerometerUrl = "https://accelerometer-to-sleep-api.herokuapp.com/upload?";

var blue = Color(0XFF1683FA);
var orchid = Color(0XFFAE8EFD);
var aqua = Color(0XFF7DE2ED);
var green = Color(0XFF44D63F);
var yellow = Color(0XFFFED363);
var orange = Color(0XFFFE8863);

var aquaDark = Color(0XFF8A7FF6);

var orangeLight = Color(0XFFFE6363);

var blueLight = Color(0XFF5A72FF);


var textStyle1 = TextStyle(color: Colors.black,fontSize: 11);

Widget roundContanner({Color color}){
  return  Container(
    width: 17,
    height: 17,
    decoration: BoxDecoration(
      color:color,
      borderRadius: BorderRadius.circular(5),
    ),
  );
}

var startDate = new DateTime.now();

String getDate() {
  return startDate.toString().split(" ").first;
}

int getTimeStamp() {
  return DateTime(startDate.year, startDate.month, startDate.day, 00, 00, 00)
      .millisecondsSinceEpoch;
}

DateTime get newDate =>
    DateTime(startDate.year, startDate.month, startDate.day, 00, 00, 00)
        .subtract(Duration(days: 13));

DateTime get strtDate =>
    DateTime(startDate.year, startDate.month, startDate.day, 00, 01, 00);

DateTime get endDate =>
    DateTime(startDate.year, startDate.month, startDate.day, 12, 00, 00);

Future<String> getPath() async {
  String fileName = DateFormat('yyyy-MM-dd').format(DateTime.now());

  final String directory = (await getExternalStorageDirectory()).path;
  return "$directory/$fileName.csv";
}

bool isCurrentDateInRange(DateTime startDate, DateTime endDate) {
  final currentDate = DateTime.now();
  return currentDate.isAfter(startDate) && currentDate.isBefore(endDate);
}