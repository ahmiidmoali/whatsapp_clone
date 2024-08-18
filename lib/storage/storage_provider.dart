import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class StorageProviderRemoteDataSource {
  static FirebaseStorage _storage = FirebaseStorage.instance;

  static Future<String> uploadProfileImage(
      {required File file, Function(bool isUploading)? onComplete}) async {
    onComplete!(true);
    final Reference ref = _storage
        .ref()
        .child("profile/${DateTime.now().millisecondsSinceEpoch}");
    final UploadTask uploadTask = ref.putData(
        await file.readAsBytes(), SettableMetadata(contentType: 'image/png'));

    final imageUrl = (await uploadTask.whenComplete(
      () {},
    ))
        .ref
        .getDownloadURL();
    onComplete(false);
    return imageUrl;
  }
}
