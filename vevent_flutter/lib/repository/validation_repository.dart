// import 'dart:io';
// import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:vevent_flutter/provider/validation_provider.dart';
import 'package:vevent_flutter/models/gps_response.dart';
// import 'package:http/http.dart' as http;

class ValidationRepository {
  final ValidationProvider provider;
  late String lat;
  late String long;

  ValidationRepository({required this.provider});

  Future<GpsResponse> validateGPS(
    String eId,
    String uEmail,
  ) async {
    // String lat; String long;
    // Position? curPosition;
    GpsResponse res;
    await getCurrentPosition();
    // lat = curPosition?.latitude ?? '';
    // long = curPosition.longitude.toString();
    if (kDebugMode) {
      print("In validationGPS");
      print("lat = $lat");
      print("long = $long");
    }

    if (lat != '' && long != '') {
      res = await provider.validateGPS(eId, uEmail, lat, long);
      debugPrint("res in repository => $res");
      return res;
    } else {
      throw Exception(
          "disable location service or did not allow location permissions");
      // print("disable location service or did not allow location permissions");
    }
  }

  // void setLatitude(String latitude) {
  //   lat = latitude; // กำหนดค่าให้กับตัวแปร lat เมื่อค่าพร้อมใช้งาน
  // }
  // void setLongtitude(String latitude) {
  //   lat = latitude; // กำหนดค่าให้กับตัวแปร lat เมื่อค่าพร้อมใช้งาน
  // }

  Future<void> getCurrentPosition() async {
    // late String? lat;
    // late String? long;
    debugPrint("_getCurrentPosition is ON");
    Position? currentPosition; //_currentPosition
    final hasPermission = await handleLocationPermission();

    if (!hasPermission) {
      debugPrint("if has Permission => $hasPermission");
      return; //return teXt ตรงนี้ได้นะ ว่าเป็นขาดเปิด service อะไร
    }
    currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    lat = "${currentPosition?.latitude ?? ''}";
    long = "${currentPosition?.longitude ?? ''}";
    if (kDebugMode) {
      print("Set value to _currentPosition, lat, long");
      print(currentPosition);
      print("else has Permission => $hasPermission");
    }
    // return hasPermission;

    //     .then((Position position) {
    //   () {
    //     print(position);
    //     _currentPosition = position;
    //   };
    // }).catchError((e) {
    //   print(e.toString());
    // });
    // await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
    //     .then((Position position) {
    //   () {
    //     _currentPosition = position;
    //     // setLatitude("${_currentPosition?.latitude ?? ''}");
    //     // setLatitude("${_currentPosition?.longitude ?? ''}");
    // lat = "${_currentPosition?.latitude ?? ''}";
    // long = "${_currentPosition?.longitude ?? ''}";
    //   };
    // }).catchError((e) {
    //   print(e.toString());
    // });
    // print("Set value to _currentPosition, lat, long");
    // print(_currentPosition);
  }

  Future<bool> handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;
    debugPrint("_handleLocationPermission is ON");

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      //serviceEnable == false
      debugPrint("Location services are disable. Please enable the services.");
      // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      //   content:
      //       Text("Location services are disable. Please enable the services."),
      // ));
      return false;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        debugPrint("Location permissions are denied. Please allow permission.");
        // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        //   content:
        //       Text("Location permissions are denied. Please allow permission."),
        // ));
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      debugPrint(
          "Locations are permanently denied, we cannot request permissions. Please allow permission");
      // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      //   content: Text(
      //       "Locations are permanently denied, we cannot request permissions. Please allow permission"),
      // ));
      return false;
    }

    return true;
  }

  // Future<void> scanQR() async {
  //   late String qrRes = "Response from qr code is here";
  //   try {
  //     String res = await FlutterBarcodeScanner.scanBarcode(
  //         "#ff6666", "Cancel", true, ScanMode.QR);
  //     // if(!mounted)return;
  //     qrRes = res;
  //   } on PlatformException {
  //     qrRes = "Fail to read qr code";
  //   }
  // }

  Future<http.Response> validateQRCode(String uEventId, bool withLocation,
      String qrData, String currentDateTime) async {
    List<String> data = qrData.split(";");
    String qrStart = data[0];
    String duration = data[2];
    http.Response res;
    debugPrint("At repo validateQRCode()");
    debugPrint("uEventId = $uEventId");
    debugPrint("withLocation = $withLocation");
    debugPrint("qrStart = $qrStart");
    debugPrint("duration = $duration");
    debugPrint("currentDateTime = $currentDateTime");

    if (withLocation) {
      await getCurrentPosition();
      debugPrint("used getCurrentPosition()");
      debugPrint("lat = $lat");
      debugPrint("long = $long");
      if (lat != '' && long != '') {
        res = await provider.validateQRCode(
            uEventId, qrStart, duration, currentDateTime, lat, long);
        return res;
      } else {
        throw Exception(
            "disable location service or did not allow location permissions");
      }
    } else {
      res = await provider.validateQRCode(
          uEventId, qrStart, duration, currentDateTime, null, null);
      return res;
    }
  }
}
