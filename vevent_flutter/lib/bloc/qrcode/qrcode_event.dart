part of 'qrcode_bloc.dart';

@immutable
sealed class QrcodeEvent {}

// ignore: camel_case_types
class qrcodeValidation extends QrcodeEvent {
  final String uEventId;
  final String qrData;
  // final String qrStart;
  // final int duration;
  final String currentDateTime;

  qrcodeValidation({required this.uEventId, required this.qrData, required this.currentDateTime});
}
