part of 'participant_bloc.dart';

@immutable
sealed class ParticipantEvent {}

// ignore: camel_case_types
class showParticipant extends ParticipantEvent {
  final String id;
  showParticipant({required this.id});
}
