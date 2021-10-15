import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:csv/csv.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:healthcheckup/models/data_model.dart';
import 'package:healthcheckup/models/data_response.dart';
import 'package:healthcheckup/models/sensor_model.dart';
import 'package:healthcheckup/utils/constants.dart';
import 'package:healthcheckup/utils/db_helper.dart';
import 'package:healthcheckup/utils/global_methods.dart';
import 'package:intl/intl.dart';
import 'package:sensors/sensors.dart';

class NonInvasiveProvider extends ChangeNotifier {
  List<DataModel> dataList = [];
  List<List<dynamic>> dataITems = [];
  ReceivePort _port = ReceivePort();

  FirebaseDatabase database;
  DatabaseReference _databaseReference;

  double averageHeartRate = 0;
  double totalHeartRate = 0;
  double totalDeepSleep = 0;
  double totalLightSleep = 0;
  double totalWakeSleep = 0;
  double totalSleepTime = 0;

  double averageDeepSleep = 0;
  double averageLightSleep = 0;
  double averageSleepTime = 0;
  double averageWakeSleep = 0;

  String heartRateprediction = "please wait";
  String sleepprediction = "please wait";

  bool updateValueStatues = true;

  double deepSleepPr=0;
  double lightSleepPr=0;
  double wakeSleepPr=0;

  List<int> listHeartRate=  new List();

  void initializeProvider(FirebaseApp app) {
    database = FirebaseDatabase(app: app);

    String uId = FirebaseAuth.instance.currentUser.uid;
    _databaseReference = database.reference().child('Non_Invasive').child(uId);
  }

  void addHeartRate(double heartRate) {
    String date = getDate();
    int timeStamp = getTimeStamp();
    _databaseReference.child(date).update(<String, dynamic>{
      "heartRate": heartRate,
      "timeStamp": timeStamp,
      "date": date,
    });

    getData();
  }

  void getData() async {
    print("VALUE:  getData");

    _databaseReference
        .orderByChild("timeStamp")
        .startAt(newDate.millisecondsSinceEpoch)
        .onValue
        .listen((event) async {
      Map<dynamic, dynamic> values = event.snapshot.value;

      if (values != null) {
        print("VALUE: $values");
        dataList.clear();
        listHeartRate.clear();

        totalHeartRate = 0;
        averageHeartRate = 0;
        totalDeepSleep = 0;
        totalLightSleep = 0;
        totalWakeSleep = 0;
        totalSleepTime = 0;

        values.forEach((key, value) async {
          double heartRate = 0;

          if (value["heartRate"] != null && value["heartRate"] !="NaN") {

            heartRate = value["heartRate"];
            totalHeartRate = totalHeartRate + heartRate;
            listHeartRate.add(heartRate.toInt());

          }else
            listHeartRate.add(0);

          print("HREAT NON INVASIVE : ${heartRate}");


          if (value["total_accelerometer_recoding"] != null) {

            dynamic dpSleep = value["deep_sleep_time"] != "NaN"?value["deep_sleep_time"]:0.0;
            dynamic norSleep = value["normal_sleep_time"] != "NaN"?value["normal_sleep_time"]:0.0;
            dynamic wakeSleep = value["wake_time"] != "NaN"?value["wake_time"]:0.0;
            dynamic totalSlp = value["total_sleep_time"] != "NaN"?value["total_sleep_time"]:0.0;

            print("DEEP: ${dpSleep}");
            print("DEEP: ${norSleep}");
            print("WAKE: ${wakeSleep}");
            print("WAKE: ${totalSlp}");

            totalDeepSleep = totalDeepSleep + dpSleep;
            totalLightSleep = totalLightSleep + norSleep;
            totalWakeSleep = totalWakeSleep +wakeSleep;
            totalSleepTime = totalSleepTime + totalSlp;

            dataList.add(DataModel(
                averageHeartRate: heartRate.toString(),
                totalDeepSleep: dpSleep.toStringAsFixed(2),
                totalLightSleep: norSleep.toStringAsFixed(2),
                totalWakeSleep: wakeSleep.toStringAsFixed(2),
                totalSleepTime: totalSlp.toStringAsFixed(2),
                date: value["date"].toString(),
                timestamp: value["timestamp"]));
          } else {
            dataList.add(DataModel(
                averageHeartRate: heartRate.toString(),
                totalDeepSleep: "0.0",
                totalLightSleep: "0.0",
                totalWakeSleep: "0.0",
                totalSleepTime: "0.0",
                date: value["date"].toString(),
                timestamp: value["timestamp"]));
          }
        });

        print(" NON INVASIVE : ${dataList.length}");

         averageHeartRate = totalHeartRate / values.length;
         averageDeepSleep = totalDeepSleep / values.length;
         averageLightSleep = totalLightSleep / values.length;
         averageSleepTime = totalSleepTime / values.length;
         averageWakeSleep = totalWakeSleep / values.length;

        double totalSlep = averageSleepTime;

        if(totalSlep != 0){
          deepSleepPr = (averageDeepSleep/totalSlep)*100;
          lightSleepPr = (averageLightSleep/totalSlep)*100;
          wakeSleepPr = (averageWakeSleep/totalSlep)*100;

        }


        print("SLEEP: total ${totalSlep} ");
        print("SLEEP: deep ${deepSleepPr} ");
        print("SLEEP: light  ${lightSleepPr} ");
        print("SLEEP: wake ${wakeSleepPr} ");


        heartRateprediction = await getPredictOnHeartRate(averageHeartRate);
        sleepprediction = await getSleepDataPredictionCSV(
            averageSleepTime.toInt(),
            averageDeepSleep.toInt(),
            0,
            averageLightSleep.toInt());

        notifyListeners();
      } else {
        heartRateprediction = "DATA EMPTY";
      }
    });
  }

  void checkFileExists() async {
    String path = await getPath();
    bool isExist = await File(path).exists();
    if (isExist)
      updateValues();
    else
      convertData();
  }

  convertData() async {

  }

  void updateValues() async {

    List<SensorModel> values = await DbHelper.dbHelper.getProductList();
    print("DATA: values local ${values}");

    if(values != null){
      for (var element in values) {
        var item = [
          element.date,
          element.x,
          element.y,
          element.z,
        ];
        dataITems.add(item);
      }
      generateCsv();
    }
  }

  // void updateValue() {
  //   updateValueStatues =false;
  //   notifyListeners();
  //   Future.delayed(const Duration(minutes: 1), () {
  //     generateCsv();
  //   });
  // }

  generateCsv() async {
    String csvData = ListToCsvConverter().convert(dataITems);
    final path = await getPath();
    print(path);
    final File file = File(path);
    await file.writeAsString(csvData);
    DataResponse response = await getSleepDataFromCSV(file.path);


    if (response != null)
      await addSleepData(response);

    updateValueStatues =true;
    notifyListeners();
  }

  Future<void> addSleepData(DataResponse data) async {
    String date = getDate();
    int timeStamp = getTimeStamp();
    print("DATA::: ${data.totalAccelerometerRecoding}");
    print("DATA::: ${date}");

    await _databaseReference.child(date).update(<String, dynamic>{
      "timeStamp": timeStamp,
      "date": date,
    });
    await _databaseReference.child(date).update(data.toJson());

    getData();
  }

  Future<List<List<dynamic>>> loadingCsvData(String path) async {
    final csvFile = new File(path).openRead();
    return await csvFile
        .transform(utf8.decoder)
        .transform(
          CsvToListConverter(),
        )
        .toList();
  }
}
