// import 'dart:ui';
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
import 'package:vevent_flutter/widget/filter_banner.dart';
import 'package:vevent_flutter/widget/my_events_section.dart';
import 'package:vevent_flutter/repository/user_repository.dart';
import 'package:vevent_flutter/widget/search_box.dart';
import 'package:vevent_flutter/widget/sign_out_btn.dart';
import 'package:vevent_flutter/page/index_page.dart';
import 'package:google_sign_in/google_sign_in.dart';
// void main() async {
//   runApp(const VEventApp());
// }

const List<String> scopes = <String>[
  'email',
  'https://www.googleapis.com/auth/contacts.readonly',
];

GoogleSignIn _googleSignIn = GoogleSignIn(
  // Optional clientId
  // clientId: 'your-client_id.apps.googleusercontent.com',
  scopes: scopes,
);
// ignore: must_be_immutable
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
  const AppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
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
                      Row(
                        children: [
                          Container(
                            width: 48,
                            height: 48,
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16)),
                              image: DecorationImage(
                                  image: AssetImage(
                                      "assets/images/default_profile.png")),
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Hi, Nattawat.18 (Username)",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16)),
                              Text("participants (Role)",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12))
                            ],
                          )
                        ],
                      ),
                      const SignOutBtn(),
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
                  decoration: const BoxDecoration(boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 1),
                      blurRadius: 10,
                      color: Color.fromRGBO(106, 77, 214, 0.5),
                    )
                  ]),
                  child: const SearchBox()),
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


  GoogleSignInAccount? _currentUser;
  // String uEmail = "Laure-CA03@example.com";
  String uEmail = "organization-01@example.com";
  // String uRole = "Participant";
  String uRole = "Organization";

    Future<void> _handleSignIn() async {
    try {
      print("on sign in");
      await _googleSignIn.signOut();
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if(googleUser!=null){
        print(googleUser.email);
      }else{
        print("User null");
      }
    } catch (error) { 
      print(error);
    }
  }

  //display
  @override
  Widget build(BuildContext context) {
    final GoogleSignInAccount? user = _currentUser;
    debugPrint(AppEnvironment.baseApiUrl);
    if (user != null) {
      return Scaffold(
          body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppBar(),
          const SizedBox(
            height: 24,
          ),
          FilterBanner(),
          Container(
            margin: const EdgeInsets.fromLTRB(16, 24, 16, 8),
            child: const Text(
              "กิจกรรมของฉัน",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black),
            ),
          ),
          Expanded(
            // height: MediaQuery.of(context).size.height * 0.4,
            // padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
              child: Stack(
                alignment: Alignment.bottomCenter,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyEventsSection(uEmail: uEmail, uRole: uRole),
                ],
              ),
            ),
          ),
        ],
      ));
    } else {
      return Scaffold(
          backgroundColor: Colors.redAccent[200],
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 24,
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(16, 160, 16, 16),
                child: (Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Image.asset(
                        "assets/images/text_logo.png",
                        height: 120,
                        width: 120,
                      ),
                    )
                  ],
                )),
              ),
              Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text("Choose Account Type")],
                ),
              ]),
              const SizedBox(
                width: 10,
                height: 30,
              ),
              Column(
                children: [
                  const Padding(padding: EdgeInsets.fromLTRB(10, 0, 10, 0)),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            color: Colors.amber,
                            width: 30,
                            height: 30,
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            color: Colors.blueAccent,
                            width: 30,
                            height: 30,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  ElevatedButton(onPressed: () async => {
                    await _handleSignIn(),
                  }, child: Text('Sign In Google'))
                ],
              )
            ],
          ));
    }
  }
}
