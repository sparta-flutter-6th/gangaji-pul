import 'package:gangaji_pul/domain/entity/post_view_entity.dart';

abstract interface class PostRepository {
  Future<void> createPost({
    required String content,
    required List<String> tags,
    required String imageUrl,
    required String userId,
    required String userName,
    required String userProfileImage,
  });
  Future<PostViewEntity> getPost();
}
