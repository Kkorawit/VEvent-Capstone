part of 'gps_bloc.dart';

@immutable
sealed class GpsEvent {}

// ignore: camel_case_types
class gpsValidation extends GpsEvent{
  final String uEmail;
  final String eId;

  gpsValidation({required this.uEmail, required this.eId});
}
