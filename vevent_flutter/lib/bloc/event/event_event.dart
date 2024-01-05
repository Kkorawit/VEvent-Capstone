part of 'event_bloc.dart';

@immutable
sealed class EventEvent {
  // late String uEmail;

}

class showEventList extends EventEvent {
  String uEmail;

  showEventList({required this.uEmail});
}

class getEvent extends EventEvent {
  String uEmail;
  String eId;
  getEvent({required this.uEmail, required this.eId});

 
}
