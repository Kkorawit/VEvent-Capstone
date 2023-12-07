import 'package:flutter/material.dart';
import 'get_all_events.dart';
import 'customCard.dart';
// import 'firebase_storage_client.dart';
// import 'package:firebase_core/firebase_core.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(MyWidget());
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

  //การแสดงผล
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize:  Size.fromHeight(MediaQuery.of(context).size.height * 0.2), //size of app bar
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
        body: FutureBuilder(
            future: getAllEvents(uEmail: "Laure-CA03@example.com"),
            builder: (context, snapshot) {
              debugPrint(
                  'In FutureBuilder -> getAllUsers() >>> ${snapshot.data}');
              // await getImageUrl('path_to_image.jpg');

              //check list of data from backend is not empty if empty show logo with text else show list all events.
              if (snapshot.data?.length == 0) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        image: AssetImage("assets/images/Logo_2.png"),
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
              } else {
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 46, 16, 32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "กิจกรรมของฉัน",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 14,
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height *0.58,
                          // margin: EdgeInsets.only(bottom: 32),
                          child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: snapshot.data?.length,
                              itemBuilder: (context, index) {
                                debugPrint(
                                    ' In ListView.builder event >>> ${snapshot.data?[index]}');
                                // var imageURL = getImageUrl();
                                // print(imageURL);

                                return CustomCard(
                                  eventId: "${snapshot.data?[index]['event']['id']}",
                                  title:"${snapshot.data?[index]['event']['title']}",
                                  // startDate: formattedDate,
                                  startDate:
                                      "${snapshot.data?[index]['event']['startDate']}",
                                  location:
                                      "${snapshot.data?[index]['event']['locationName']}",
                                  category:
                                      "${snapshot.data?[index]['event']['category']}",
                                  createBy:
                                      "${snapshot.data?[index]['event']['createBy']}",
                                  eventStatus:
                                      "${snapshot.data?[index]['status']}",
                                  description:
                                      "${snapshot.data?[index]['event']['description']}",
                                  imagePath: "assets/images/poster.png",
                                  // event: [snapshot.data?[index]],
                                );
                                // }
                              }),
                        ),
                      ],
                    ),
                  ),
                );
              }
            }));
  }
}

// Future<String> getImageUrl() async {
//  return await getDownloadURL();
// }

