// import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:vevent_flutter/repository/validation_repository.dart';
import 'package:vevent_flutter/validation_response.dart';

part 'validation_event.dart';
part 'validation_state.dart';

class ValidationBloc extends Bloc<ValidationEvent, ValidationState> {
  final ValidationRepository repository;
  ValidationBloc(this.repository) : super(ValidationInitial()) {
    on<validateGPS>((event, emit) async {

      emit(ValidationLoadingState());

      try{
        ValidationResponse res = await repository.validateGPS(event.eId,event.uEmail);
        if (kDebugMode) {
          print("In EventBloc => ${res}");
        }
        // if(res == "false"){
        //   print(" IN ValidationBloc => plese enable location service or allow the access permstion");
        //   emit(ValidationErrorState("plese enable location service or allow the access permstion"));
        // }
        emit(ValidationFinishState(validateRes: res));

      }catch (e){
          // emit(ValidationErrorState("Please enable location service or allow the location permission"));
        if(e.toString().contains('lat')){
          emit(ValidationErrorState("Please enable location service or allow the location permission"));
        }else{
        emit(ValidationErrorState(e.toString()));
        }
      }
    });
  }
}
