import 'dart:developer';
import 'package:graphql_flutter/graphql_flutter.dart';

Future<Map> getUser({String? uEmail}) async {
  HttpLink link = HttpLink(
      "http://capstone23.sit.kmutt.ac.th:8080/kw1/graphql"); // this is api call for getting all users
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
          query FindUserByEmail {
                  findUserByEmail(uEmail:"$uEmail") {
                      username
                      password
                      userEmail
                      name
                      surName
                      profileImg
                  }
              }

          """, // let's see query string
      ),
      variables: {
        "uEmail": "$uEmail",
      },
    ),
  );

  if (queryResult.data != null) {
    print("get_user.dart -> การดึงข้อมูล user ปกติดีจ้าาา");
    log("get_user.dart -> การดึงข้อมูล user ปกติดีจ้าาา");
    print(queryResult.data);
  } else {
    print(queryResult.data?['findUserByUEmail']);
    log("ที่ get_user.dart -> เกิด " + queryResult.data.toString());
    print("get_user.dart -> null จ้าแม่");
  }
  return queryResult.data?['findUserByEmail'] ?? []; // here i am getting list in getUsers field which i am return
}
