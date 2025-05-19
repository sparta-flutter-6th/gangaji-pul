abstract interface class PostLikeRepository {
  Future<bool> isPostLikedByUser(String postId, String userId);
  Future<void> likePost(String postId, String userId);
  Future<void> unlikePost(String postId, String userId);
}
