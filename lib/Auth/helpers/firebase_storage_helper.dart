import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageHelper {
  FirebaseStorageHelper._();
  static final firebaseStorageHelper = FirebaseStorageHelper._();
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  Future<String> uploadFile(File file) async {
    String path = 'images/profiles/${file.path.split('/').last}';
    try {
      Reference ref = firebaseStorage.ref(path);
      await ref.putFile(file);
      String imageUrl = await ref.getDownloadURL();
      return imageUrl;
    } on FirebaseException catch (e) {
      print(e.toString());
    }
  }
}
