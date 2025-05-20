import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gangaji_pul/data/data_source/user_remote_data_source.dart';
import 'package:gangaji_pul/data/providers/post_repository_provider.dart';
import 'package:gangaji_pul/domain/entity/user_model.dart';
import 'package:gangaji_pul/domain/repository/post_repository.dart';
import 'package:uuid/uuid.dart';

final postSubmissionViewModelProvider = Provider((ref) {
  final postRepository = ref.read(postRepositoryProvider);
  final userRemoteDataSource = UserRemoteDataSource(FirebaseFirestore.instance);
  return PostSubmissionViewModel(
    repository: postRepository,
    userRemoteDataSource: userRemoteDataSource,
  );
});

class PostSubmissionViewModel {
  final PostRepository repository;
  final UserRemoteDataSource userRemoteDataSource;

  PostSubmissionViewModel({
    required this.repository,
    required this.userRemoteDataSource,
  });

  Future<void> createPost({
    required String content,
    required List<String> tags,
    required File imageFile,
  }) async {
    try {
      // 1. 로그인 유저 확인
      final firebaseUser = FirebaseAuth.instance.currentUser;
      if (firebaseUser == null) throw Exception("로그인 필요");

      // 2. 유저 정보 조회
      final UserModel? user = await userRemoteDataSource.getUserByUid(firebaseUser.uid);
      if (user == null) throw Exception("사용자 정보 없음");

      // 3. 이미지 Storage에 업로드
      final fileName = const Uuid().v4();
      final ref = FirebaseStorage.instance.ref().child("post_images/$fileName.jpg");
      final uploadTask = await ref.putFile(imageFile);
      final imageUrl = await uploadTask.ref.getDownloadURL();

      // 4. PostRepository로 글 생성
      await repository.createPost(
        content: content,
        tags: tags,
        imageUrl: imageUrl,
        userId: user.uid,
        userName: user.nickname.isNotEmpty ? user.nickname : user.name,
        userProfileImage: user.profileImageUrl,
      );
    } catch (e) {
      print("게시글 작성 실패: $e");
      rethrow;
    }
  }
}
