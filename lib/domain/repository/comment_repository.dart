import '../entity/comment.dart';

abstract class CommentRepository {
  Future<List<Comment>> fetchComments(String postId);
  Future<void> addComment(String postId, Comment comment);
}
