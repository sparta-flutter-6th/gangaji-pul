import 'package:gangaji_pul/data/dto/post_dto.dart';

abstract interface class PostDataSource {
  Future<PostDto> getPost();
  Future<void> createPost(PostDto postDto);
}
