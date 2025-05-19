import 'package:gangaji_pul/data/data_source/like_data_source.dart';
import 'package:gangaji_pul/domain/repository/post_like_repository.dart';

class PostLikeRepositoryImpl implements PostLikeRepository {
  final PostLikeDataSource _dataSource;

  PostLikeRepositoryImpl(this._dataSource);

  @override
  Future<bool> isPostLikedByUser(String postId, String userId) async {
    return await _dataSource.isPostLikedByUser(postId, userId);
  }

  @override
  Future<void> likePost(String postId, String userId) async {
    await _dataSource.likePost(postId, userId);
  }

  @override
  Future<void> unlikePost(String postId, String userId) async {
    await _dataSource.unlikePost(postId, userId);
  }
}
