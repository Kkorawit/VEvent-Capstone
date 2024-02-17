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

// Widget getUProfileImage(img) {
//   debugPrint("this is owner profile = $img");
//   if (img == null) {
//     return Image.asset("assets/images/default_profile.png");
//   } else {
//     return Image.network(img, fit: BoxFit.cover);
//   }
// }

Widget getUProfileImage(img) {
  debugPrint("this is owner profile = $img");
  if (img == "") {
    return Container(
      width: 48,
      height: 48,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        image: DecorationImage(
            image: AssetImage("./assets/images/default_profile.png")),
      ),
    );
  } else {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        image: DecorationImage(image: NetworkImage(img)),
      ),
    );
  }
}
