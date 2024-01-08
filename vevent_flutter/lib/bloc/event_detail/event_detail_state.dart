part of 'event_detail_bloc.dart';

@immutable
sealed class EventDetailState {}

final class EventDetailInitial extends EventDetailState {}

class EventDetailLoadingState extends EventDetailState {}

class EventDetailErrorState extends EventDetailState {
  final String message;

  EventDetailErrorState(this.message);
}

class EventDetailFinishState extends EventDetailState {
  final Map event;

  EventDetailFinishState({required this.event});
}