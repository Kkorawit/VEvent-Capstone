// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';

// Widget GetLocation(){
//    Position? _currentPosition;

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
//       // Location services are not enabled don't continue
//       // accessing the position and request users of the
//       // App to enable the location services.
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
//         // Permissions are denied, next time you could try
//         // requesting permissions again (this is also where
//         // Android's shouldShowRequestPermissionRationale
//         // returned true. According to Android guidelines
//         // your App should show an explanatory UI now.
//         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//           content: Text("Location permissions are denied"),
//         ));
//         return false;
//       }
//     }

//     if (permission == LocationPermission.deniedForever) {
//       // Permissions are denied forever, handle appropriately.
//       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//         content: Text(
//             "Locations are permanently denied, we cannot request permissions."),
//       ));
//       return false;
//     }

//     // When we reach here, permissions are granted and we can
//     // continue accessing the position of the device.
//     return true;
//   }

//   Future<void> _getCurrentPosition() async {
//     final hasPermission = await _handleLocationPermission();

//     if (!hasPermission) return;

//     await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
//         .then((Position position) {
//       setState(() => _currentPosition = position);
//     }).catchError((e) {
//       debugPrint(e);
//     });
//   }
  
// }