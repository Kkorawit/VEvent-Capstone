// import 'package:vevent_flutter/bloc/event/event_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:vevent_flutter/provider/event_provider.dart';

class EventRepository {
  final EventProvider provider;

  EventRepository({required this.provider});

    Future<List<dynamic>> getEventsByUserEmail(String uEmail, String uRole) async {
      final List events;
      if(kDebugMode){
      print("in event repository");
      print(uEmail +" : "+ uRole);
      }
      if (uRole == 'Participant'){
        events = await provider.getEventsByParticipantEmail(uEmail); 
      }else{
        print("here");
        events = await provider.getEventsByOrganizerEmail(uEmail);
      }
        return events;
    }

    Future<Map> getEventDetailsByUserEventId(String id, String uRole) async {
        final Map event ;
        print("in event repository");
        print("${id} : ${uRole}");
      if (uRole == 'Participant'){
        event = await provider.getEventDetailsByUserEventId(id);
      }else{
        event = await provider.getEventDetailsByEventId(id);
      }
        return event;
    }

    // filter method is here
}