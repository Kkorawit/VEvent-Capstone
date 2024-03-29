// import 'dart:math';

import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:vevent_flutter/models/app_environment.dart';

class EventProvider {
  // --------------------------Get all events / List of events--------------------------

  Future<List<dynamic>> getEventsByParticipantEmail(String uEmail) async {
    try {
      HttpLink link =
          HttpLink("${AppEnvironment.baseApiUrl}/graphql");
      GraphQLClient qlClient = GraphQLClient(
        link: link,
        cache: GraphQLCache(
          store: InMemoryStore(),
        ),
      );
      QueryResult queryResult = await qlClient.query(
        QueryOptions(
          fetchPolicy: FetchPolicy.networkOnly,
          document: gql(
            """
          query FindAllRegisEventsByUEmail {
              findAllRegisEventsByUEmail (uEmail: "${uEmail}") {
                  user_event_id
                  status
                  doneTimes
                  user {
                      userEmail
                      username
                  }
                  event {
                      id
                      title
                      amountReceived
                      category
                      startDate
                      endDate
                      validationType
                      validationRules
                      posterImg
                      createBy
                      locationName
                      locationLatitude
                      locationLongitude
                      descriptionuEmail
                      validate_times
                      eventStatus
                  }
              }
          }

          """, // let's see query string
          ),
          variables: {
            "uEmail": "${uEmail}",
          },
        ),
      );

      var events = queryResult.data?['findAllRegisEventsByUEmail'];
      print(events);

      if (events == null) {
        print("queryResult.data is null");
        throw Exception("participant event list is null");
      }

      return events;
    } catch (e) {
      print(e.toString());
      throw Exception(" participant Event api is fail !!");
    }
  }

// findAllEventCreateByUEmail สำหรับดึง event ที่ user คนนั้นๆ สร้างไว้
  Future<List<dynamic>> getEventsByOrganizerEmail(String uEmail) async {
    // Read from DB or make network request etc...
    try {
      HttpLink link =
          HttpLink("${AppEnvironment.baseApiUrl}/graphql");
      GraphQLClient qlClient = GraphQLClient(
        link: link,
        cache: GraphQLCache(
          store: InMemoryStore(),
        ),
      );
      QueryResult queryResult = await qlClient.query(
        QueryOptions(
          fetchPolicy: FetchPolicy.networkOnly,
          document: gql(
            """
          query FindAllEventCreatedByUEmail {
              findAllEventCreatedByUEmail (uEmail: "${uEmail}") {
                id
                title
                eventDescription
                amountReceived
                category
                subCategory
                startDate
                endDate
                registerStartDate
                registerEndDate
                validationType
                validationRules
                posterImg
                createBy
                createDate
                updateBy
                updateDate
                locationName
                locationLatitude
                locationLongitude
                description
                validate_times
                eventStatus
              }
          }

          """, // let's see query string
          ),
          variables: {
            "uEmail": "${uEmail}",
          },
        ),
      );

      var events = queryResult.data?['findAllEventCreatedByUEmail'];
      print(events);

      if (events == null) {
        print("queryResult.data is null");
        throw Exception("Organizer event list is null");
      }

      return events;
    } catch (e) {
      print(e.toString());
      throw Exception("Organizer Event api is fail !!");
    }
  }

  // --------------------------Get inly event / event details--------------------------

  Future<Map> getEventDetailsByUserEventId(String uEventId) async {
    try {
      HttpLink link =
          HttpLink("${AppEnvironment.baseApiUrl}/graphql");
      GraphQLClient qlClient = GraphQLClient(
        link: link,
        cache: GraphQLCache(
          store: InMemoryStore(),
        ),
      );
      QueryResult queryResult = await qlClient.query(
        QueryOptions(
          fetchPolicy: FetchPolicy.networkOnly,
          document: gql(
            """
          query FindEventDetailsByUserEventId {
              findEventDetailsByUserEventId (id: "${uEventId}") {
                  user_event_id
                  status
                  doneTimes
                  user {
                      userEmail
                  }
                  event {
                      id
                      title
                      amountReceived
                      category
                      startDate
                      endDate
                      validationType
                      validationRules
                      posterImg
                      createBy
                      locationName
                      locationLatitude
                      locationLongitude
                      description
                      validate_times
                      eventStatus
                  }
              }
          }

          """, // let's see query string
          ),
          variables: {
            "id": "${uEventId}",
          },
        ),
      );

      var event = queryResult.data?['findEventDetailsByUserEventId'];
      print("getEventDetailsByUserEventId is ON");
      print("event detail -> ${event}");

      if (event == null) {
        print("queryResult.data is null");
        throw Exception("event detail is null");
      }

      return event;
    } catch (e) {
      print(e.toString());
      throw Exception("EventDetail api is fail !!");
    }
  }

  Future<Map> getEventDetailsByEventId(String id) async {
    try {
      HttpLink link =
          HttpLink("${AppEnvironment.baseApiUrl}/graphql");
      GraphQLClient qlClient = GraphQLClient(
        link: link,
        cache: GraphQLCache(
          store: InMemoryStore(),
        ),
      );
      QueryResult queryResult = await qlClient.query(
        QueryOptions(
          fetchPolicy: FetchPolicy.networkOnly,
          document: gql(
            """
          query FindEventDetailsByEventId {
              findEventDetailsByEventId (id: "${id}") {
                      id
                      title
                      amountReceived
                      category
                      startDate
                      endDate
                      validationType
                      validationRules
                      posterImg
                      createBy
                      locationName
                      locationLatitude
                      locationLongitude
                      description
                      validate_times
                      eventStatus
              }
          }

          """, // let's see query string
          ),
          variables: {
            "id": "${id}",
          },
        ),
      );

      var event = queryResult.data?['findEventDetailsByEventId'];
      print("getEventDetailsByEventId is ON");
      print("event detail -> ${event}");

      if (event == null) {
        print("queryResult.data is null");
        throw Exception("event detail is null");
      }

      return event;
    } catch (e) {
      print(e.toString());
      throw Exception("EventDetail api is fail !!");
    }
  }
}
