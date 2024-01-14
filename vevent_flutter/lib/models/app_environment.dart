import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

enum Environment { local, dev, qa, prod}

class AppEnvironment{
  static String fileName (Environment env) {
    late String fileName;

    if(kReleaseMode){
      fileName = '.env.prod';
    }
    if(kDebugMode){
      switch (env){
        case Environment.dev : 
            fileName = '.env.dev';
          break;
        case Environment.qa :
            fileName = '.env.qa';
          break;
        case Environment.prod :
            fileName = '.env.prod';
          break;
        default : 
            fileName ='.env';
          break;

      }
    }

    return fileName;
  }

  static String get baseApiUrl {
    return dotenv.get('_baseApiUrl', fallback: '_baseApiUrl not found');
  }
}

// enum Environment { local, dev, qa, prod }

// class AppEnvironment {
//   static late String baseApiUrl;
//   static late Environment _environment;

//   static Environment get environment => _environment;

//   static setupEnv(Environment env) {
//     switch (env) {
//       case Environment.dev:
//         baseApiUrl = "https://capstone23.sit.kmutt.ac.th/kw1/dev";
//         _environment = Environment.dev;
//         break;

//       case Environment.qa:
//         // baseApiUrl = 'https://capstone23.sit.kmutt.ac.th/ssa1/api/qa';
//         baseApiUrl = "https://capstone23.sit.kmutt.ac.th/kw1/qa";
//         _environment = Environment.qa;
//         break;

//       case Environment.prod:
//         // baseApiUrl = 'https://capstone23.sit.kmutt.ac.th/ssa1/api';
//         baseApiUrl = 'https://capstone23.sit.kmutt.ac.th/kw1/prod';
//         _environment = Environment.prod;
//         break;

//       default:
//         baseApiUrl = dotenv.get('baseApiUrl');
//         break;
//     }
//   }
// }