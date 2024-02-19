import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vevent_flutter/bloc/qrcode/qrcode_bloc.dart';
// import 'package:vevent_flutter/repository/validation_repository.dart';

// ignore: must_be_immutable
class ScanQRCodeBtn extends StatefulWidget {
  final String uEmail;
  final String uEventId;
  final String eventStatus;
  final String validateStatus;
  final String validationType;
  late String qrRes = "Response from qr code is heare";
  late String currentDateTime = "Current time here";


  ScanQRCodeBtn({
    super.key,
    required this.uEmail,
    required this.uEventId,
    required this.eventStatus,
    required this.validateStatus,
    required this.validationType,
  });

  @override
  State<ScanQRCodeBtn> createState() => _ScanQRCodeBtnState();
}

class _ScanQRCodeBtnState extends State<ScanQRCodeBtn> {
  Future<void> scanQR() async {
    try {
      String res = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.QR);
      if (!mounted) return;
      widget.currentDateTime = await DateTime.now().toUtc().toIso8601String();
      setState(() {
        widget.qrRes = res;
      });
      context.read<QrcodeBloc>().add(qrcodeValidation(
          uEventId: widget.uEventId,
          qrData: widget.qrRes,
          currentDateTime:  widget.currentDateTime));
    } on PlatformException catch (e) {
      // widget.qrRes = "Fail to read qr code";
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Failed to get camera permission: $e")));
       if (e.code == 'PERMISSION_DENIED') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Camera permission denied. Please allow camera access.'),
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
          debugPrint("In scan qrcode btn widget.qrRes => ${widget.qrRes}");
          // context.read<QrcodeBloc>().add(qrcodeValidation(
          //     uEventId: widget.uEventId,
          //     qrData: "2024-01-28T06:16:45.055500Z;30;15",
          //     currentDateTime: "2024-01-28T06:18:45.055500Z"));
        },
        child: const Text("Scan QR Code"));
  }
}
