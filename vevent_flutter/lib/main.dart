import 'package:flutter/material.dart';
import 'package:vevent_flutter/dateTimeFormat.dart';
import 'get_all_events.dart';
import 'customCard.dart';
// import 'package:intl/intl.dart';

void main() async {
  runApp(MyWidget());
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "My App",
      home: MyHomePage(),
      theme: ThemeData(primarySwatch: Colors.yellow),
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
        appBar: AppBar(
          title: Text(
            "All Event List",
            style: TextStyle(fontSize: 24),
          ),
        ),
        body: FutureBuilder(
            future: getAllUsers(uid: 1),
            builder: (context, snapshot) {
              // debugPrint('getAllUsers() >>> ${snapshot.data}');
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
                      SizedBox(height: 8,),
                      Text("No participating events"),
                      SizedBox(height: 8,),
                      Text("Return to web page"),
                    ],
                  ),
                );
              } else {
                return Padding(
                    padding: const EdgeInsets.fromLTRB(16, 32, 16, 32),
                    child: ListView.builder(
                        itemCount: snapshot.data?.length,
                        itemBuilder: (context, index) {
                          debugPrint(
                              ' ListView.builder event start date >>> ${snapshot.data?[index]['event']['startDate']}');
                          print(
                              ' ListView.builder event >>> ${snapshot.data?[index]}');

                          // var formattedDate = dateTimeFormat("${snapshot.data?[index]['event']['startDate']}");

                          String eventStatus;

                          if (snapshot.data?[index]['status'] == 'D') {
                            eventStatus = "Done";
                          } else if (snapshot.data?[index]['status'] == 'A') {
                            eventStatus = "Active";
                          } else {
                            eventStatus = "Other";
                          }

                          // if(snapshot.data?[index] == []){
                          //   return Container(
                          //     child: Column(
                          //       children: [
                          //         Image(image: AssetImage("assets/images/Logo_2.png")),
                          //         Text("No participating events"),
                          //         Text("Return to web page"),
                          //       ],
                          //     ),
                          //   );
                          // }else{
                          return CustomCard(
                            title: "${snapshot.data?[index]['event']['title']}",
                            // startDate: formattedDate,
                            startDate:
                                "${snapshot.data?[index]['event']['startDate']}",
                            location:
                                "${snapshot.data?[index]['event']['locationName']}",
                            category: "category",
                            createBy:
                                "${snapshot.data?[index]['event']['createBy']}",
                            eventStatus: eventStatus,
                            description:
                                "${snapshot.data?[index]['event']['description']}",
                            imagePath: "assets/images/poster.png",
                            // event: [snapshot.data?[index]],
                          );
                          // }
                        }));
              }
            }));
  }
}
