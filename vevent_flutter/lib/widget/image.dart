import 'package:flutter/material.dart';

Widget getProfileImage(img) {
  debugPrint("this is owner profile = $img");
  if (img == "") {
    return const CircularProgressIndicator();
  } else {
    return Image.network(img, fit: BoxFit.cover);
  }
}

Widget getEventImage(img) {
  if (img == null) {
    return Image.asset(
      "assets/images/poster.png",
      fit: BoxFit.cover,
    );
  } else {
    try {
      return Image.network(
        img,
        fit: BoxFit.fitHeight,
      );
    } catch (e) {
      debugPrint(e.toString());
      return const CircularProgressIndicator();
    }
  }
}
