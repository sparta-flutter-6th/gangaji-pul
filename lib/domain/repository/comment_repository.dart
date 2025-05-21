import '../entity/comment_entity.dart';

abstract class CommentRepository {
  Future<List<Comment>> fetchComments(String postId);
  Future<void> addComment(String postId, Comment comment);
  Future<void> deleteComment(String postId, String commentId);
}
