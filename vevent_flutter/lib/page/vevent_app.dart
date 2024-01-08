import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vevent_flutter/bloc/event/event_bloc.dart';
import 'package:vevent_flutter/bloc/event_detail/event_detail_bloc.dart';
import 'package:vevent_flutter/bloc/user/user_bloc.dart';
import 'package:vevent_flutter/bloc/validation/validation_bloc.dart';
import 'package:vevent_flutter/provider/event_provider.dart';
import 'package:vevent_flutter/provider/user_provider.dart';
import 'package:vevent_flutter/provider/validation_provider.dart';
import 'package:vevent_flutter/repository/event_repository.dart';
import 'package:vevent_flutter/repository/validation_repository.dart';
import 'package:vevent_flutter/widget/my_events_section.dart';
import 'package:vevent_flutter/repository/user_repository.dart';
// void main() async {
//   runApp(const VEventApp());
// }

class VEventApp extends StatelessWidget {
  const VEventApp({super.key});

  @override
  Widget build(BuildContext context) {
    final eventBloc = BlocProvider(create: (context) => EventBloc(EventRepository(provider: EventProvider())));
    final userBloc = BlocProvider(create: (context) => UserBloc(UserRepository(provider: UserProvider())));
    final validationBloc = BlocProvider(create: (context) => ValidationBloc(ValidationRepository(provider: ValidationProvider())));
    final eventDetailBloc = BlocProvider(create: (context) => EventDetailBloc(EventRepository(provider: EventProvider())));
    return MultiBlocProvider(
      providers: [eventBloc,userBloc,validationBloc,eventDetailBloc],
      // create: (context) => EventBloc(EventRepository(provider: EventProvider())),
      child: MaterialApp(
        title: "My App",
        home: MyHomePage(),
        theme: ThemeData(colorSchemeSeed: Color.fromARGB(100, 69, 32, 204),),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // void initState() {
  //   //เป็นการเรียกใช้งานครั้งเดียว
  //   BlocProvider.of<EventBloc>(context).add(showEventList(uEmail: "laure-ca03@example.com"));
  //   super.initState();
  // }
  //การแสดงผล
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<EventBloc>(context).add(showEventList(uEmail: "laure-ca03@example.com"));
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
                height: MediaQuery.of(context).size.height * 0.60,
                child: const MyEventsSection(),
              ),
            ],
          ),
        ));
  }
}
