part of 'event_bloc.dart';

@immutable
sealed class EventEvent {}

class showEventList extends EventEvent {
  final String uEmail;

  showEventList({required this.uEmail});
}
