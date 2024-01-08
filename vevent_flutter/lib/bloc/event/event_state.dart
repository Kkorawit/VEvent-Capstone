part of 'event_bloc.dart';

@immutable
sealed class EventState {}

class EventInitial extends EventState {}

class EventLoadingState extends EventState {}

class EventErrorState extends EventState {
  final String message;

  EventErrorState(this.message);
}

class EventFinishState extends EventState {
  final List<dynamic> events;

  EventFinishState({required this.events});
}
