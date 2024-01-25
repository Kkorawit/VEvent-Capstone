// import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:vevent_flutter/repository/validation_repository.dart';

part 'qrcode_event.dart';
part 'qrcode_state.dart';

class QrcodeBloc extends Bloc<QrcodeEvent, QrcodeState> {
    final ValidationRepository repository;
  QrcodeBloc(this.repository) : super(QrcodeInitial()) {
    on<qrcodeValidation>((event, emit) async {
      // TODO: implement event handler
      emit(QrcodeLoadingState());
      try{
        http.Response res = await repository.validateQRCode(event.uEventId ,event.qrData, event.currentDateTime);
        emit(QrcodeFinishState(res: res));

      }catch(e){
        emit(QrcodeErrorState(e.toString()));
      }
    });
  }
}
