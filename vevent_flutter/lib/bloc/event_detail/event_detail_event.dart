part of 'event_detail_bloc.dart';

@immutable
sealed class EventDetailEvent {}

class getEventDetail extends EventDetailEvent {
  final String id;
  final String uRole;
  getEventDetail({required this.id, required this.uRole});

 
}