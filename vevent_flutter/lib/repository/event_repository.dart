import 'package:vevent_flutter/provider/event_provider.dart';

class EventRepository {
  final EventProvider provider;

  EventRepository({required this.provider});

    Future<List<dynamic>> getEventsByUserEmail(String uEmail) async {
        final events = await provider.getEventsByUserEmail(uEmail);
        return events;
    }

    Future<Map> getEventDetailsByUserEventId(String uEventId) async {
        final event = await provider.getEventDetailsByUserEventId(uEventId);
        return event;
    }

    // filter method is here
}