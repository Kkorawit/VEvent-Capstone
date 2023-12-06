import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

// import 'validateLocation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// ignore: must_be_immutable
class Location extends StatefulWidget {
  String eventId;
  String eventStatus;
  // const Location({super.key});

  Location(this.eventId, this.eventStatus);

  @override
  State<Location> createState() => LocationState();
}

class LocationState extends State<Location> {
  // String locationMessage = "Location of you.";
  late String? lat;
  late String? long;
  Position? _currentPosition;
  var res;

  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      //serviceEnable == false
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content:
            Text("Location services are disable. Please enable the services."),
      ));
      return false;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Location permissions are denied"),
        ));
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
            "Locations are permanently denied, we cannot request permissions."),
      ));
      return false;
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;

    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
        lat = "${_currentPosition?.latitude ?? ''}";
        long = "${_currentPosition?.longitude ?? ''}";
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> FetchLocation() async {
    await _getCurrentPosition();
    print("${lat}, ${long}");

    // print(
    //     "eventId: ${eventId}, latitude: ${latitude}, longtitude: ${longitude}");
    var res = await http.post(
        Uri.parse(
            "http://cp23kw1.sit.kmutt.ac.th:8080/api/longdo?eid=${widget.eventId}"),
        body: jsonEncode(
          {"flat": lat, "flong": long},
        ),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json"
        });

    print("Validate Location Respone: ${res.body}");
    print("Validate Location Respone: ${res.statusCode}");
    
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Row(
          children: [
            Text("Status code: ${res.statusCode}"),
            SizedBox(width: 16,),
            Expanded(
              child: Text("${res.body}")
            ),
          ],
        ),
        backgroundColor: res.statusCode == 200 ? Colors.green : Colors.grey ,
      ));
      
    if(res.statusCode == 200){
      setState(() {
        widget.eventStatus = "S";
      });
    }else if(res.statusCode == 400 && res.body == "You're Not Around The Area"){
      setState(() {
        widget.eventStatus = "F";
      });
    }

    // if (res.statusCode == 200 && res.body == "Success") {
    //   return SnackBar(content: Text(res.body));
    // } else if (res.statusCode == 400) {
    //   if (res.body == "You're Not Around The Area") {
    //     return SnackBar(content: Text(res.body));;
    //   } else if (res.body == "This Event Don't Registered The Event Location") {
    //     return SnackBar(content: Text(res.body));;
    //   } else {
    //     throw Exception('Status 400 Failed out of case');
    //   }
    // } else {
    //   throw Exception("Eror ${res.statusCode}");
    // }

    
  }

  @override
  Widget build(BuildContext context) {
    lat = "${_currentPosition?.latitude ?? ''}";
    long = "${_currentPosition?.longitude ?? ''}";

    if (widget.eventStatus == "S") {
      return ElevatedButton(
          onPressed: null, child: Text("Success participation"));
    } else if (widget.eventStatus == "IR") {
      return ElevatedButton(
          onPressed: null, child: Text("Validation in review"));
    } else if (widget.eventStatus == "F") {
      return ElevatedButton(
          onPressed: () {
            // _getCurrentPosition();

            print("Click to validate again.");

            res = FetchLocation();
          
          },
          child: Text("Validation is fail"));
    } else {
      return ElevatedButton(
        onPressed: () {
          // _getCurrentPosition();

          print("Click to validate the event.");

          res = FetchLocation();
         
        }, //if onPressed : null , button is disable
        child: Text("Confirm participation"),
      );
    }
  }
}
