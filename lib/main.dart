import 'dart:async';
import 'dart:core';

import 'package:flutter/material.dart';

import 'package:vector_math/vector_math_64.dart' hide Colors;
import 'package:motion_sensors/motion_sensors.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class ilkveri {
  late double ilkx;

  ilkveri.fromSensor(double sensorx) {
    ilkx = sensorx;
  }
}

class _MyAppState extends State<MyApp> {
  Vector3 _accelerometer = Vector3.zero();
  late Timer _timer;
  int? _groupValue = 0;
  List<ilkveri> mylist = [];

  void girisDegeri() async {
    await Future.delayed((Duration(seconds: 5))).then((value) {
      motionSensors.accelerometer.listen((AccelerometerEvent event) {
        setState(() {
          _accelerometer.setValues(event.x, event.y, event.z);
          //mylist[0].ilkx;
        });
        double sensorData = 9.9;
        sensorData = event.x;
        mylist.add(ilkveri.fromSensor(sensorData));
        print("ilk x Değeri: ${mylist[0].ilkx}");
      });
    });
  }

  void cikisDegeri() async {
    await Future.delayed((Duration(seconds: 10))).then((value) {
      motionSensors.accelerometer.listen((AccelerometerEvent event) {
        setState(() {
          _accelerometer.setValues(event.x, event.y, event.z);
          //  mylist[1].ilkx;
        });
        double lastData = 10.5;
        lastData = event.x;
        mylist.add(ilkveri.fromSensor(lastData));
        print("Son x Değeri: ${mylist[1].ilkx}");
      });
    });
  }





  @override
  void initState() {
    super.initState();
    girisDegeri();
    cikisDegeri();

    motionSensors.accelerometer.listen((AccelerometerEvent event) {
      setState(() {
        _accelerometer.setValues(event.x, event.y, event.z);
      });
    });
  }

  void setUpdateInterval(int? groupValue, int interval) {
    motionSensors.accelerometerUpdateInterval = interval;

    setState(() {
      _groupValue = groupValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Builder(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: const Text('İvmelenme Durumu'),
          ),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Update Interval'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Radio(
                      value: 1,
                      groupValue: _groupValue,
                      onChanged: (dynamic value) => setUpdateInterval(
                          value, Duration.microsecondsPerSecond ~/ 1),
                    ),
                    Text("1 FPS"),
                    Radio(
                      value: 2,
                      groupValue: _groupValue,
                      onChanged: (dynamic value) => setUpdateInterval(
                          value, Duration.microsecondsPerSecond ~/ 30),
                    ),
                    Text("30 FPS"),
                    Radio(
                      value: 3,
                      groupValue: _groupValue,
                      onChanged: (dynamic value) => setUpdateInterval(
                          value, Duration.microsecondsPerSecond ~/ 60),
                    ),
                    Text("60 FPS"),
                  ],
                ),
                Text('Accelerometer '),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text('${_accelerometer.x.toStringAsFixed(2)}'),
                    Text('${_accelerometer.y.toStringAsFixed(2)}'),
                    Text('${_accelerometer.z.toStringAsFixed(2)}'),
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("${mylist[0].ilkx.toStringAsFixed(2)}"),
                    Text("${mylist[1].ilkx.toStringAsFixed(2)}"),
                  ],
                ),
                // accelerometer buradan okunuyor
              ],
            ),
          )
          ),
        ),
      );

  }
}
