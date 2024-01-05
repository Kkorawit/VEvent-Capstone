import 'package:vevent_flutter/provider/event_provider.dart';

class EventRepository {
  final EventProvider provider;

  EventRepository({required this.provider});

    Future<List<dynamic>> getEventsByUserEmail(String uEmail) async {
        final events = await provider.getEventsByUserEmail(uEmail);
        return events;
    }

    Future<Map> getEventByUserEmailAndEventId(String uEmail, String eId) async {
        final event = await provider.getEventByUserEmailAndEventId(uEmail, eId);
        return event;
    }

    // filter method is here
}