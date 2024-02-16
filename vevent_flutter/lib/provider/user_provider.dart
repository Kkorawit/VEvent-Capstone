import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:vevent_flutter/models/app_environment.dart';

class UserProvider {
  Future<Map> getUserByUserEmail(String uEmail) async {
    debugPrint(uEmail);
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
                              role
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

      Map user = queryResult.data?['findUserByEmail'];
      debugPrint(" this is user data from user provider => $user");

      if (user.isEmpty) {
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
