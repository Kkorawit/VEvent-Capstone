// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:pedometer/pedometer.dart';
String formatDate(DateTime d) {
  return d.toString().substring(0, 19);
}

class StepsCounter extends StatefulWidget {
  const StepsCounter({super.key});

  @override
  State<StepsCounter> createState() => _StepsCounter();
}

class _StepsCounter extends State<StepsCounter> {
  // มีตัวแปร _stepCountStream และ _pedestrianStatusStream เพื่อรับ Stream ของข้อมูลการนับก้าวและสถานะการเดิน
  late Stream<StepCount> _stepCountStream;
  late Stream<PedestrianStatus> _pedestrianStatusStream;
  // เพื่อเก็บข้อมูลสถานะการเดินและจำนวนก้
  String _status = '?';
  String _steps = '?';

  @override
  void initState() {
    super.initState();
    // เรียก initPlatformState() เพื่อเริ่มต้นรับ Stream ข้อมูลการนับก้าวและสถานะการเดิน
    initPlatformState();
  }
//  เพื่ออัปเดตข้อมูลการนับก้าว
  void onStepCount(StepCount event) {
     debugPrint(event.toString());
    setState(() {
      _steps = event.steps.toString();
    });
  }
//  เพื่ออัปเดตข้อมูลสถานะการเดิน
  void onPedestrianStatusChanged(PedestrianStatus event) {
    debugPrint(event.toString());
    setState(() {
      _status = event.status;
    });
  }
// เพื่อจัดการข้อผิดพลาดที่เกิดขึ้นในการรับข้อมูลเกี่ยวกับสถานะการเดิน
  void onPedestrianStatusError(error) {
     debugPrint('onPedestrianStatusError: $error');
    setState(() {
      _status = 'Pedestrian Status not available';
    });
    debugPrint(_status);
  }
// เพื่อจัดการข้อผิดพลาดที่เกิดขึ้นในการรับข้อมูลเกี่ยวกับการนับก้าว
  void onStepCountError(error) {
     debugPrint('onStepCountError: $error');
    setState(() {
      _steps = 'Step Count not available';
    });
  }
// เพื่อเริ่มต้นการรับ Stream ข้อมูล
  void initPlatformState() {
    // _pedestrianStatusStream ถูกกำหนดให้เป็น Stream ของข้อมูลสถานะการเดินที่ได้จากเซ็นเซอร์ของอุปกรณ์ โดยใช้ Pedometer.pedestrianStatusStream เป็นแหล่งข้อมูล
    _pedestrianStatusStream = Pedometer.pedestrianStatusStream;
    // เมื่อมีการอัปเดตข้อมูลใหม่เข้ามา จะทำการเรียกใช้ onPedestrianStatusChanged เพื่อปรับปรุงสถานะการเดิน
    // ใช้ .onError(onPedestrianStatusError) เพื่อจัดการข้อผิดพลาดที่เกิดขึ้นในการรับข้อมูล
    _pedestrianStatusStream
        .listen(onPedestrianStatusChanged)
        .onError(onPedestrianStatusError);
    // เป็น Stream ของข้อมูลจำนวนก้าวที่ได้จากเซ็นเซอร์ของอุปกรณ์ โดยใช้ Pedometer.stepCountStream เป็นแหล่งข้อมูล
    _stepCountStream = Pedometer.stepCountStream;
    // เมื่อมีการอัปเดตข้อมูลใหม่เข้ามา จะทำการเรียกใช้ onStepCount เพื่อปรับปรุงจำนวนก้าว
    // ใช้ .onError(onStepCountError) เพื่อจัดการข้อผิดพลาดที่เกิดขึ้นในการรับข้อมูล
    _stepCountStream.listen(onStepCount).onError(onStepCountError);
    // ตรวจสอบว่า State ของ Widget ยังไม่ถูก mounted หรือไม่ หากยังไม่ถูก mounted จะไม่ดำเนินการต่อเพื่อป้องกันการเกิดข้อผิดพลาดที่อาจเกิดขึ้นในกรณีที่ Widget ยังไม่พร้อมใช้งาน
    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    // ใช้ StreamBuilder เพื่อแสดงข้อมูลการนับก้าวและสถานะการเดินที่ได้รับจาก Stream ของ _stepCountStream และ _pedestrianStatusStream
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Steps Counter",
          style: const TextStyle(fontSize: 24),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Steps Token",
              style: TextStyle(fontSize: 30),
            ),
            SizedBox(
              height: 24,
            ),
            Text(
              _steps,
              style: TextStyle(fontSize: 20, color: Colors.red, fontWeight: FontWeight.bold),
            ),
            Divider(
              height: 100,
              thickness: 0,
              color: Colors.white,
            ),
            Text(
              'Pedestrian Status',
              style: TextStyle(fontSize: 30),
            ),
            Icon(
              _status == 'walking'
                  ? Icons.directions_walk
                  : _status == 'stopped'
                      ? Icons.accessibility_new
                      : Icons.error,
              size: 100,
            ),
            Center(
              child: Text(
                _status,
                style: _status == 'walking' || _status == 'stopped'
                    ? TextStyle(fontSize: 30)
                    : TextStyle(fontSize: 20, color: Colors.red),
              ),
            )
          ],
        ),
      ),
    );
  }
}
