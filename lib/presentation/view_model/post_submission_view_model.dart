import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gangaji_pul/data/data_source/user_data_source.dart';
import 'package:gangaji_pul/data/providers/post_repository_provider.dart';
import 'package:gangaji_pul/data/providers/user_data_source_provider.dart';
import 'package:gangaji_pul/domain/entity/user_model.dart';
import 'package:gangaji_pul/domain/repository/post_repository.dart';
import 'package:uuid/uuid.dart';

final postSubmissionViewModelProvider = Provider((ref) {
  final postRepository = ref.read(postRepositoryProvider);
  final userRemoteDataSource = ref.read(userDataSourceProvider);
  return PostSubmissionViewModel(
    repository: postRepository,
    userRemoteDataSource: userRemoteDataSource,
  );
});

class PostSubmissionViewModel {
  final PostRepository repository;
  final UserDataSource userRemoteDataSource;

  PostSubmissionViewModel({
    required this.repository,
    required this.userRemoteDataSource,
  });

  Future<void> createPost({
    required String content,
    required List<String> tags,
    required File imageFile,
    required UserModel user,
  }) async {
    try {
      // 1. 유저 정보 바로 사용
      final fileName = const Uuid().v4();
      final ref = FirebaseStorage.instance.ref().child(
        "post_images/$fileName.jpg",
      );
      final uploadTask = await ref.putFile(imageFile);
      final imageUrl = await uploadTask.ref.getDownloadURL();

      // 2. Post 저장
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
