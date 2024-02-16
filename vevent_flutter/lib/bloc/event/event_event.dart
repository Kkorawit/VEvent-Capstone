part of 'event_bloc.dart';

@immutable
sealed class EventEvent {
  // late String uEmail;
  // late String uRole;

}

// ignore: must_be_immutable, camel_case_types
class showEventList extends EventEvent {
  String uEmail;
  String uRole;
  String selectedStatus;
  String sortBy;

  showEventList({required this.uEmail, required this.uRole, required this.selectedStatus, required this.sortBy});
}


