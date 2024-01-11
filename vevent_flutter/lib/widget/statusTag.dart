import 'package:flutter/material.dart';

Widget StatusTag(String? status, double verSize, double horSize) {
  double ver;
  double hor;
  Color bgColor;
  Color fColor;
  String tagLabel;

  if (verSize != 0.0 && horSize != 0.0) {
    ver = verSize;
    hor = horSize;
  } else {
    ver = 4;
    hor = 8;
  }

  switch (status) {
    case "P" || "UP":
      bgColor = Color.fromARGB(100, 230, 230, 230);
      fColor = Color.fromARGB(100, 111, 111, 111);
      status == "P" ? tagLabel = "Fail" : tagLabel = "Cancel";
      status == "P" ? tagLabel = "Pending" : tagLabel = "Upcoming";
      break;
    case "S" || "CO":
      bgColor = Color.fromARGB(100, 195, 228, 209);
      fColor = Color.fromARGB(100, 0, 99, 43);
      status == "S" ? tagLabel = "Success" : tagLabel = "Complete";
      break;
    case "IP" || "ON":
      bgColor = Color.fromARGB(100, 255, 235, 179);
      fColor = Color.fromARGB(100, 239, 176, 8);
      status == "IP" ? tagLabel = "In progress" : tagLabel = "Ongoing";
      break;
    case "F" || "CA":
      bgColor = Color.fromARGB(100, 255, 192, 192);
      fColor = Color.fromARGB(100, 216, 50, 50);
      status == "F" ? tagLabel = "Fail" : tagLabel = "Cancel";
      break;
    default:
      bgColor = Color.fromARGB(97, 243, 243, 243);
      fColor = Color.fromARGB(100, 81, 81, 81);
      tagLabel = "-";
      break;
  }


  return Container(
    padding: EdgeInsets.symmetric(vertical: ver, horizontal: hor),
    margin: EdgeInsets.only(left: 4),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      color: bgColor,
    ),
    child: Text(
      tagLabel,
      style: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: fColor,
      ),
    ),
  );
}
