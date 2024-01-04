import 'dart:convert';
import 'package:http/http.dart' as http;

class ValidationProvider {
    Future<dynamic> validateGPS(String eId, String uEmail, String lat, String long) async {
        http.Response res;
         res = await http.post(
          Uri.parse(
              "https://capstone23.sit.kmutt.ac.th/kw1/dev/api/distance?eid=${eId}&uemail=${uEmail}"),
          body: jsonEncode(
            {"flat": lat, "flong": long},
          ),
          headers: {
            "Accept": "application/json",
            "content-type": "application/json"
          });

          print(res.body);
          print(res.statusCode);

        return res.statusCode;
    }
}