import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gangaji_pul/data/data_source/post_data_source.dart';
import 'package:gangaji_pul/data/dto/post_dto.dart';
import 'package:gangaji_pul/domain/entity/post_view_entity.dart';
import 'package:gangaji_pul/domain/repository/post_repository.dart';

class PostRepositoryImpl implements PostRepository {
  final PostDataSource _dataSource;
  final FirebaseFirestore _firestore;

  PostRepositoryImpl(this._dataSource, this._firestore);

  @override
  Future<void> createPost({
    required String content,
    required List<String> tags,
    required String imageUrl,
    required String userId,
    required String userName,
    required String userProfileImage,
  }) async {
    final docRef = _firestore.collection('posts').doc(); // 자동 생성 postId
    final now = DateTime.now();

    final postDto = PostDto(
      postId: docRef.id,
      content: content,
      tags: tags,
      imageUrl: imageUrl,
      createdAt: now,
      updatedAt: now,
      userId: userId,
      userName: userName,
      userProfileImage: userProfileImage,
      likeCount: 0,
      commentCount: 0,
    );

    await _dataSource.createPost(postDto); // 실제 저장
  }

  @override
  Future<PostViewEntity> getPost() async {
    final dto = await _dataSource.getPost(); // fetch from Firebase
    return PostViewEntity(
      content: dto.content,
      createdAt: dto.createdAt,
      imageUrl: dto.imageUrl,
      postId: dto.postId,
      tags: dto.tags,
      userName: dto.userName,
    );
  }
}
