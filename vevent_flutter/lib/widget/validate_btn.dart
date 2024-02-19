import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:vevent_flutter/bloc/validation/validation_bloc.dart';
import 'package:vevent_flutter/widget/gps_btn.dart';
import 'package:vevent_flutter/widget/scan_qrcode_btn.dart';

// ignore: must_be_immutable
class ValidateButton extends StatefulWidget {
  final String uEmail;
  final String uEventId;
  final String eventId;
  final String eventStatus;
  final String validateStatus;
  final String validationType;
  late String qrRes;

  ValidateButton({
    super.key,
    required this.uEmail,
    required this.uEventId,
    required this.eventId,
    required this.eventStatus,
    required this.validateStatus,
    required this.validationType,
  });

  @override
  State<ValidateButton> createState() => _ValidateButtonState();
}

class _ValidateButtonState extends State<ValidateButton> {
  // @override
  // void initState(){
  //   context.read<ValidationBloc>().close();
  //   super.initState();
  // }

  // Future<void> scanQR() async {
  //   try {
  //     String res = await FlutterBarcodeScanner.scanBarcode(
  //         "#ff6666", "Cancel", true, ScanMode.QR);
  //     if (!mounted) return;
  //     setState(() {
  //       widget.qrRes = res;
  //     });
  //   } on PlatformException {
  //     widget.qrRes = "Fail to read qr code";
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    if (widget.eventStatus == "ON") {
      if (widget.validateStatus == "IP" || widget.validateStatus == "F") {
        if (widget.validationType.contains("QR_CODE")) {
          return ScanQRCodeBtn(
              uEmail: widget.uEmail,
              uEventId: widget.uEventId,
              eventStatus: widget.eventStatus,
              validateStatus: widget.validateStatus,
              validationType: widget.validationType);
        } else {
          return GPSBtn(
              uEmail: widget.uEmail,
              eventId: widget.eventId,
              eventStatus: widget.eventStatus,
              validateStatus: widget.validateStatus,
              validationType: widget.validationType);
        }
      } else if (widget.validateStatus == "S") {
        return ElevatedButton(
            onPressed: null, child: Text(widget.validationType.contains("QR_CODE")?"Scan QR Code":"Confirm Validation"));
      } else {
        return Container();
      }
    } else {
      return Container();
    }
  }
}
