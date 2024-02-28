import 'package:flutter/foundation.dart';
import 'package:vevent_flutter/provider/event_provider.dart';

class EventRepository {
  final EventProvider provider;

  EventRepository({required this.provider});

  Future<List<dynamic>> getEventsByUserEmail(
      String uEmail, String uRole, String selectedStatus, String sortBy) async {
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
      debugPrint("getEventsByUserEmail repository => $events");

    List<dynamic> filteredEvent =
        filterEventByStatus(events, selectedStatus, uRole, sortBy);
          debugPrint("filterEventByStatus => $filteredEvent");

    return filteredEvent;
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

  List<dynamic> filterEventByStatus(List<dynamic> events, String selectedStatus,
      String uRole, String sortBy) {
    List<dynamic> filteredEvent;
    // List<dynamic> sortEvent;
    if (uRole == "Participant") {
      selectedStatus == "All"
          ? filteredEvent = events
          : filteredEvent = events
              .where((event) => event["status"] == selectedStatus)
              .toList();
               switch (sortBy) {
          case "Desc":
            filteredEvent.sort((a, b) =>
                b["event"]["startDate"].compareTo(a["event"]["startDate"]));
            break;
          case "Asc":
            filteredEvent
                .sort((a, b) => a["event"]["startDate"].compareTo(b["event"]["startDate"]));
            break;
          default:
            filteredEvent.sort((a, b) =>
                b["event"]["startDate"].compareTo(a["event"]["startDate"]));
            break;
        }
    } else {
      selectedStatus == "All"
          ? filteredEvent = events
          : filteredEvent = events
              .where((event) => event["eventStatus"] == selectedStatus)
              .toList();
               switch (sortBy) {
          case "Desc":
            filteredEvent.sort((a, b) =>
                b["startDate"].compareTo(a["startDate"]));
            break;
          case "Asc":
            filteredEvent
                .sort((a, b) => a["startDate"].compareTo(b["startDate"]));
            break;
          default:
            filteredEvent.sort((a, b) =>
                b["startDate"].compareTo(a["startDate"]));
            break;
        }
    }
    return filteredEvent;
    // if (selectedStatus != "All") {
    //   if (uRole == "Participant") {
    //     filteredEvent =
    //         events.where((event) => event["status"] == selectedStatus).toList();
    //     switch (sortBy) {
    //       case "Desc":
    //         filteredEvent.sort((a, b) =>
    //             b["event"]["startDate"].compareTo(a["event"]["startDate"]));
    //         break;
    //       case "Asc":
    //         filteredEvent
    //             .sort((a, b) => a["startDate"].compareTo(b["startDate"]));
    //         break;
    //       default:
    //         filteredEvent.sort((a, b) =>
    //             b["event"]["startDate"].compareTo(a["event"]["startDate"]));
    //         break;
    //     }
    //   } else {
    //     filteredEvent = events
    //         .where((event) => event["eventStatus"] == selectedStatus)
    //         .toList();
    //     filteredEvent.sort((a, b) => b["startDate"].compareTo(a["startDate"]));
    //     //  sortEvent = filteredEvent.sort((a, b) => a["startDate"].compareTo(b["startDate"]));
    //   }
    //   return filteredEvent;
    // } else {
    //   filteredEvent = events;
    //   if (uRole == "Participant") {
    //     filteredEvent.sort((a, b) =>
    //         b["event"]["startDate"].compareTo(a["event"]["startDate"]));
    //   } else {
    //     filteredEvent.sort((a, b) => b["startDate"].compareTo(a["startDate"]));
    //   }
    //   return filteredEvent;
    // }
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
