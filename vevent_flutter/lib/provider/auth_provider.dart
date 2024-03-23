import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:vevent_flutter/etc/app_environment.dart';
import 'package:http/http.dart' as http;

class AuthProvider {
  final storage = FlutterSecureStorage();

  Future<String> signIn(String email) async {
    debugPrint("start Sign-in in auth provider");
    http.Response res;
    try {
      res = await http.post(Uri.parse("${AppEnvironment.baseApiUrl}/api/auth"),
          body: jsonEncode(
            {"email": email},
          ),
          headers: {
            "Accept": "application/json",
            "content-type": "application/json"
          });
      if (res.statusCode == 200) {
        // ถ้าการ log-in สำเร็จ
        debugPrint("sign in/auth is success");
        final token = res.body[0]; // สมมติว่า Token อยู่ในรูปแบบ JSON
        await storage.write(key: 'token', value: token);
      } else if (res.statusCode == 202) {
        debugPrint(res.body);
        //handle signup massage
      } else {
        // ถ้า log-in ไม่สำเร็จ
        debugPrint(res.body);
        throw Exception('Failed to log in');
      }
      debugPrint(res.body);
      return res.statusCode.toString();
    } catch (e) {
      debugPrint(e.toString());
      throw Exception("sign-in api is fail !!");
    }
  }

  Future<String> signUp(
      String email, String displayName, String role, String photoURL) async {
    debugPrint("start Sign up in auth provider");
    http.Response res;
    try {
      res = await http.post(Uri.parse("${AppEnvironment.baseApiUrl}/api/auth"),
          body: jsonEncode(
            {
              "email": email,
              "displayname": displayName,
              "role": role,
              "photoURL": photoURL
            },
          ),
          headers: {
            "Accept": "application/json",
            "content-type": "application/json"
          });
      if (res.statusCode == 200) {
        // ถ้าการ sign up สำเร็จ
        debugPrint("sign up/auth is success");
        final token = res.body[0]; // สมมติว่า Token อยู่ในรูปแบบ JSON
        await storage.write(key: 'token', value: token);
      } else {
        // ถ้า sign up ไม่สำเร็จ
        debugPrint(res.body);
        throw Exception('Failed to sign up');
      }
      debugPrint(res.body);
      return res.statusCode.toString();
    } catch (e) {
      debugPrint(e.toString());
      throw Exception("sign-up api is fail !!");
    }
  }

// test fake api token
  // Future<void> logIn(String email, String displayName, String role) async {
  //   // ส่งอีเมลและรหัสผ่านไปที่หลังบ้านเพื่อตรวจสอบ
  //   // และรับ Token กลับมาจากการยืนยันข้อมูล

  //   // ตัวอย่างการส่งข้อมูลไปยัง API ในการ log-in
  //   // final response = await yourBackendAPIService.logIn(email, displayName, role);
  //   debugPrint("Get Auth response");
  //   AuthResponse response = new AuthResponse(_randomValue(), _randomValue());
  //   // Future.delayed(Duration(seconds: 3));

  //   if (response.toString().isNotEmpty) {
  //     // ถ้าการ log-in สำเร็จ
  //     final token = response.accessToken; // สมมติว่า Token อยู่ในรูปแบบ JSON
  //     await storage.write(key: 'token', value: token);
  //   } else {
  //     // ถ้า log-in ไม่สำเร็จ
  //     throw Exception('Failed to log in');
  //   }
  // }
}

// String _randomValue() {
//   final rand = Random();
//   final codeUnits = List.generate(20, (index) {
//     return rand.nextInt(26) + 65;
//   });

//   return String.fromCharCodes(codeUnits);
// }

// class AuthResponse {
//   String accessToken;
//   String refreshToken;

//   // การกำหนดค่าเริ่มต้นในคอนสตรักเตอร์
//   AuthResponse(this.accessToken, this.refreshToken);
// }
