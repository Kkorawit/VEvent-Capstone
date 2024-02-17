import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vevent_flutter/page/qr_code_page.dart';

// ignore: must_be_immutable
class GenerateQRCodeSection extends StatefulWidget {
  // late String qrData;
  late String qrStart = DateTime.now().toLocal().toString();
  late int qrStartHour = 0;
  final String eventID;
  final String eventStartDate;
  final String eventEndDate;
  late int durationHour = 0;
  late int durationMin = 0;
  late String currentDateTime;

  GenerateQRCodeSection(
      {super.key,
      required this.eventID,
      required this.eventStartDate,
      required this.eventEndDate});

  @override
  State<GenerateQRCodeSection> createState() => _GenerateQRCodeSectionState();
}

class _GenerateQRCodeSectionState extends State<GenerateQRCodeSection> {
  late DateTime qrStartTime;
  late DateTime eventEndTime;
  late DateTime qrTime;
  late int duration = 0;
  // @override
  // void initState() {
  //   widget.durationHour = 0;
  //   widget.durationMin = 0;
  //   super.initState();
  // }
  bool compareQrTime() {
    debugPrint("qrStart ${widget.qrStart}");

    qrStartTime = DateTime.parse(widget.qrStart);
    debugPrint("qrStartTime $qrStartTime");

    eventEndTime =
        DateFormat("yyyy-MM-ddTHH:mm:ss'Z'").parse(widget.eventEndDate);
    debugPrint("eventEndTime $eventEndTime");

    duration = (widget.durationHour * 60) + widget.durationMin;
    qrTime = qrStartTime.add(Duration(minutes: duration));
    debugPrint("qrTime $qrTime");

    if (/*qrTime.isAtSameMomentAs(eventEndTime)||*/qrTime.isBefore(eventEndTime)) {
      debugPrint("qrTime <= eventEndTime");
      return true;
    } else {
      debugPrint("qrTime > eventEndTime");
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(children: [
        const Text(
          "QR Code Generate",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const SizedBox(
          height: 24,
        ),
        Card(
          elevation: 8,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            // margin: EdgeInsets.all(40),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
            child: Column(children: [
              const Image(
                  image: AssetImage("assets/images/qr_code.png"),
                  height: 155.56),
              const SizedBox(
                height: 40,
              ),
              const Text(
                "Set a time limit to indicate the expiration period.",
                style: TextStyle(fontSize: 12),
              ),
              const SizedBox(
                height: 24,
              ),
              Text("QR Code Life Time"),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                TextButton(
                    onPressed: () {
                      if (widget.durationHour > 0) {
                        if (widget.durationMin > 0) {
                          setState(() {
                            widget.durationMin--;
                          });
                        } else {
                          setState(() {
                            
                          widget.durationMin = 59;
                          widget.durationHour--;
                          });
                        }
                      } else {
                        if(widget.durationMin > 0){
                        setState(() {
                          widget.durationMin--;
                        });
                        }else{
                          widget.durationMin = 0;
                        }
                      }
                    },
                    child: const Icon(
                      Icons.remove,
                      size: 24,
                    )),
                Text(
                  "${widget.durationHour} : ${widget.durationMin}",
                  style: const TextStyle(
                      fontSize: 32, fontWeight: FontWeight.w500),
                ),
                TextButton(
                    onPressed: () {
                      if (compareQrTime()) {
                        if (widget.durationMin < 59) {
                          setState(() {
                            widget.durationMin++;
                          });
                        } else {
                          setState(() {
                            widget.durationMin = 0;
                            widget.durationHour++;
                          });
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        backgroundColor: Colors.yellow,
                            content: Text(
                                "กรุณาตรวจสอบระยะเวลาสิ้นสุดกิจกรรม และตั้งเวลา QR Code ใหม่ให้ถูกต้อง", style: TextStyle(color: Colors.black),)));
                      }
                    },
                    child: const Icon(
                      Icons.add,
                      size: 24,
                    )),
              ]),
              const SizedBox(
                height: 24,
              ),
              if(compareQrTime() == false)
              ElevatedButton(
                  onPressed: null,
                  child: const Text("Create QR Code")),
              if(compareQrTime() == true)
              ElevatedButton(
                  onPressed: () {
                    // setState(() {
                    //   widget.qrStart = DateTime.now().toUtc().toIso8601String();
                    // });
                    debugPrint(widget.qrStart);
                    debugPrint(duration.toString());
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return QRCodePage(
                        qrStart: widget.qrStart,
                        eventId: widget.eventID,
                        duration: duration,
                      );
                    }));
                    setState(() {
                      widget.durationHour = 0;
                      widget.durationMin = 0;
                    });
                  },
                  child: const Text("Create QR Code"))
            ]),
          ),
        ),
      ]),
    );
  }
}
