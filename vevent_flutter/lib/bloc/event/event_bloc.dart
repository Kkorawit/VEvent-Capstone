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
        // HttpLink link =
        //     HttpLink("https://capstone23.sit.kmutt.ac.th/kw1/dev/graphql");
        // GraphQLClient qlClient = GraphQLClient(
        //   link: link,
        //   cache: GraphQLCache(
        //     store: InMemoryStore(),
        //   ),
        // );
        // QueryResult queryResult = await qlClient.query(
        //   QueryOptions(
        //     fetchPolicy: FetchPolicy.networkOnly,
        //     document: gql(
        //       """
        //   query FindAllEventsByUEmail {
        //       findAllEventsByUEmail(uEmail: "${event.uEmail}") {
        //           user_event_id
        //           status
        //           doneTimes
        //           user {
        //               userEmail
        //               username
        //           }
        //           event {
        //               id
        //               title
        //               eventDescription
        //               category
        //               startDate
        //               endDate
        //               eventOwner
        //               validationType
        //               validationRules
        //               createBy
        //               locationName
        //               locationLatitude
        //               locationLongitude
        //               description
        //               validate_times
        //               posterImg
        //           }
        //       }
        //   }

        //   """, // let's see query string
        //     ),
        //     variables: {
        //       "uEmail": event.uEmail,
        //     },
        //   ),
        // );

        // var events = queryResult.data?['findAllEventsByUEmail'];
        // print(events);

        // if(events == null){
        //   print("queryResult.data is null");
        //   emit(EventErrorState("event list is null"));
        //   return;
        // }
        var events = await repository.getEventsByUserEmail(event.uEmail);
        emit(EventFinishState(events: events));

      } catch (e) {
        emit(EventErrorState(e.toString()));
      }
    });
  }
}
