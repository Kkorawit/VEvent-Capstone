import 'package:flutter/material.dart';

Widget StatusTag(String? status, double verSize, double horSize) {
  double ver;
  double hor;

  if (verSize != 0.0 && horSize != 0.0) {
    ver = verSize;
    hor = horSize;
  } else {
    ver = 4;
    hor = 8;
  }

  if (status == "P") {
    // [P/Pending] mean event is pending
    return Container(
      padding: EdgeInsets.symmetric(vertical: ver, horizontal: hor),
      margin: EdgeInsets.only(left: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Color.fromARGB(100, 230, 230, 230),
      ),
      child: Text(
        "Pending",
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: Color.fromARGB(100, 111, 111, 111),
        ),
      ),
    );
  } else if (status == "S") {
    // [S/Success] mean event is success
    return Container(
      padding: EdgeInsets.symmetric(vertical: ver, horizontal: hor),
      margin: EdgeInsets.only(left: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Color.fromARGB(100, 195, 228, 209),
      ),
      child: Text(
        "Success",
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: Color.fromARGB(100, 0, 99, 43),
        ),
      ),
    );
  } else if (status == "IP") {
    // [IR/In review] mean event is in review
    return Container(
      padding: EdgeInsets.symmetric(vertical: ver, horizontal: hor),
      margin: EdgeInsets.only(left: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Color.fromARGB(100, 255, 235, 179),
      ),
      child: Text(
        "In Progress",
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: Color.fromARGB(100, 239, 176, 8),
        ),
      ),
    );
  } else if (status == "F") {
    // [F/Fail] mean event is fail
    return Container(
      padding: EdgeInsets.symmetric(vertical: ver, horizontal: hor),
      margin: EdgeInsets.only(left: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Color.fromARGB(100, 255, 192, 192),
      ),
      child: Text(
        "Fail",
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: Color.fromARGB(100, 216, 50, 50),
        ),
      ),
    );
  } else {
    return Container(
      padding: EdgeInsets.symmetric(vertical: ver, horizontal: hor),
      margin: EdgeInsets.only(left: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Color.fromARGB(97, 243, 243, 243),
      ),
      child: Text(
        "-",
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: Color.fromARGB(100, 81, 81, 81),
        ),
      ),
    );
  }
}
