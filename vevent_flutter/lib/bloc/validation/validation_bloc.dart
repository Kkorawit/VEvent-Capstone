// import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:vevent_flutter/repository/validation_repository.dart';

part 'validation_event.dart';
part 'validation_state.dart';

class ValidationBloc extends Bloc<ValidationEvent, ValidationState> {
  final ValidationRepository repository;
  ValidationBloc(this.repository) : super(ValidationInitial()) {
    on<validateGPS>((event, emit) async {

      emit(ValidationLoadingState());

      try{
        var res = await repository.validateGPS(event.eId,event.uEmail);
        if (kDebugMode) {
          print("In EventBloc => ${res}");
        }

        emit(ValidationFinishState(validateRes: res.toString()));

      }catch (e){
        emit(ValidationErrorState(e.toString()));
      }
    });
  }
}
