import 'dart:developer';

import 'package:graphql_flutter/graphql_flutter.dart';

Future<List> getAllEvents({String? uEmail}) async {


  HttpLink link = HttpLink(
      "https://capstone23.sit.kmutt.ac.th/kw1/graphql"); // this is api call for getting all users => sub path"http://cp23kw1.sit.kmutt.ac.th:8080/graphql"
  GraphQLClient qlClient = GraphQLClient(
    // craete a graphql client
    link: link,
    cache: GraphQLCache(
      store: InMemoryStore(),
    ),
  ); // ignore , just for cacheing
//this pattern about uri is same every method call api
  QueryResult queryResult = await qlClient.query(
    // here it's get type so using query method
    QueryOptions(
      fetchPolicy: FetchPolicy.networkOnly,
      document: gql(
        """
          query FindAllEventsByUEmail {
              findAllEventsByUEmail(uEmail: "$uEmail") {
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
                      eventOwner
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
        "uEmail": uEmail,
      },
    ),
  );
// queryResult.data != null
  if (queryResult.data != 0) {
    print("ทุกอย่างปกติดีจ้าาา");
    log("ทุกอย่างปกติดีจ้าาา");
    queryResult.data?['findAllEventsByUEmail'] ?? [];
  } else {
    print(queryResult.data?['findAllEventsByUEmail']);
    log("เกิด" + queryResult.data.toString());
    print("null จ้าแม่");
  }

  return queryResult.data?['findAllEventsByUEmail'] ?? [];
}
