import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:vevent_flutter/etc/app_environment.dart';
import 'package:vevent_flutter/models/gps_response.dart';

class ValidationProvider {
  Future<GpsResponse> validateGPS(
      String eId, String uEmail, String lat, String long) async {
    http.Response res;
    GpsResponse validationRes;
    try {
      res = await http.post(
          Uri.parse(
              "${AppEnvironment.baseApiUrl}/api/distance?eid=$eId&uemail=$uEmail"),
          body: jsonEncode(
            {"flat": lat, "flong": long},
          ),
          headers: {
            "Accept": "application/json",
            "content-type": "application/json"
          });

      if (kDebugMode) {
        print("In Provider");
        print(res.body);
        print(res.statusCode);
        print("In if else of provider");
      }

      Map<String, dynamic> responseData = jsonDecode(res.body);
      debugPrint("$responseData");
      validationRes = GpsResponse.fromJson(responseData);

      if (kDebugMode) {
        print(validationRes);
        print("VStatus = ${validationRes.vStatus}");
        print("http status = ${validationRes.httpStatus}");
        print("displacement = ${validationRes.displacement}");
      }
      return validationRes;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception("validateGPS api is fail !!");
    }
  }

  Future<http.Response> validateQRCode(
      String uEventId,
      String qrStart,
      String duration,
      String currentDateTime,
      String? lat,
      String? long) async {
    http.Response res;
    // ignore: unused_local_variable
    String qrCodeApi = "";
    String encodedData ;
    if (lat != null && long != null) {
      qrCodeApi =
          "/api/qrcode?QRstart=$qrStart&ueid=$uEventId&duration=$duration&currentDateTime=$currentDateTime&lat=$lat&long=$long";
    encodedData = base64Encode(utf8.encode("$qrStart&$uEventId&$duration&$currentDateTime&$lat&$long"));
    } else {
      qrCodeApi =
          "/api/qrcode?QRstart=$qrStart&ueid=$uEventId&duration=$duration&currentDateTime=$currentDateTime";
              encodedData = base64Encode(utf8.encode("$qrStart&$uEventId&$duration&$currentDateTime"));

    }
    // Encode data to Base64
    debugPrint('Encoded Data: $encodedData');
    // debugPrint("${AppEnvironment.baseApiUrl}$qrCodeApi");
    debugPrint("${AppEnvironment.baseApiUrl}/api/qrcode?info=$encodedData");
    try {
      res = await http.post(Uri.parse("${AppEnvironment.baseApiUrl}/api/qrcode?$encodedData"),
          headers: {
            "Accept": "application/json",
            "content-type": "application/json"
          });

      if (kDebugMode) {
        print("In QR Validate Provider");
        print(res.body);
        print(res.statusCode);
      }

      return res;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception("validateGPS api is fail !!");
    }
  }
}
