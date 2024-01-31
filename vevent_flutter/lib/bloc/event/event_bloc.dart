import 'package:bloc/bloc.dart';
// import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:meta/meta.dart';
import 'package:vevent_flutter/repository/event_repository.dart';

part 'event_event.dart';
part 'event_state.dart';

class EventBloc extends Bloc<EventEvent, EventState> {
  final EventRepository repository;
  EventBloc(this.repository) : super(EventInitial()) {
    on<showEventList>((event, emit) async {
      // TODO: implement event handler
      
      emit(EventLoadingState()); //emit(sth) โยน sth ออกไป
      try {
        List<dynamic> events = await repository.getEventsByUserEmail(event.uEmail,event.uRole);
        print("In EventBloc showEventList => ${events}");
        emit(EventFinishState(events: events));

      } catch (e) {
        emit(EventErrorState(e.toString()));
      }
    });

  }
}
