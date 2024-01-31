import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:vevent_flutter/bloc/event/event_bloc.dart';
import 'package:vevent_flutter/bloc/event_detail/event_detail_bloc.dart';
import 'package:vevent_flutter/bloc/participant/participant_bloc.dart';
import 'package:vevent_flutter/bloc/qrcode/qrcode_bloc.dart';
import 'package:vevent_flutter/bloc/user/user_bloc.dart';
import 'package:vevent_flutter/bloc/validation/validation_bloc.dart';
import 'package:vevent_flutter/models/app_environment.dart';
import 'package:vevent_flutter/provider/event_provider.dart';
import 'package:vevent_flutter/provider/participant_provider.dart';
import 'package:vevent_flutter/provider/user_provider.dart';
import 'package:vevent_flutter/provider/validation_provider.dart';
import 'package:vevent_flutter/repository/event_repository.dart';
import 'package:vevent_flutter/repository/participant_repository.dart';
import 'package:vevent_flutter/repository/validation_repository.dart';
import 'package:vevent_flutter/widget/my_events_section.dart';
import 'package:vevent_flutter/repository/user_repository.dart';
import 'package:vevent_flutter/widget/search_box.dart';
import 'package:vevent_flutter/widget/sign_out_btn.dart';
// void main() async {
//   runApp(const VEventApp());
// }

class VEventApp extends StatelessWidget {
  const VEventApp({super.key});

  @override
  Widget build(BuildContext context) {
    final eventBloc = BlocProvider(
        create: (context) =>
            EventBloc(EventRepository(provider: EventProvider())));
    final userBloc = BlocProvider(
        create: (context) =>
            UserBloc(UserRepository(provider: UserProvider())));
    final validationBloc = BlocProvider(
        create: (context) => ValidationBloc(
            ValidationRepository(provider: ValidationProvider())));
    final eventDetailBloc = BlocProvider(
        create: (context) =>
            EventDetailBloc(EventRepository(provider: EventProvider())));
    final participantBloc = BlocProvider(
        create: (context) =>
            ParticipantBloc(ParticipantRepo(provider: ParticipantProvider())));
    final qrCodeBloc = BlocProvider(
        create: (context) =>
            QrcodeBloc(ValidationRepository(provider: ValidationProvider())));

    // final colorScheme = ColorScheme(
    //     brightness: brightness,
    //     primary: Color.fromRGBO(69, 32, 204, 1),
    //     onPrimary: onPrimary,
    //     secondary: Color.fromRGBO(106, 77, 214, 1),
    //     onSecondary: onSecondary,
    //     error: Colors.red,
    //     onError: Colors.redAccent,
    //     background: background,
    //     onBackground: onBackground,
    //     surface: surface,
    //     onSurface: onSurface);

    return MultiBlocProvider(
      providers: [
        eventBloc,
        userBloc,
        validationBloc,
        eventDetailBloc,
        participantBloc,
        qrCodeBloc
      ],
      // create: (context) => EventBloc(EventRepository(provider: EventProvider())),
      child: MaterialApp(
        title: "My App",
        home: const MyHomePage(),
        theme: ThemeData(
            appBarTheme: const AppBarTheme(
                backgroundColor: Color.fromRGBO(69, 32, 204, 1))),
      ),
    );
  }
}

class AppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        // color: Colors.red,
        height: MediaQuery.of(context).size.height * 0.2,
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 32, left: 16, right: 16),
              height: MediaQuery.of(context).size.height * 0.17,
              width: double.infinity,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
                // color: Colors.white ,
                gradient: LinearGradient(colors: [
                  Color.fromRGBO(69, 32, 204, 1),
                  Color.fromRGBO(106, 77, 214, 1),
                  // Color.fromARGB(100, 69, 32, 204),
                  // Color.fromARGB(100, 106, 77, 214)
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          child: Row(
                        children: [
                          Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16)),
                              image: DecorationImage(
                                  image: AssetImage(
                                      "assets/images/default_profile.png")),
                            ),
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Hi, Nattawat.18 (Username)",
                                  style: TextStyle(color: Colors.white, fontSize: 16)),
                              Text("participants (Role)",
                                  style: TextStyle(color: Colors.white, fontSize: 12))
                            ],
                          )
                        ],
                      )
                          // child: Image.asset("assets/images/default_profile.png", fit: BoxFit.fitHeight),
                          ),
                      SignOutBtn(),
                    ],
                  ),

                  // SizedBox(height: 8,),
                  // Container(
                  //   child: Text("search box"),
                  // )
                ],
              ),
            ),
            // Positioned(bottom: 0, child:SearchBox()),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  alignment: Alignment.center,
                  height: 56,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 1),
                        blurRadius: 10,
                        color: Color.fromRGBO(106, 77, 214, 0.5),

                      )
                    ]
                  ),
                  child: SearchBox()),
            ),
          ],
        ),
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
  //การแสดงผล
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppBar(),
        // SizedBox(height: 24,),
        // Row(children: [
        //   TextButton(onPressed: (){}, child: Text("All")),
        //   TextButton(onPressed: (){}, child: Text("All")),
        //   TextButton(onPressed: (){}, child: Text("All")),
        // ],),
        SizedBox(
          height: 24,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            "กิจกรรมของฉัน",
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
          ),
        ),
        // Text(
        //   AppEnvironment.baseApiUrl,
        //   style:
        //       const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        // ),
        const SizedBox(
          height: 24,
        ),
        Expanded(
          // height: MediaQuery.of(context).size.height * 0.4,
          // padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 56),
            child: Stack(
              alignment: Alignment.bottomCenter,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: Colors.blue,
                  // height: MediaQuery.of(context).size.height * 0.4,
                  child: MyEventsSection(),
                ),
              ],
            ),
          ),
        ),
      ],
    ));
  }
}
