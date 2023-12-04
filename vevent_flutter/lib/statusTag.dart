import 'package:flutter/material.dart';

Widget StatusTag(String eStatus, double verSize, double horSize) {
  double ver;
  double hor;

  if (verSize != 0.0 && horSize != 0.0) {
    ver = verSize;
    hor = horSize;
  } else {
    ver = 4;
    hor = 8;
  }

  if (eStatus == "P") {
    // [P/Pending] mean event is pending
    return Container(
      padding: EdgeInsets.symmetric(vertical: ver, horizontal: hor),
      margin: EdgeInsets.only(left: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Color.fromARGB(100, 236, 233, 250),
      ),
      child: Text(
        "Pending",
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: Color.fromARGB(100, 69, 32, 204),
        ),
      ),
    );
  } else if (eStatus == "S") {
    // [S/Success] mean event is success
    return Container(
      padding: EdgeInsets.symmetric(vertical: ver, horizontal: hor),
      margin: EdgeInsets.only(left: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Color.fromARGB(100, 197, 245, 196),
      ),
      child: Text(
        "Success",
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: Color.fromARGB(100, 11, 91, 9),
        ),
      ),
    );
  } else if (eStatus == "IR") {
    // [IR/In review] mean event is in review
    return Container(
      padding: EdgeInsets.symmetric(vertical: ver, horizontal: hor),
      margin: EdgeInsets.only(left: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Color.fromARGB(100, 255, 245, 233),
      ),
      child: Text(
        "In review",
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: Color.fromARGB(100, 239, 176, 8),
        ),
      ),
    );
  } else if (eStatus == "F") {
    // [F/Fail] mean event is fail
    return Container(
      padding: EdgeInsets.symmetric(vertical: ver, horizontal: hor),
      margin: EdgeInsets.only(left: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Color.fromARGB(100, 253, 235, 235),
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
