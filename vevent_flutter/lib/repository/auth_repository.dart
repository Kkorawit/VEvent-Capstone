import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:vevent_flutter/provider/auth_provider.dart';

class AuthRepository {
    final AuthProvider provider;

  AuthRepository({required this.provider});

    Future<void> authUser(String uEmail, String displayName, String role ) async {
        debugPrint("In AuthRepository");
        await provider.logIn(uEmail, displayName, role);
        debugPrint("In AuthRepository Token = ${await provider.storage.read(key: "token")}");
    }
    // Future<FlutterSecureStorage> authUser(String uEmail, String displayName, String role ) async {
    //     await provider.logIn(uEmail, displayName, role);
    //     final FlutterSecureStorage data = provider.storage;
    //     return data;
    // }
}