import 'dart:async';
// import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';
// import 'package:vevent_flutter/models/app_environment.dart';

// ignore: must_be_immutable
class QRCodePage extends StatefulWidget {
  late String qrData;
  final String qrStart;
  final String eventId;
  final int duration;
  final String eventTitle;
  late String currentDateTime;
  late int countdownMinutes = duration;
  late int countdownSecond = 0;

  QRCodePage({
    super.key,
    required this.qrStart,
    required this.eventId,
    required this.duration,
    required this.eventTitle,
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
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // ทำให้ StatusBar เป็นสีที่透ทน
    ));
    widget.qrData = "${widget.qrStart};${widget.eventId};${widget.duration}";
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
        title: const Text(
          "Event QR code",
          style: TextStyle(color: Color.fromARGB(100, 22, 22, 22)),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FloatingActionButton(
              backgroundColor: const Color.fromARGB(100, 69, 32, 204),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10), // กำหนดความโค้ง
              ),
              mini: true, // กำหนดให้เป็น Mini FloatingActionButton
              heroTag:
                  null, // กำหนดให้ heroTag เป็น null เพื่อป้องกันความขัดแย้ง
              child: const Icon(Icons.close),
              onPressed: () {
                _showAlertDialog(context);
              },
            ),
          ),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0, // not have shadow
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Card(
            elevation: 8,
            child: Container(
              padding: const EdgeInsets.all(40),
              height: MediaQuery.of(context).size.height * 0.7,
              child: Column(
                children: [
                  Text(
                    widget.eventTitle,
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                    overflow: TextOverflow.clip,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20,),
                  if (!(widget.countdownMinutes == 0 &&
                      widget.countdownSecond == 0))
                    QrImageView(
                      data: widget.qrData,
                      version: QrVersions.auto,
                      size: 200,
                    ),
                  const SizedBox(
                    height: 40,
                  ),
                  if (kDebugMode) Text(widget.qrData),
                  const SizedBox(
                    height: 24,
                  ),
                  const Text("Countdown Time"),
                  const SizedBox(
                    height: 4,
                  ),
                  // Text(
                  //   "${widget.countdown}",
                  //   style: TextStyle(fontSize: 32),
                  // ),
                  Text(
                    "${widget.countdownMinutes}:${widget.countdownSecond.toString().padLeft(2, '0')}",
                    style: const TextStyle(
                        fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
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
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor:
          Color.fromARGB(100, 69, 32, 204), // คืนค่าสีของ StatusBar เป็นสีขาว
    ));
    super.dispose();
  }

  void _showAlertDialog(BuildContext context) {
    // showDialog that build AlertDialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // AlertDialog
        return AlertDialog(
          title: const Text('ทำการยกเลิก QR code'),
          content: const Text('This is an example of AlertDialog.'),
          actions: [
            // ปุ่ม OK
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // ปิด AlertDialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // close AlertDialog
                Navigator.of(context).pop(); // close current page.
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
