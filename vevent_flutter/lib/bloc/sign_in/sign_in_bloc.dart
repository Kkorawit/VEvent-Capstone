import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart';
import 'package:meta/meta.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc() : super(SignInInitial()) {
    on<signIn>((event, emit) async {
      emit(SignInLoadingState());
      try {
        debugPrint("Let's go delay 3 sec for sign-in");
        await Future.delayed(const Duration(seconds: 3));
        if (kDebugMode) {
          print("Sign-in or Sign-out is success!! ");
          print("${event.uEmail} : ${event.role}");
        }
        if(event.uEmail != null && event.role != null){
        emit(SignInFinishState(
            signInSuccess: true, uEmail: event.uEmail.toString(), role: event.role.toString()));
        }else{
        emit(SignInFinishState(
            signInSuccess: false, uEmail: event.uEmail.toString(), role: event.role.toString()));
        }
      } catch (e) {
        emit(SignInErrorState(e.toString()));
      }
    });
  }
}
