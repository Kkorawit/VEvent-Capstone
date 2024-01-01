import 'package:vevent_flutter/provider/event_provider.dart';

class EventRepository {
  final EventProvider provider;

  EventRepository({required this.provider});

    Future<List<dynamic>> getEventsByUserEmail(String uEmail) async {
        final data = await provider.getEventsByUserEmail(uEmail);
        return data;
    }

    // filter method is here
}