// import 'package:graphql_flutter/graphql_flutter.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;


  Future<int> FetchLocation(eventId, latitude, longitude) async {    
    print("eventId: ${eventId}, latitude: ${latitude}, longtitude: ${longitude}");
    var res = await http.post(
        Uri.parse("http://cp23kw1.sit.kmutt.ac.th:8080/api/longdo?eid=${eventId}"),
        body: jsonEncode({
          "flat": latitude,
          "flong": longitude
          },
        ),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json"
        }
        );

    print("Validate Location Respone: ${res.body}");
    print("Validate Location Respone: ${res.statusCode}");
    // print("Validate Location Respone: ${res}");

    if (res.statusCode == 200 && res.body == "Success") {
      return res.statusCode;
    }else if(res.statusCode == 400){
      if (res.body == "You're Not Around The Area") {
        return res.statusCode;
        
      }else if (res.body == "This Event Don't Registered The Event Location"){
        return res.statusCode;
      }else{
        throw Exception('Status 400 Failed out of case');
      }
    }else{
      throw Exception("Eror ${res.statusCode}");
    }
    
    // var client = http.Client();
    // try {
    //   var response = await client.post(
    //       Uri.https('example.com', 'whatsit/create'),
    //       body: {'name': 'doodle', 'color': 'blue'});
    //   var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
    //   var uri = Uri.parse(decodedResponse['uri'] as String);
    //   print(await client.get(uri));
    // } finally {
    //   client.close();
    // }
  }

