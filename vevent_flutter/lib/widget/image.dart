import 'package:flutter/material.dart';

Widget getProfileImage(img) {
  print("this is owner profile = " + img);
  if (img == "") {
    return const CircularProgressIndicator();
  } else {
    return Image.network(img);
  }
}

Widget getEventImage(img) {
  if (img == null) {
    return Image.asset(
      "assets/images/poster.png",
      fit: BoxFit.cover,
    );
  } else {
    // return Image.asset(
    //   "assets/images/poster.png",
    //   fit: BoxFit.cover,
    // );
    return Image.network(
      img,
      fit: BoxFit.fitHeight,
    );
  }
}

