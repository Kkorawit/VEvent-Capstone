import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:vevent_flutter/models/app_environment.dart';

class QRCodePage extends StatefulWidget {
  late String qrData;
  final String qrStart;
  final String eventId;
  final int duration;
  late String currentDateTime;
  late int countdownMinutes = duration;
  late int countdownSecond = 0;

  QRCodePage({
    super.key,
    required this.qrStart,
    required this.eventId,
    required this.duration,
  });

  @override
  State<QRCodePage> createState() => _QRCodePageState();
}

class _QRCodePageState extends State<QRCodePage> {
  late Timer timer;
  late bool isPaused = false;

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // ทำให้ StatusBar เป็นสีที่透ทน
    ));
    widget.qrData ="${widget.qrStart};${widget.eventId};${widget.duration}";
    startTimer();
  }

  void startTimer() {
    const oneSecond = Duration(seconds: 1);
    timer = Timer.periodic(oneSecond, (timer) {
      setState(() {
        if (widget.countdownMinutes == 0 && widget.countdownSecond == 0) {
          timer.cancel();
        } else if (widget.countdownSecond == 0) {
          widget.countdownMinutes--;
          widget.countdownSecond = 59;
        } else {
          widget.countdownSecond--;
        }
      });
    });
  }

  // void pauseResumeTimer() {
  //   if (isPaused) {
  //     startTimer();
  //   } else {
  //     timer.cancel();
  //   }
  //   setState(() {
  //     isPaused = !isPaused;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Event QR code",
          style: TextStyle(color: Color.fromARGB(100, 22, 22, 22)),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          Container(
              // padding: EdgeInsets.all(8),
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FloatingActionButton(
              backgroundColor: Color.fromARGB(100, 69, 32, 204),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10), // กำหนดความโค้ง
              ),
              mini: true, // กำหนดให้เป็น Mini FloatingActionButton
              heroTag:
                  null, // กำหนดให้ heroTag เป็น null เพื่อป้องกันความขัดแย้ง
              child: Icon(Icons.close),
              onPressed: () {
                _showAlertDialog(context);
              },
            ),
          )),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0, // ไม่มีเงา
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Center(
          child: Card(
            elevation: 8,
            child: Container(
              padding: EdgeInsets.all(40),
              height: MediaQuery.of(context).size.height * 0.7,
              child: Column(
                children: [
                  if (!(widget.countdownMinutes == 0 &&
                      widget.countdownSecond == 0))
                    QrImageView(
                      data: widget.qrData,
                      version: QrVersions.auto,
                      size: 200,
                    ),
                  SizedBox(
                    height: 40,
                  ),
                  Text(widget.qrData),
                  SizedBox(
                    height: 24,
                  ),
                  Text("Countdown Time"),
                  SizedBox(
                    height: 4,
                  ),
                  // Text(
                  //   "${widget.countdown}",
                  //   style: TextStyle(fontSize: 32),
                  // ),
                  Text(
                    "${widget.countdownMinutes}:${widget.countdownSecond.toString().padLeft(2, '0')}",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  // ElevatedButton.icon(
                  //     style: ElevatedButton.styleFrom(
                  //         fixedSize: Size.fromWidth(100)),
                  //     onPressed: pauseResumeTimer,
                  //     icon: Icon(isPaused ? Icons.play_arrow : Icons.stop,
                  //         size: 14),
                  //     label: Text(
                  //         isPaused ? 'Resume' : 'Pause',
                  //         style: TextStyle(
                  //             fontSize: 12, fontWeight: FontWeight.w500),
                  //       ),
                  //     ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    if (timer.isActive) {
      timer.cancel();
    }
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor:
          Color.fromARGB(100, 69, 32, 204), // คืนค่าสีของ StatusBar เป็นสีขาว
    ));
    super.dispose();
  }

  void _showAlertDialog(BuildContext context) {
    // showDialog ใช้สร้าง AlertDialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // AlertDialog ที่จะแสดง
        return AlertDialog(
          title: Text('ทำการยกเลิก QR code'),
          content: Text('This is an example of AlertDialog.'),
          actions: [
            // ปุ่ม OK
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // ปิด AlertDialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // ปิด AlertDialog
                Navigator.of(context).pop(); // ปิด หน้าเพจปจบ.
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
