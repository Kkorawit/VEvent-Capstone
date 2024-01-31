import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:vevent_flutter/models/app_environment.dart';

class UserProvider {
  Future<Map> getUserByUserEmail(String uEmail) async {
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
            "uEmail": uEmail,
          },
        ),
      );

      var user = queryResult.data?['findUserByEmail'];
      debugPrint(user);

      if (user == null) {
        debugPrint("queryResult.data is null");
        throw Exception("user is not found");
      }

      return user;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception("User api is fail !!");
    }
  }
}
