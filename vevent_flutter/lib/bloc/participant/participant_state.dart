part of 'participant_bloc.dart';

@immutable
sealed class ParticipantState {}

class ParticipantInitial extends ParticipantState {}

class ParticipantLoadingState extends ParticipantState {}

class ParticipantErrorState extends ParticipantState {
  final String message;

  ParticipantErrorState(this.message);
}

class ParticipantFinishState extends ParticipantState {
  final List<dynamic> participants;

  ParticipantFinishState({required this.participants});
}
