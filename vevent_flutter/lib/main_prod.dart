// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:vevent_flutter/models/app_environment.dart';
import 'package:vevent_flutter/page/vevent_app.dart';

Future<void> main() async {
  await dotenv.load(fileName: AppEnvironment.fileName(Environment.prod));
  runApp(const VEventApp());
}
