// // import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:vevent_flutter/page/vevent_app.dart';

// // import 'validateLocation.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// // ignore: must_be_immutable
// class Location extends StatefulWidget {
//   String eventId;
//   String uEmail;
//   String eventStatus;
//   // const Location({super.key});

//   Location(this.eventId, this.uEmail, this.eventStatus);

//   @override
//   State<Location> createState() => LocationState();
// }

// class LocationState extends State<Location> {
//   // String locationMessage = "Location of you.";
//   late String? lat;
//   late String? long;
//   Position? _currentPosition;
//   var res;

//   /// Determine the current position of the device.
//   ///
//   /// When the location services are not enabled or permissions
//   /// are denied the `Future` will return an error.
//   Future<bool> _handleLocationPermission() async {
//     bool serviceEnabled;
//     LocationPermission permission;

//     // Test if location services are enabled.
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       //serviceEnable == false
//       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//         content:
//             Text("Location services are disable. Please enable the services."),
//       ));
//       return false;
//     }

//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//           content: Text("Location permissions are denied. Please allow permission."),
//         ));
//         return false;
//       }
//     }

//     if (permission == LocationPermission.deniedForever) {
//       // Permissions are denied forever, handle appropriately.
//       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//         content: Text(
//             "Locations are permanently denied, we cannot request permissions. Please allow permission"),
//       ));
//       return false;
//     }

//     return true;
//   }

//   Future<void> _getCurrentPosition() async {
//     final hasPermission = await _handleLocationPermission();

//     if (!hasPermission) return;

//     await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
//         .then((Position position) {
//       setState(() {
//         _currentPosition = position;
//         lat = "${_currentPosition?.latitude ?? ''}";
//         long = "${_currentPosition?.longitude ?? ''}";
//       });
//     }).catchError((e) {
//       debugPrint(e);
//     });
//   }

//   Future<void> FetchLocation() async {
//     // var res;
//     await _getCurrentPosition();
//     print("${lat}, ${long}");

//     if (lat != '' && long != '') {
//       res = await http.post(
//           Uri.parse(
//               "https://capstone23.sit.kmutt.ac.th/kw1/dev/api/distance?eid=${widget.eventId}&uemail=${widget.uEmail}"),
//           body: jsonEncode(
//             {"flat": lat, "flong": long},
//           ),
//           headers: {
//             "Accept": "application/json",
//             "content-type": "application/json"
//           });
//       print("Validate Location Response: ${res.body}");
//       print("Validate Location Response: ${res.statusCode}");

//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text("${res.body}"),
//           ],
//         ),
//         backgroundColor: res.statusCode == 200 ? Colors.green : Colors.grey,
//       ));

//       if (res.statusCode == 200) {
//         setState(() {
//           widget.eventStatus = "S";
//         });
//          Future.delayed(Duration(seconds: 1),(){
//         Navigator.of(context).pushReplacement(
//           MaterialPageRoute(
//             builder: (BuildContext context) => VEventApp(),
//           ),
//         );
//         });
//       } else if (res.statusCode == 400 &&
//           res.body == "You're Not Around The Area") {
//         setState(() {
//           widget.eventStatus = "F";
//         });
//         Future.delayed(Duration(seconds: 1),(){
//         Navigator.of(context).pushReplacement(
//           MaterialPageRoute(
//             builder: (BuildContext context) => VEventApp(),
//           ),
//         );
//         });
//       }
//     }else {
//       // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//       //   content: Text("Please enable location service and allow location permissions"),
//       // ));
//       print("disable location service or did not allow location permissions");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     lat = "${_currentPosition?.latitude ?? ''}";
//     long = "${_currentPosition?.longitude ?? ''}";

//     if (widget.eventStatus == "S") {
//       return ElevatedButton(
//           onPressed: null, child: Text("Confirm participation"));
//     } else if (widget.eventStatus == "F") {
//       return ElevatedButton(
//         onPressed: () {
//           print("Click to validate again.");
//           FetchLocation();
//         },
//         child: Text("Confirm participation"),
//       );
//     } else {
//       return ElevatedButton(
//         onPressed: () {
//           print("Click to validate the event.");
//           FetchLocation();
//         }, //if onPressed : null , button is disable
//         child: Text("Confirm participation"),
//       );
//     }
//   }
// }
