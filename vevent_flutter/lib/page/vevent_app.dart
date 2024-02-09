// import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:vevent_flutter/bloc/event/event_bloc.dart';
import 'package:vevent_flutter/bloc/event_detail/event_detail_bloc.dart';
import 'package:vevent_flutter/bloc/participant/participant_bloc.dart';
import 'package:vevent_flutter/bloc/qrcode/qrcode_bloc.dart';
import 'package:vevent_flutter/bloc/sign_in/sign_in_bloc.dart';
import 'package:vevent_flutter/bloc/user/user_bloc.dart';
import 'package:vevent_flutter/bloc/validation/validation_bloc.dart';
import 'package:vevent_flutter/models/app_environment.dart';
import 'package:vevent_flutter/page/sign_in_page.dart';
import 'package:vevent_flutter/page/splash_screen.dart';
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
// void main() async {
//   runApp(const VEventApp());
// }

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
    final signInBloc = BlocProvider(create: (context) => SignInBloc());

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
        qrCodeBloc,
        signInBloc
      ],
      // create: (context) => EventBloc(EventRepository(provider: EventProvider())),
      child: MaterialApp(
        title: "My App",
        // initialRoute: "/splash",
        // routes: {
        //   // "/splash" :(context) => const SplashScreen(),
        //   "/home" :(context) => const MyHomePage(),
        // },
        home: const MyHomePage(),
        theme: ThemeData(
            appBarTheme: const AppBarTheme(
                backgroundColor: Color.fromRGBO(69, 32, 204, 1))),
      ),
    );
  }
}

class AppBar extends StatelessWidget {
  final String uEmail;
  final String uRole;
  const AppBar({super.key, required this.uEmail, required this.uRole});

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
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Hi, $uEmail",
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 16)),
                              Text(uRole,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 12))
                            ],
                          )
                        ],
                      ),
                      const Expanded(child: SignOutBtn()),
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
  // String uEmail = "Laure-CA03@example.com";
  // String uEmail = "organization-01@example.com";
  // String uRole = "Participant";
  // String uRole = "Organization";

  //display
  @override
  Widget build(BuildContext context) {
    debugPrint(AppEnvironment.baseApiUrl);
    return Scaffold(body: BlocBuilder<SignInBloc, SignInState>(
      builder: (context, state) {
        if (state is SignInInitial) {
          return SignInPage();
        }
        if (state is SignInLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is SignInFinishState) {
          if (state.signInSuccess == true) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // SignInPage()
                AppBar(uEmail: state.uEmail, uRole: state.role),
                const SizedBox(
                  height: 24,
                ),
                FilterBanner(uEmail: state.uEmail, uRole: state.role),
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
                        MyEventsSection(
                            uEmail: state.uEmail, uRole: state.role),
                      ],
                    ),
                  ),
                ),
              ],
            );
          } else {
            return SignInPage();
          }
        } else if (state is SignInErrorState) {
          return Center(child: Text(state.message));
        } else {
          return const Center(
            child: Text("Error"),
          );
        }
      },
    ));
  }
}
