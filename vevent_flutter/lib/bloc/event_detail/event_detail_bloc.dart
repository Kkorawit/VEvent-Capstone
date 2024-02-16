import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
// import 'package:meta/meta.dart';
import 'package:vevent_flutter/repository/event_repository.dart';

part 'event_detail_event.dart';
part 'event_detail_state.dart';

class EventDetailBloc extends Bloc<EventDetailEvent, EventDetailState> {
  final EventRepository repository;
  EventDetailBloc(this.repository) : super(EventDetailInitial()) {
    on<getEventDetail>((event, emit) async {
      emit(EventDetailInitial());
      try {
        Map eventRes = await repository.getEventDetailsByUserEventId(
            event.id, event.uRole);
        debugPrint("In EventBloc getEventDetails => $eventRes");
        emit(EventDetailFinishState(event: eventRes));
      } catch (e) {
        emit(EventDetailErrorState(e.toString()));
      }
    });
  }

  read() {}
}
