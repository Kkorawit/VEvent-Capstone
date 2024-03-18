import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late String displayName = "";
  late String email = "xxxx@gmail.com";
  late String username = "xxxx";

  late String roleSelected = "participant";
  bool isParticipant = true;
  bool isOrganization = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up"),
      ),
       resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text("Email"),
                  SizedBox(
                    height: 8,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "$email",
                      // hintText: "$email",
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                    ),
                    readOnly: true,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text("User Name"),
                  SizedBox(
                    height: 8,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "$username",
                      // hintText: "$username",
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                    ),
                    readOnly: true,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text("Display Name"),
                  SizedBox(
                    height: 8,
                  ),
                  TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Display Name",
                        hintText: "Display Name",
                        helperText: 'ชื่อจริงนามสกุล หรือ ชื่อองค์กร',
                        floatingLabelBehavior: FloatingLabelBehavior.never),
                    onChanged: (value) {
                      setState(() {
                        displayName = value;
                      });
                    },
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  Container(
                    child: Column(
                      children: [
                        Text("Choose your role"),
                        Text("To continue please your Role on this Project"),
                        SizedBox(
                          height: 18,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                if (isParticipant == false) {
                                  setState(() {
                                    isParticipant = !isParticipant;
                                    roleSelected = "participant";
                                    isOrganization = !isParticipant;
                                  });
                                }
                                debugPrint("Participant role btn clicked!");
                                debugPrint("isParticipant : $isParticipant");
                                debugPrint("isOrganization : $isOrganization");
                                debugPrint("roleSelected : $roleSelected");
                              },
                              // icon: Image(image: AssetImage("./lib/assets/images/participant.png")),
                              child: Container(
                                  width: 137,
                                  height: 116,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 22, vertical: 12),
                                  child: Column(
                                    children: [
                                      Image(
                                          image: AssetImage(
                                              "./assets/images/participant-role.png")),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        "Participant",
                                        style: TextStyle(
                                            color:
                                                Color.fromRGBO(69, 32, 204, 1)),
                                      ),
                                    ],
                                  )),
                              style: ElevatedButton.styleFrom(
                                side: BorderSide(
                                    color: isParticipant
                                        ? Color.fromRGBO(69, 32, 204, 1)
                                        : Colors.white),
                                backgroundColor: Colors.white,
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                if (isOrganization == false) {
                                  setState(() {
                                    isOrganization = !isOrganization;
                                    roleSelected = "organization";
                                    isParticipant = !isOrganization;
                                  });
                                }
                                debugPrint("Organization role btn clicked!");
                                debugPrint("isParticipant : $isParticipant");
                                debugPrint("isOrganization : $isOrganization");
                                debugPrint("roleSelected : $roleSelected");
                              },
                              // icon: Image(image: AssetImage("./lib/assets/images/participant.png")),
                              child: Container(
                                  width: 137,
                                  height: 116,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 22, vertical: 12),
                                  child: Column(
                                    children: [
                                      Image(
                                          image: AssetImage(
                                              "./assets/images/organization-role.png")),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        "Organization",
                                        style: TextStyle(
                                            color:
                                                Color.fromRGBO(69, 32, 204, 1)),
                                      ),
                                    ],
                                  )),
                              style: ElevatedButton.styleFrom(
                                side: BorderSide(
                                    color: isOrganization
                                        ? Color.fromRGBO(69, 32, 204, 1)
                                        : Colors.white),
                                backgroundColor: Colors.white,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text("Next"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromRGBO(69, 32, 204, 1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Container(
//       padding: const EdgeInsets.fromLTRB(16, 120, 16, 32),
//       height: MediaQuery.of(context).size.height * 1,
//       width: MediaQuery.of(context).size.width * 1,
//       decoration: const BoxDecoration(
//         gradient: LinearGradient(colors: [
//           Color.fromRGBO(69, 32, 204, 1),
//           Color.fromRGBO(106, 77, 214, 1),
//         ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
//       ),
//       child: Column(
//         children: [
//           Text("data")
//         ],
//       ));