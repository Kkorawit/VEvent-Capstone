import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
// import 'package:graphql_flutter/graphql_flutter.dart';
// import 'package:meta/meta.dart';
import 'package:vevent_flutter/repository/event_repository.dart';

part 'event_event.dart';
part 'event_state.dart';

class EventBloc extends Bloc<EventEvent, EventState> {
  final EventRepository repository;
  EventBloc(this.repository) : super(EventInitial()) {
    on<showEventList>((event, emit) async {
      emit(EventLoadingState()); //emit(sth) โยน sth 
      try {
        List<dynamic> events = await repository.getEventsByUserEmail(event.uEmail,event.uRole,event.selectedStatus);
        debugPrint("In EventBloc showEventList => $events");
        emit(EventFinishState(events: events));

      } catch (e) {
        emit(EventErrorState(e.toString()));
      }
    });

  }
}
