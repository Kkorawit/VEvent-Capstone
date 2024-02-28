// import 'package:flutter/foundation.dart';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:vevent_flutter/etc/app_environment.dart';
import 'package:vevent_flutter/page/vevent_app.dart';

Future<void> main() async {
  await dotenv.load(fileName: AppEnvironment.fileName(Environment.dev));
  HttpOverrides.global = MyHttpOverrides();
  runApp(const VEventApp());
  
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}