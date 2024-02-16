part of 'qrcode_bloc.dart';

@immutable
sealed class QrcodeState {}

class QrcodeInitial extends QrcodeState {}

class QrcodeLoadingState extends QrcodeState {}

class QrcodeErrorState extends QrcodeState {
  final String message;

  QrcodeErrorState(this.message);
}

class QrcodeFinishState extends QrcodeState {
  final http.Response res;

  QrcodeFinishState({required this.res});
}
