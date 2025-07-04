import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gangaji_pul/domain/entity/user_model.dart';
import 'package:gangaji_pul/presentation/providers/rank_stream_provider.dart';
import 'package:image_picker/image_picker.dart';

class LoadProfileImage extends ConsumerWidget {
  const LoadProfileImage({super.key, required this.user, required this.size});

  final UserModel user;
  final double size;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final topUsersByLikeCount = ref.watch(likeRankProvider);
    final topUsersByPostCount = ref.watch(postRankProvider);
    final topUsersByChatCount = ref.watch(chatRankProvider);
    final isTopByLike = topUsersByLikeCount.asData?.value?.any((u) => u.user.uid == user.uid) ?? false;
    final isTopByPost = topUsersByPostCount.asData?.value?.any((u) => u.user.uid == user.uid) ?? false;
    final isTopByChat = topUsersByChatCount.asData?.value?.any((u) => u.user.uid == user.uid) ?? false;

    return SizedBox.square(
      dimension: size,
      child: Stack(
        children: [
          Center(
            child: SizedBox.square(
              dimension: size - 10,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.network(
                  user.profileImageUrl,
                  frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                    if (wasSynchronouslyLoaded || frame != null) {
                      return child;
                    } else {
                      return SizedBox.square(dimension: size, child: Center(child: CircularProgressIndicator()));
                    }
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: size,
                      height: size,
                      decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.grey, width: 4), color: Color(0XFF332121)),
                      child: IconButton(
                        onPressed: () {
                          _pickImage(user.uid);
                        },
                        icon: Icon(Icons.camera_alt, size: size / 2, color: Colors.grey),
                      ),
                    );
                  },
                  width: size,
                  height: size,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          isTopByPost ? SizedBox.square(dimension: size, child: Image.asset('assets/images/profile_border.png')) : SizedBox(),
          isTopByChat ? SizedBox.square(dimension: size, child: Image.asset('assets/images/profile_border.png')) : SizedBox(),
          isTopByLike ? SizedBox.square(dimension: size, child: Image.asset('assets/images/profile_border.png')) : SizedBox(),
        ],
      ),
    );
  }

  Future<void> _pickImage(String uid) async {
    final picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) return;

    final refStorage = FirebaseStorage.instance.ref().child('userProfileImages/$uid.jpg');
    final file = File(pickedFile.path);

    try {
      log('업로드 시작');
      await refStorage.putFile(file);
      log('업로드 완료');

      final downloadUrl = await refStorage.getDownloadURL();

      log('프로필 url : $downloadUrl');

      await FirebaseFirestore.instance.collection('users').doc(uid).update({'profileImageUrl': downloadUrl});
    } catch (e) {
      log('이미지 업로드 중 오류 발생: $e');
    }
  }
}
