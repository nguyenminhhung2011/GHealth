import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class StorageMethods {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<String> UploadImageStorage(
      String childName, Uint8List file, bool isPost) async {
    Reference ref =
        _storage.ref().child(childName).child(_auth.currentUser!.uid);

    if (isPost) {
      String child = const Uuid().v1();
      ref = ref.child(child);
    }
    UploadTask upLoadTask = ref.putData(file);
    TaskSnapshot snap = await upLoadTask;
    String dowloadUrl = await snap.ref.getDownloadURL();
    return dowloadUrl;
  }

  Future<String> UpLoadImageGroupToStorage(String child, Uint8List file) async {
    Reference ref = _storage.ref().child('GroupPics').child(child);

    UploadTask upLoadTask = ref.putData(file);
    TaskSnapshot snap = await upLoadTask;
    String dowloadUrl = await snap.ref.getDownloadURL();
    return dowloadUrl;
  }
}
