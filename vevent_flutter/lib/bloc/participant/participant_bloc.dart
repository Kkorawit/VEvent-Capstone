import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:vevent_flutter/repository/participant_repository.dart';

part 'participant_event.dart';
part 'participant_state.dart';

class ParticipantBloc extends Bloc<ParticipantEvent, ParticipantState> {
  final ParticipantRepo repository;
  ParticipantBloc(this.repository) : super(ParticipantInitial()) {
    on<showParticipant>((event, emit) async {
      emit(ParticipantLoadingState());
      try {
        List<dynamic> participants =
            await repository.getParticipantByEventID(event.id);
        emit(ParticipantFinishState(participants: participants));
      } catch (e) {
        emit(ParticipantErrorState(e.toString()));
      }
    });
  }
}
