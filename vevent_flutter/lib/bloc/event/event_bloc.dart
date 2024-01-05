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
        var events = await repository.getEventsByUserEmail(event.uEmail);
        print("In EventBloc => ${events}");
        emit(EventFinishState(events: events));

      } catch (e) {
        emit(EventErrorState(e.toString()));
      }
    });

    on<getEvent>((event, emit) async {
      emit(EventLoadingState());
      try{
        var eventRes = await repository.getEventByUserEmailAndEventId(event.uEmail, event.eId);
        print("In EventBloc => ${eventRes}");
        emit(EventFinishState(events: [eventRes]));

      }catch (e){
        emit(EventErrorState(e.toString()));
      }
    });
  }
}
