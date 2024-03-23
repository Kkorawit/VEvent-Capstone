import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
// import 'package:flutter/scheduler.dart';
import 'package:meta/meta.dart';
import 'package:vevent_flutter/page/sign_in_page.dart';
import 'package:vevent_flutter/repository/auth_repository.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final AuthRepository repository;
  final storage = FlutterSecureStorage();

  SignInBloc(this.repository) : super(SignInInitial()) {
    on<signIn>((event, emit) async {
      emit(SignInLoadingState());
      GoogleSignIn _googleSignIn = GoogleSignIn(
        scopes: scopes,
      );
      try {
        debugPrint("Let's go delay 3 sec for sign-in");
        await Future.delayed(const Duration(seconds: 3));
        if (kDebugMode) {
          print("Sign-in or Sign-out is success!! ");
          print("${event.uEmail} : ${event.role}");
        }
        if (event.uEmail != null && event.role != null) {
          String signInStatus =
              await repository.signInUser(event.uEmail.toString());
          if (signInStatus == "200") {
            // await storage.write(key: "email", value: event.uEmail.toString());
            // await storage.write(key: "displayName", value: event.displayName.toString());
            // await storage.write(key: "role", value: event.role.toString());
            // await storage.write(key: "profileURL", value: event.profileURL.toString());
            emit(SignInFinishState(
                signInSuccess: true,
                uEmail: event.uEmail.toString(),
                role: event.role.toString(),
                displayName: event.displayName.toString(),
                profileURL: event.profileURL.toString()));
          } else if (signInStatus == "202") {
            debugPrint("SignInStatus : $signInStatus");
            emit(SignInErrorState(
                "Not found user. Please sign up to use the VEvent app."));
          } else {
            debugPrint("SignInStatus : $signInStatus");
            emit(SignInErrorState("Sign in is fail"));
          }
        } else {
          await storage.delete(key: 'token');
          print('Token deleted successfully.');
          await _googleSignIn.signOut();
          emit(SignInFinishState(
              signInSuccess: false,
              uEmail: event.uEmail.toString(),
              role: event.role.toString(),
              displayName: event.displayName.toString(),
              profileURL: event.profileURL.toString()));
        }
      } catch (e) {
        emit(SignInErrorState(e.toString()));
      }
    });
  }
}
