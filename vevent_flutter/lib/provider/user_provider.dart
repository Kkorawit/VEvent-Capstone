import 'package:graphql_flutter/graphql_flutter.dart';

class UserProvider {
  Future<Map> getUserByUserEmail(String uEmail) async {
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
                  query FindUserByEmail {
                          findUserByEmail(uEmail:"${uEmail}") {
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
            "uEmail": "${uEmail}",
          },
        ),
      );

      var user = queryResult.data?['findUserByEmail'];
      print(user);

      if (user == null) {
        print("queryResult.data is null");
        throw Exception("user is not found");
      }

      return user;
    } catch (e) {
      print(e.toString());
      throw Exception("User api is fail !!");
    }
  }
}
