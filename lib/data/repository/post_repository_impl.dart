import 'package:gangaji_pul/data/data_source/post_data_source.dart';
import 'package:gangaji_pul/domain/entity/post_view_entity.dart';
import 'package:gangaji_pul/domain/repository/post_repository.dart';

class PostRepositoryImpl implements PostRepository {
  final PostDataSource _dataSource;

  PostRepositoryImpl(this._dataSource);

  @override
  Future<void> createPost() {
    // TODO: implement createPost
    throw UnimplementedError();
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
      userId: dto.userId,
    );
  }
}
