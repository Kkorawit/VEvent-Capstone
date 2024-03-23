import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vevent_flutter/bloc/qrcode/qrcode_bloc.dart';
// import 'package:vevent_flutter/repository/validation_repository.dart';

// ignore: must_be_immutable
class ScanQRCodeBtn extends StatefulWidget {
  // final String uEmail;
  final String uEventId;
  final String eId;
  // final String eventStatus;
  // final String validateStatus;
  final String validationType;
  // final String? eventLongitude;
  // final String? eventLatitude;
  late String qrDecodedRes = "Response from qr code is heare";
  late String currentDateTime = "Current time here";

  ScanQRCodeBtn({
    super.key,
    // required this.uEmail,
    required this.uEventId,
    required this.eId,
    // required this.eventStatus,
    // required this.validateStatus,
    required this.validationType,
    // required this.eventLatitude,
    // required this.eventLongitude
  });

  @override
  State<ScanQRCodeBtn> createState() => _ScanQRCodeBtnState();
}

class _ScanQRCodeBtnState extends State<ScanQRCodeBtn> {
  late String decodedRes;
  Future<void> scanQR() async {
    try {
      String res = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.QR);
      if (!mounted) return;
      widget.currentDateTime = await DateTime.now().toUtc().toIso8601String();
      // Decode Base64 data
      decodedRes = utf8.decode(base64.decode(res));
      debugPrint('Decoded Data: $decodedRes');
      setState(() {
        widget.qrDecodedRes = decodedRes;
      });
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                Text('Camera permission denied. Please allow camera access.'),
          ),
        );
      } else {
        // Handle other errors
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () async {
          // String currentDateTime = await DateTime.now().toUtc().toIso8601String();
          await scanQR();
          List<String> data = widget.qrDecodedRes.split(";");
          if (widget.eId == data[1]) {
            context.read<QrcodeBloc>().add(qrcodeValidation(
                uEventId: widget.uEventId,
                withLocation: widget.validationType.contains("GPS"),
                qrData: widget.qrDecodedRes,
                currentDateTime: widget.currentDateTime));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('QR Code do not match with this event.'),
              ),
            );
          }
          debugPrint("In scan qrcode btn widget.qrDecodedRes => ${widget.qrDecodedRes}");
        },
        child: const Text("Scan QR Code"));
  }
}
