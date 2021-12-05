import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:motion_sensors/motion_sensors.dart';
import 'DataModel.dart';
import 'DataService.dart';
import 'package:vector_math/vector_math_64.dart' hide Colors;
import 'dart:core';

class CikisDegeri extends StatefulWidget{
  @override
  _CikisDegeriState createState() => _CikisDegeriState();

}

class _CikisDegeriState extends State<CikisDegeri> {
   Vector3 _accelerometer = Vector3.zero();

   static List<DataModel> myList2 =
   List.generate(1, (index) => DataModel.fromSensor(1));
  @override
  Widget build(BuildContext context) {
    return   Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text("Son Veri: " + DataService.lastData.x.toString()),
      ],
    );
  }
   void cikisDegeri() async{
     Timer.periodic(Duration(seconds: 11), (timer) {
       motionSensors.accelerometer.listen((AccelerometerEvent event) {
         _accelerometer.setValues(event.x, event.y, event.z);
         DataService.lastData.x =  event.x ;

       });
       setState(() {
         print("Son Veri: " + DataService.lastData.x.toString());
         myList2.add(DataModel.fromSensor(1));
       });
     });
  }
}


