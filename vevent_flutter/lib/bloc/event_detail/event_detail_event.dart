part of 'event_detail_bloc.dart';

@immutable
sealed class EventDetailEvent {}

class getEventDetail extends EventDetailEvent {
  final String uEventId;
  getEventDetail({required this.uEventId});

 
}