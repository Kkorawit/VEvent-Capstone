part of 'event_bloc.dart';

@immutable
sealed class EventEvent {
  // late String uEmail;
  // late String uRole;

}

class showEventList extends EventEvent {
  String uEmail;
  String uRole;

  showEventList({required this.uEmail, required this.uRole});
}


