import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UserService {
  Future<void> updateProfileImage(File file, String uid) async {
    log('updateProfileImage');
    final storageRef = FirebaseStorage.instance
        .ref()
        .child('user_profile_images')
        .child('$uid.jpg');
    log('upload start');
    await storageRef.putFile(file);
    log('upload end');
    final downloadUrl = await storageRef.getDownloadURL();

    await FirebaseFirestore.instance.collection('users').doc(uid).update({
      'profileImageUrl': downloadUrl,
    });
  }
}
