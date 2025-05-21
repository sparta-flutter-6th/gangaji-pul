import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class LoadProfileImage extends ConsumerWidget {
  const LoadProfileImage({super.key, required this.uid, required this.size});

  final String uid;
  final double size;

  Future<void> _pickImage(String uid, WidgetRef ref) async {
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
  Widget build(BuildContext context, WidgetRef ref) {
    return StreamBuilder<DocumentSnapshot>(
      stream:
          FirebaseFirestore.instance.collection('users').doc(uid).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _loadingWidget();
        }

        if (snapshot.hasError) {
          log('Stream error: ${snapshot.error}');
          return _defaultImage(ref);
        }

        if (!snapshot.hasData || !snapshot.data!.exists) {
          return _defaultImage(ref);
        }

        final data = snapshot.data!.data() as Map<String, dynamic>;
        final imageUrl = data['profileImageUrl'] as String?;

        if (imageUrl == null || imageUrl.isEmpty) {
          return _defaultImage(ref);
        }

        return ClipOval(
          child: Image.network(
            imageUrl,
            width: size,
            height: size,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return _loadingWidget();
            },
            errorBuilder: (context, error, stackTrace) {
              return _defaultImage(ref);
            },
          ),
        );
      },
    );
  }

  Widget _defaultImage(WidgetRef ref) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 2),
        borderRadius: BorderRadius.circular(100),
        color: Color(0XFF332121),
      ),
      child: IconButton(
        onPressed: () async {
          await _pickImage(uid, ref);
        },
        icon: Icon(Icons.camera_alt, size: 50, color: Colors.grey),
      ),
    );
  }

  Widget _loadingWidget() {
    return SizedBox(
      width: size,
      height: size,
      child: const CircularProgressIndicator(),
    );
  }
}
