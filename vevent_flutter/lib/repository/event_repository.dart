import 'package:flutter/foundation.dart';
import 'package:vevent_flutter/provider/event_provider.dart';

class EventRepository {
  final EventProvider provider;

  EventRepository({required this.provider});

  Future<List<dynamic>> getEventsByUserEmail(
      String uEmail, String uRole, String selectedStatus) async {
    final List events;
    // String selectedStatus;

    if (kDebugMode) {
      print("in event repository");
      print("$uEmail : $uRole");
    }
    if (uRole == 'Participant') {
      debugPrint("hear if -> uRole == 'Participant");
      events = await provider.getEventsByParticipantEmail(uEmail);
    } else {
      debugPrint("hear else -> uRole == Organization");
      events = await provider.getEventsByOrganizerEmail(uEmail);
    }
    // List<dynamic> filteredEvent;
    if (selectedStatus != "All") {
      List<dynamic> filteredEvent =
          filterEventByStatus(events, selectedStatus, uRole);
      return filteredEvent;
    } else {
      return events;
    }
    // debugPrint("${events[0]["status"]}");
    // debugPrint("$filteredEvent");
  }

  Future<Map> getEventDetailsByUserEventId(String id, String uRole) async {
    final Map event;
    if (kDebugMode) {
      print("in event repository");
      print("$id : $uRole");
    }
    if (uRole == 'Participant') {
      event = await provider.getEventDetailsByUserEventId(id);
    } else {
      event = await provider.getEventDetailsByEventId(id);
    }
    debugPrint("$event");
    return event;
  }

  List<dynamic> filterEventByStatus(
      List<dynamic> events, String selectedStatus, String uRole) {
    List<dynamic> filteredEvent;
    if (uRole == "Participant") {
      filteredEvent =
          events.where((event) => event["status"] == selectedStatus).toList();
    } else {
      filteredEvent =
          events.where((event) => event["eventStatus"] == selectedStatus).toList();
    }
    return filteredEvent;
  }

  String selectStatusFilter(String status) {
    switch (status) {
      case "Pending":
        return "P";
      case "In Progress":
        return "TP";
      case "Success":
        return "S";
      case "Fail":
        return "F";
      default:
        return "All";
    }
  }
}
