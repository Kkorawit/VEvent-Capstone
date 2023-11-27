import 'dart:developer';

import 'package:graphql_flutter/graphql_flutter.dart';
// import 'graphql_strings.dart' as gql_strings;
// import 'package:hive/hive.dart';
// import 'package:hive_flutter/hive_flutter.dart';

Future<List> getAllUsers({int? uid}) async {
  //    await Hive.initFlutter();
  // await Hive.openBox('myBox'); //

  HttpLink link = HttpLink(
      "http://172.26.160.1:8080/graphql"); // this is api call for getting all users
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
      document: gql("""
          query FindAllEventsByUid {
              findAllEventsByUid(uid: $uid) {
                  user_event_id
                  status
                  user {
                      userId
                  }
                  event {
                      id
                      title
                      eventDescription
                      category
                      endDate
                      startDate
                      validationType
                      validationRules
                      posterImg
                      createBy
                      locationName
                      locationLatitude
                      locationLongitude
                      description
                  }
              }
          }

          """, // let's see query string
      ),
      variables: {
        "uid": uid,
      },
    ),
  );

  if (queryResult.data != null) {
    print("ทุกอย่างปกติดีจ้าาา");
    log("ทุกอย่างปกติดีจ้าาา");
  } else {
    print(queryResult.data?['findAllEventsByUid']);
    log("เกิด" + queryResult.data.toString());
    print("null จ้าแม่");
  }
  return queryResult.data?['findAllEventsByUid'] ??
      []; // here i am getting list in getUsers field which i am return
}
