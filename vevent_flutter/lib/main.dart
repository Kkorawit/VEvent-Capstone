import 'package:flutter/material.dart';
// import 'get_all_events.dart';
import 'customCard.dart';
import 'package:graphql_flutter/graphql_flutter.dart';


void main() async {
  runApp(const MyWidget());
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "My App",
      home: MyHomePage(),
      theme: ThemeData(colorSchemeSeed: Color.fromARGB(100, 69, 32, 204)),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Map<String, dynamic> listEvents = {};
  List<dynamic> listEvents = [];

  Future<void> getAllEvents({String? uEmail}) async {
    HttpLink link =
        HttpLink("http://capstone23.sit.kmutt.ac.th:8080/kw1/graphql");
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
      // log("ทุกอย่างปกติดีจ้าาา");
      setState(() {
        listEvents = queryResult.data?['findAllEventsByUEmail'] ?? [];
        // listEvents = queryResult.data!;
      });
    } else {
      print(queryResult.data?['findAllEventsByUEmail']);
      // log("เกิด" + queryResult.data.toString());
      print("null จ้าแม่");
    }
    // return queryResult.data?['findAllEventsByUEmail'] ??[];
  }

  @override
  void initState() {
    super.initState();
    getAllEvents(uEmail: "anne04@example.com");
    print("initState => ${listEvents}");
  }

  //การแสดงผล
  @override
  Widget build(BuildContext context) {
      print("list event => ${listEvents}");
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(
              MediaQuery.of(context).size.height * 0.2), //size of app bar
          child: AppBar(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(28),
                    bottomLeft: Radius.circular(28))),
            flexibleSpace: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(28),
                      bottomLeft: Radius.circular(28)),
                  gradient: LinearGradient(colors: [
                    Color.fromARGB(100, 69, 32, 204),
                    Color.fromARGB(100, 106, 77, 214)
                  ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
            ),
            title: Text(
              "All Event List",
              style: TextStyle(fontSize: 24),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "กิจกรรมของฉัน",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 14,
              ),
              Container(
                height: MediaQuery.of(context).size.height *0.60,
                child: showEventList(),
              ),
            ],
          ),
        ));
  }


Widget showEventList(){
  print(listEvents);
  if(listEvents.length == 0){
  print(listEvents);
    return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        image: AssetImage("assets/images/text_logo.png"),
                        height: 100,
                        width: 148,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text("No participating events"),
                      SizedBox(
                        height: 8,
                      ),
                    ],
                  ),
                );
  }else{
  print(listEvents);
    return ListView.builder(
                    itemCount: listEvents.length,
                    itemBuilder: (context, index) {
                      print(
                          "Listview u-e-id => ${listEvents[index]["user_event_id"]}");
                      print(
                          "Listview uEmail => ${listEvents[index]["user"]["userEmail"]}");
                      print(
                          "Listview e-id => ${listEvents[index]["event"]["id"]}");
                      print("Listview => ${listEvents[index]}");
                      return CustomCard(
                          eventId: "${listEvents[index]["event"]["id"]}",
                          uEmail: "${listEvents[index]["user"]["userEmail"]}",
                          title: "${listEvents[index]["event"]["title"]}",
                          startDate:
                              "${listEvents[index]["event"]["startDate"]}",
                          location:
                              "${listEvents[index]["event"]["locationName"]}",
                          category:
                              "${listEvents[index]["event"]["category"]}",
                          createBy:
                              "${listEvents[index]["event"]["createBy"]}",
                          eventStatus: "${listEvents[index]["status"]}",
                          description:
                              "${listEvents[index]["event"]["description"]}",
                          imagePath:
                              "${listEvents[index]["event"]["posterImg"]}");
                    });
  }
}


}
