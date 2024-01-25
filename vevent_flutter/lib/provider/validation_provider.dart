import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:vevent_flutter/models/app_environment.dart';
import 'package:vevent_flutter/validation_response.dart';

class ValidationProvider {
  Future<ValidationResponse> validateGPS(
      String eId, String uEmail, String lat, String long) async {
    http.Response res;
    ValidationResponse validationRes;
    try {
      res = await http.post(
          Uri.parse(
              "${AppEnvironment.baseApiUrl}/api/distance?eid=${eId}&uemail=${uEmail}"),
          body: jsonEncode(
            {"flat": lat, "flong": long},
          ),
          headers: {
            "Accept": "application/json",
            "content-type": "application/json"
          });

      print("In Provider");
      print(res.body);
      print(res.statusCode);
      print("In if else of provider");

      Map<String, dynamic> responseData = jsonDecode(res.body);
      print(responseData);
      validationRes = ValidationResponse.fromJson(responseData);

      print(validationRes);
      print("VStatus = ${validationRes.vStatus}");
      print("http status = ${validationRes.httpStatus}");
      print("displacement = ${validationRes.displacement}");
      return validationRes;
    } catch (e) {
      print(e.toString());
      throw Exception("validateGPS api is fail !!");
    }
  }

  Future<http.Response> validateQRCode(String uEventId, String qrStart,
      String duration, String currentDateTime) async {
    http.Response res;
    // {{host}}/local/api/qrcode?QRstart=2024-01-20T15:25:54.378693Z&eid=30&duration=15&currentDateTime=2024-01-20T15:27:54.378693
    try {
      res = await http.post(
          Uri.parse(
              "${AppEnvironment.baseApiUrl}/api/qrcode?QRstart=${qrStart}&euid=${uEventId}&duration=${duration}&currentDateTime=${currentDateTime}"),
          headers: {
            "Accept": "application/json",
            "content-type": "application/json"
          });

      print("In Provider");
      print(res.body);
      print(res.statusCode);

      return res;
    } catch (e) {
      print(e.toString());
      throw Exception("validateGPS api is fail !!");
    }
  }
}
