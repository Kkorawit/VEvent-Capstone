import 'package:vevent_flutter/provider/user_provider.dart';

class UserRepository {
    final UserProvider provider;

  UserRepository({required this.provider});

    Future<Map> getUserByUserEmail(String uEmail) async {
        final data = await provider.getUserByUserEmail(uEmail);
        return data;
    }
}
