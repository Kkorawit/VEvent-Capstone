import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:vevent_flutter/bloc/sign_in/sign_in_bloc.dart';

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
class SignInPage extends StatefulWidget {
  late String roleSelected = "Participant";
  late String uEmail = "Laure-CA03@example.com";
  // String uEmail = "organization-01@example.com";

  SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  GoogleSignInAccount? _currentUser;
  // String uEmail = "Laure-CA03@example.com";
  // String uEmail = "organization-01@example.com";
  // String uRole = "Participant";
  // String uRole = "Organization";

  Future<void> _handleSignIn() async {
    try {
      debugPrint("on sign in");
      // await _googleSignIn.signOut();
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        debugPrint(googleUser.email);
        _currentUser = googleUser;
        widget.roleSelected == "Participant"
            ? widget.uEmail = googleUser.email
            : widget.uEmail = "organization-01@example.com";
        context
            .read<SignInBloc>()
            .add(signIn(uEmail: widget.uEmail, role: widget.roleSelected));
      } else {
        debugPrint("User null");
      }
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    // final GoogleSignInAccount? user = _currentUser;
    // late Color participantBtnBg = const Color.fromRGBO(230, 230, 230, 0.4);
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 120, 16, 32),
      height: MediaQuery.of(context).size.height * 1,
      width: MediaQuery.of(context).size.width * 1,
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [
          Color.fromRGBO(69, 32, 204, 1),
          Color.fromRGBO(106, 77, 214, 1),
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
      ),
      child: Column(
        // alignment: Alignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
              height: 100,
              child: Image.asset("./assets/images/vevent_logo.png")),
          // const Image(image: AssetImage("/assets/images/text_logo.png")),
          Column(
            // textDirection: te,
            children: [
              const Text(
                "Choose Account Type",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 24,
              ),
              Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          widget.roleSelected = "Participant";
                          // widget.uEmail = "Laure-CA03@example.com";
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        width: 156,
                        height: 100,
                        // color: Colors.white,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.15),
                                  spreadRadius: 0,
                                  blurRadius: 15,
                                  offset: const Offset(0, 4))
                            ],
                            borderRadius: BorderRadius.circular(15),
                            color: widget.roleSelected == "Participant"
                                ? const Color.fromRGBO(230, 230, 230, 1)
                                : const Color.fromRGBO(230, 230, 230, 0.4)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(
                                image: const AssetImage(
                                    "./assets/images/account-icon.png"),
                                height: 24,
                                color: widget.roleSelected == "Participant"
                                    ? const Color.fromRGBO(69, 32, 204, 1)
                                    : const Color.fromRGBO(230, 230, 230, 1)),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Participant",
                              style: TextStyle(
                                  color: widget.roleSelected == "Participant"
                                      ? const Color.fromRGBO(69, 32, 204, 1)
                                      : Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          widget.roleSelected = "Organization";
                          // widget.uEmail = "organization-01@example.com";
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        width: 156,
                        height: 100,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.15),
                                  spreadRadius: 0,
                                  blurRadius: 15,
                                  offset: const Offset(0, 4))
                            ],
                            borderRadius: BorderRadius.circular(15),
                            color: widget.roleSelected == "Organization"
                                ? const Color.fromRGBO(230, 230, 230, 1)
                                : const Color.fromRGBO(230, 230, 230, 0.4)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(
                                image: const AssetImage(
                                    "./assets/images/organization-icon.png"),
                                height: 24,
                                color: widget.roleSelected == "Organization"
                                    ? const Color.fromRGBO(69, 32, 204, 1)
                                    : const Color.fromRGBO(230, 230, 230, 1)),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Organization",
                              style: TextStyle(
                                  color: widget.roleSelected == "Organization"
                                      ? const Color.fromRGBO(69, 32, 204, 1)
                                      : Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Text(
                "Hello, ${widget.roleSelected}",
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
              const Text(
                "Please login with google below to get start.",
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
              const SizedBox(
                height: 24,
              ),
              GestureDetector(
                //Sign-in with google btn
                onTap: () async {
                  await _handleSignIn();
                  // if (user != null) {
                  //   context.read<SignInBloc>().add(signIn(
                  //       uEmail: widget.uEmail, role: widget.roleSelected));
                  // } else {
                  //   ScaffoldMessenger.of(context).showSnackBar(
                  //       const SnackBar(content: Text("Please sign-in again!")));
                  // }
                },
                child: Container(
                  width: 328,
                  height: 56,
                  // color: Colors.white,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    color: Colors.white,
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image(
                        image: AssetImage(
                            "./assets/images/flat-color-icons_google.png"),
                        height: 24,
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Text(
                        "Sign in with Google",
                        style: TextStyle(
                            color: Color.fromRGBO(69, 32, 204, 1),
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          Container(
            child: const Text(
              "Powered By CP23KW1",
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
          )
        ],
      ),
    );
  }
}
