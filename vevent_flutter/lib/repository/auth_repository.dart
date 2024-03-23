import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:vevent_flutter/bloc/sign_in/sign_in_bloc.dart';
import 'package:vevent_flutter/provider/auth_provider.dart';

class AuthRepository {
    final AuthProvider provider;

  AuthRepository({required this.provider});

    // Future<void> authUser(String uEmail, String displayName, String role ) async {
    //     debugPrint("In AuthRepository");
    //     await provider.logIn(uEmail, displayName, role);
    //     debugPrint("In AuthRepository Token = ${await provider.storage.read(key: "token")}");
    // }
    Future<String> signInUser(String uEmail) async {
        final signInStatus = await provider.signIn(uEmail);
        // final FlutterSecureStorage storage = provider.storage;
        return signInStatus;
    }

    Future<String> signUpUser(String uEmail, String displayName, String role, String photoURL ) async {
        final signUpStatus = await provider.signUp(uEmail, displayName, role, photoURL );
        // final FlutterSecureStorage storage = provider.storage;
        return signUpStatus;
    }
}