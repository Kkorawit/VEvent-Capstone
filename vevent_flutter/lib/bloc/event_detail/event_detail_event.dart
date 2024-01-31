part of 'event_detail_bloc.dart';

@immutable
sealed class EventDetailEvent {}

// ignore: camel_case_types
class getEventDetail extends EventDetailEvent {
  final String id;
  final String uRole;
  getEventDetail({required this.id, required this.uRole});

 
}