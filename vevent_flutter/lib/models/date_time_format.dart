import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

String dateTimeFormat(String dt) {
  debugPrint('$dt -> in dateTimeFormat method');

  var dateTimeString = dt;
  DateTime dateTime;
  String formattedDate = "-";

  if (/*dateTimeString != null && */ dateTimeString.isNotEmpty) {
    try {
      dateTime = DateFormat("yyyy-MM-ddTHH:mm:ss'Z'").parse(dateTimeString);
      formattedDate = DateFormat("MM/dd/yyyy hh:mm a").format(dateTime);
      debugPrint("Formatted Date: $formattedDate");
    } catch (e) {
      debugPrint("Error parsing or formatting Date: $e");
    }
  } else {
    debugPrint(dateTimeString);
    debugPrint("Invalid or empty DateTime string");
  }

  return formattedDate;
}
