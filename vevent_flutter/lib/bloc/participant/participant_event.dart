part of 'participant_bloc.dart';

@immutable
sealed class ParticipantEvent {}

class showParticipant extends ParticipantEvent {
  final String id;
  showParticipant({required this.id});
}
