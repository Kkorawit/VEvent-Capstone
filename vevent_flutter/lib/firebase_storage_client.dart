
// import 'dart:html';

import 'package:firebase_storage/firebase_storage.dart';


  Future<String> getDownloadURL() async {
    // final storage = FirebaseStorage.instance.ref();
    // final images = storage.child("NK-2/Poster_image/");
    // final dashImageRef = images.child("dash.gif");
    // final networkTmageUrl = await dashImageRef.getDownloadURL();
    try {
      return await FirebaseStorage.instance
          .ref()
          .child("NK-2/Poster_image/event01.png")
          .getDownloadURL();
    } catch (e) {
      return "assets/images/poster.png";
    }
  }

