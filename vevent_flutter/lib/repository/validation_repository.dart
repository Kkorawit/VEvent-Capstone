import 'package:geolocator/geolocator.dart';
import 'package:vevent_flutter/provider/validation_provider.dart';
// import 'package:http/http.dart' as http;

class ValidationRepository {
  final ValidationProvider provider;
  late String lat;
  late String long;

  ValidationRepository({required this.provider});

  Future<dynamic> validateGPS(
    String eId,
    String uEmail,
  ) async {
    // String lat; String long;
    // Position? curPosition;
    var res;
    await getCurrentPosition();
    // lat = curPosition?.latitude ?? '';
    // long = curPosition.longitude.toString();
    print("In validatioGPS");
    print("lat = ${lat}");
    print("long = ${long}");

      if (lat != '' && long != '') {
        res = await provider.validateGPS(eId, uEmail, lat, long);
        print("res in repository => ${res}");
        return res;
      } else {
        print("disable location service or did not allow location permissions");
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
    print("_getCurrentPosition is ON");
    Position? _currentPosition;
    final hasPermission = await handleLocationPermission();

    if (!hasPermission) {
      print("if hasPermisstion => ${hasPermission}");
      return ; //return teXt ตรงนี้ีได้นะ ว่าเป็นขาดเปิด service อะไร
    }
      _currentPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      lat = "${_currentPosition?.latitude ?? ''}";
      long = "${_currentPosition?.longitude ?? ''}";
        print("Set value to _currentPosition, lat, long");
    print(_currentPosition); 
    print("else hasPermisstion => ${hasPermission}");
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
    print("_handleLocationPermission is ON");

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      //serviceEnable == false
      print("Location services are disable. Please enable the services.");
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
        print("Location permissions are denied. Please allow permission.");
        // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        //   content:
        //       Text("Location permissions are denied. Please allow permission."),
        // ));
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      print(
          "Locations are permanently denied, we cannot request permissions. Please allow permission");
      // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      //   content: Text(
      //       "Locations are permanently denied, we cannot request permissions. Please allow permission"),
      // ));
      return false;
    }

    return true;
  }
}
