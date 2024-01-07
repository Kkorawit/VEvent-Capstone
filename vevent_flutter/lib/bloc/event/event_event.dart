part of 'event_bloc.dart';

@immutable
sealed class EventEvent {
  // late String uEmail;

}

class showEventList extends EventEvent {
  final String uEmail;

  showEventList({required this.uEmail});
}

class getEventDetails extends EventEvent {
  final String uEventId;
  getEventDetails({required this.uEventId});

 
}
