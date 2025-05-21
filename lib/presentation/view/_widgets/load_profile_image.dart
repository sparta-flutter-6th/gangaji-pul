import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gangaji_pul/domain/entity/user_model.dart';
import 'package:image_picker/image_picker.dart';

class LoadProfileImage extends StatelessWidget {
  const LoadProfileImage({super.key, required this.user, required this.size});

  final UserModel user;
  final double size;

  Future<void> _pickImage(String uid) async {
    final picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile == null) return;

    final refStorage = FirebaseStorage.instance.ref().child(
      'userProfileImages/$uid.jpg',
    );
    final file = File(pickedFile.path);

    try {
      log('업로드 시작');
      await refStorage.putFile(file);
      log('업로드 완료');

      final downloadUrl = await refStorage.getDownloadURL();

      log('프로필 url : $downloadUrl');

      await FirebaseFirestore.instance.collection('users').doc(uid).update({
        'profileImageUrl': downloadUrl,
      });
    } catch (e) {
      log('이미지 업로드 중 오류 발생: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Image.network(
        user.profileImageUrl,
        frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
          if (wasSynchronouslyLoaded || frame != null) {
            return child;
          } else {
            return SizedBox.square(
              dimension: size,
              child: Center(child: CircularProgressIndicator()),
            );
          }
        },
        errorBuilder: (context, error, stackTrace) {
          return const Icon(Icons.error); // 에러 시 대체 아이콘
        },
        width: size,
        height: size,
        fit: BoxFit.cover,
      ),
    );
  }
}
