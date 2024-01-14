import 'package:flutter/material.dart';

Widget getProfileImage(img) {
  print("this is owner profile = " + img);
  if (img == "") {
    return const CircularProgressIndicator();
  } else {
    return Image.network(img);
  }
}

Widget getEventImage(img)  {
  if (img == null) {
    return Image.asset(
      "assets/images/poster.png",
      fit: BoxFit.cover,
    );
  } else {
  try{
    return Image.network(img, fit: BoxFit.fitHeight,);
  }catch(e){
    print(e.toString());
    return const CircularProgressIndicator();
  }
  }
}

