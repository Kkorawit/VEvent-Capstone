import 'package:graphql_flutter/graphql_flutter.dart';

class ParticipantProvider {
  //  สำหรับดึง participant ที่เข้าร่วม event นั้นๆ
  Future<List<dynamic>> getParticipantByEventID(String eid) async {
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
          query FindAllParticipantsByEventId {
    findAllParticipantsByEventId(eid: "${eid}") {
        status
        doneTimes
        user {
            username
            userEmail
            name
            surName
            profileImg
        }
    }
}

          """, // let's see query string
          ),
          variables: {
            "eid": "${eid}",
          },
        ),
      );

      var participants = queryResult.data?['FindAllParticipantsByEventId'];
      print(participants);

      if (participants == null) {
        print("queryResult.data is null");
        throw Exception("participant in event list is null");
      }
      return participants;
    } catch (e) {
      print(e.toString());
      throw Exception("Organizer Event api is fail !!");
    }
  }
}
