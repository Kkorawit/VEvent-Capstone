
import 'package:firebase_storage/firebase_storage.dart';


  Future<String> getDownloadURL() async {
    try {
      return await FirebaseStorage.instance
          .ref()
          .child("gs://vevent-capstone.appspot.com/NK-2/Poster_image/event01.png")
          .getDownloadURL();
    } catch (e) {
      return "assets/images/poster.png";
    }
  }

