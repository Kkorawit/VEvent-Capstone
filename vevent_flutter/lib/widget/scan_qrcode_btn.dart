import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vevent_flutter/bloc/qrcode/qrcode_bloc.dart';
import 'package:vevent_flutter/repository/validation_repository.dart';

class ScanQRCodeBtn extends StatefulWidget {
  final String uEmail;
  final String uEventId;
  final String eventStatus;
  final String validateStatus;
  final String validationType;
  late String qrRes = "Response from qr code is heare";

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
      setState(() {
        widget.qrRes = res;
      });
      String currentDateTime = DateTime.now().toUtc().toIso8601String();
      context.read<QrcodeBloc>().add(qrcodeValidation(
          uEventId: widget.uEventId,
          qrData: widget.qrRes,
          currentDateTime: currentDateTime));
    } on PlatformException {
      widget.qrRes = "Fail to read qr code";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(widget.qrRes),
        ElevatedButton(
            onPressed: () async {
              // String currentDateTime = DateTime.now().toUtc().toIso8601String();
              await scanQR();
              // context.read<QrcodeBloc>().add(qrcodeValidation(uEventId: widget.uEventId, qrData: widget.qrRes, currentDateTime: currentDateTime));
            },
            child: Text("Scan QR Code")),
      ],
    );
  }
}
