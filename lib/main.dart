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

class DataModel {
  late double x;

  DataModel.fromSensor(double sensorx) {
    x = sensorx;
  }
}

class ModelData {
  late double b;

  ModelData.fromSensor(double sensorb) {
    b = sensorb;
  }
}

class DataService {
  static DataModel firstData = DataModel.fromSensor(0);
}

class ServiceData {
  static ModelData lastData = ModelData.fromSensor(0);
}

class _MyAppState extends State<MyApp> {
  Vector3 _accelerometer = Vector3.zero();
  double eq = 0;

//  late Timer _timer;
  List<DataModel> myList1 = [];

  List<ModelData> myList2 = [];

  void girisDegeri() async {
    setState(() {
      motionSensors.accelerometer.listen((AccelerometerEvent event) async {
        _accelerometer.setValues(event.x, event.y, event.z);
        DataService.firstData.x = event.x;
        print("ilk Veri: " + DataService.firstData.x.toString());
        myList1.add(DataService.firstData);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    // girisDegeri();
    //  cikisDegeri();
    // Hesaplama();
    Timer.periodic(Duration(seconds: 11), (timer) => girisDegeri());
    Timer.periodic(Duration(seconds: 23), (timer) => cikisDegeri());
    Timer.periodic(Duration(seconds: 25), (timer) => Hesaplama());
    motionSensors.accelerometer.listen((AccelerometerEvent event) {
      _accelerometer.setValues(event.x, event.y, event.z);
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
                      Text("ilk Veri: " + DataService.firstData.x.toString()),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("Son Veri: " + ServiceData.lastData.b.toString()),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("Sonuc: " + eq.toString()),
                    ],
                  ),

                  // accelerometer buradan okunuyor
                ],
              ),
            )),
      ),
    );
  }

  void cikisDegeri() async {
    setState(() {
      motionSensors.accelerometer.listen((AccelerometerEvent event) async {
        _accelerometer.setValues(event.x, event.y, event.z);
        ServiceData.lastData.b = event.x;
        print("Son Veri: " + ServiceData.lastData.b.toString());
        myList2.add(ServiceData.lastData);
      });
    });
  }

  void Hesaplama() {
    eq = ServiceData.lastData.b - DataService.firstData.x;
    print("Sonuc Değeri:" + eq.toStringAsFixed(2));
  }
}
