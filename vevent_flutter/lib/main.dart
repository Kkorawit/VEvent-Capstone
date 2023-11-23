
import 'package:flutter/material.dart';
import 'get_all_events.dart';
import 'customCard.dart';
import 'package:intl/intl.dart';

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
            future: getAllUsers(uid: 2),
            builder: (context, snapshot) {
              // debugPrint('getAllUsers() >>> ${snapshot.data}');
              return Padding(
                  padding: const EdgeInsets.fromLTRB(16, 32, 16, 32),
                  child: ListView.builder(
                      itemCount: snapshot.data?.length,
                      itemBuilder: (context, index) {
                        debugPrint(' ListView.builder event start date >>> ${snapshot.data?[index]['event']['startDate']}');
                        print(' ListView.builder event >>> ${snapshot.data?[index]}');
                        var dateTimeString = snapshot.data?[index]['event']['startDate'];
                        print(dateTimeString);
                        //แยกเป็น mathod ใน file อื่น
                        var dateTime;
                        var formattedDate;

                       if (dateTimeString != null && dateTimeString.isNotEmpty) {
                          try {
                            dateTime = DateFormat("yyyy-MM-ddTHH:mm:ss'Z'").parse(dateTimeString);
                            formattedDate = DateFormat("MM/dd/yyyy hh:mm a").format(dateTime);
                            print("Formatted Date: $formattedDate");
                          } catch (e) {
                            print("Error parsing or formatting Date: $e");
                          }
                        } else {
                          print(dateTimeString);
                          print("Invalid or empty DateTime string");
                        }

                        String eventStatus;

                        if(snapshot.data?[index]['status'] == 'D'){
                          eventStatus = "Done";
                        }else if(snapshot.data?[index]['status'] == 'A'){
                          eventStatus = "Active";
                        }else{
                          eventStatus = "Other";
                        }
                      

                        return CustomCard(
                            title: "${snapshot.data?[index]['event']['title']}",
                            startDate: formattedDate,
                            location: "${snapshot.data?[index]['event']['locationName']}",
                            category: "category",
                            createBy: "${snapshot.data?[index]['event']['createBy']}",
                            eventStatus: eventStatus,
                            description: "${snapshot.data?[index]['event']['description']}",
                            imagePath: "assets/images/poster.png",
                            );
                      }));
            }));
  }
}


