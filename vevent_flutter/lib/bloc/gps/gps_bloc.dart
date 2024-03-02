import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:vevent_flutter/models/gps_response.dart';
import 'package:vevent_flutter/repository/validation_repository.dart';

part 'gps_event.dart';
part 'gps_state.dart';

class GpsBloc extends Bloc<GpsEvent, GpsState> {
  final ValidationRepository repository;
  GpsBloc(this.repository) : super(GpsInitial()) {
    on<gpsValidation>((event, emit) async {
      emit(GpsLoadingState());
      try{
        GpsResponse res = await repository.validateGPS(event.eId, event.uEmail);
          debugPrint("In EventBloc => $res");
          emit(GpsFinishState(gpsRes: res));
        
      }catch (e){
        if(e.toString().contains('lat')){
          emit(GpsErrorState("Please enable location service or allow the location permission"));
        }else{
        emit(GpsErrorState(e.toString()));
        }
      }
    });
  }
}
