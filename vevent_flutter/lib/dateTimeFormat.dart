import 'package:intl/intl.dart';


 dateTimeFormat(String dt) {

  print(dt + ' -> in dateTimeFormat method');

  var dateTimeString = dt;
  var dateTime;
  var formattedDate;

  if (/*dateTimeString != null && */dateTimeString.isNotEmpty) {
    try {
      dateTime = DateFormat("yyyy-MM-ddTHH:mm:ss'Z'").parse(dateTimeString);
      formattedDate = DateFormat("MM/dd/yyyy hh:mm a").format(dateTime);
      print("Formatted Date: $formattedDate");
    } catch (e) {
      print("Error parsing or formatting Date: $e");
    }
  } else {
    print(dateTimeString);
    print("Invalid or empty DateTime string");
  }

  return formattedDate;
}
