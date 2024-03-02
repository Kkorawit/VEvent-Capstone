part of 'gps_bloc.dart';

@immutable
sealed class GpsState {}

class GpsInitial extends GpsState {}

class GpsLoadingState extends GpsState {}

class GpsErrorState extends GpsState {
  final String message;

  GpsErrorState(this.message);
}

class GpsFinishState extends GpsState {
  final GpsResponse gpsRes;
  GpsFinishState({required this.gpsRes});
}