// import 'dart:math';

import 'package:graphql_flutter/graphql_flutter.dart';

class EventProvider {
    Future<List<dynamic>> getEventsByUserEmail(String uEmail) async {
        // Read from DB or make network request etc...
        try {
        HttpLink link =
            HttpLink("https://capstone23.sit.kmutt.ac.th/kw1/dev/graphql");
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
                      eventDescription
                      category
                      startDate
                      endDate
                      validationType
                      validationRules
                      createBy
                      locationName
                      locationLatitude
                      locationLongitude
                      description
                      validate_times
                      posterImg
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

        if(events == null){
          print("queryResult.data is null");
          throw Exception("event list is null");
        }

        return events;

      } catch (e) {
        print(e.toString());
        throw Exception("Event api is fail !!");
      }
    }
}