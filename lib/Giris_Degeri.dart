import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:motion_sensors/motion_sensors.dart';
import 'DataModel.dart';
import 'DataService.dart';
import 'package:vector_math/vector_math_64.dart' hide Colors;
import 'dart:core';

class GirisDegeri extends StatefulWidget {
  @override
  _GirisDegeriState createState() => _GirisDegeriState();
}

class _GirisDegeriState extends State<GirisDegeri> {
   Vector3 _accelerometer = Vector3.zero();

   static List<DataModel> myList1 =
   List.generate(1, (index) => DataModel.fromSensor(0));

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text("ilk Veri: " + DataService.firstData.x.toString()),
      ],
    );
  }

  void girisDegeri() {
    Timer.periodic(Duration(seconds: 3), (timer) {
      motionSensors.accelerometer.listen((AccelerometerEvent event) {
        _accelerometer.setValues(event.x, event.y, event.z);
        DataService.firstData.x = event.x;
      });
      setState(() {
        print("ilk Veri: " + DataService.firstData.x.toString());
        myList1.add(DataModel.fromSensor(0));
      });
    });
  }
}
