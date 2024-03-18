import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:meta/meta.dart';
import 'package:vevent_flutter/repository/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository repository;
  AuthBloc(this.repository) : super(AuthInitial()) {
    on<authUser>((event, emit) async {
      emit(AuthLoadingState());
      try{
        debugPrint("In AuthBloc");
        await repository.authUser(event.uEmail, event.displayName.toString(), event.role);
        // FlutterSecureStorage storage = await repository.authUser(event.uEmail, event.displayName.toString(), event.role);
        // debugPrint("In storage = ${storage}");
        // debugPrint("In storage = ${await storage.read(key: 'token')}");
        // await storage.read(key: 'token');
        // emit(AuthFinishState(storage: storage));
        debugPrint("In AuthBloc Token = ${await repository.provider.storage.read(key: "token")}");
        emit(AuthFinishState(status: "200"));
      }catch (e){
        emit(AuthErrorState(e.toString()));
      }
    });
  }
}
