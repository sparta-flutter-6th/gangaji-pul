import 'package:gangaji_pul/domain/entity/post_view_entity.dart';

abstract interface class PostRepository {
  Future<void> createPost();
  Future<PostViewEntity> getPost();
}
