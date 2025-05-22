import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gangaji_pul/data/dto/comment_dto.dart';
import '../../domain/entity/comment_entity.dart';
import '../../domain/repository/comment_repository.dart';

class CommentRepositoryImpl implements CommentRepository {
  final FirebaseFirestore firestore;

  CommentRepositoryImpl(this.firestore);

  @override
  Future<List<Comment>> fetchComments(String postId) async {
    final snapshot =
        await firestore
            .collection('posts')
            .doc(postId)
            .collection('comments')
            .orderBy('timestamp')
            .get();

    return snapshot.docs.map((doc) {
      final dto = CommentDto.fromJson(doc.data());
      return dto.toEntity(doc.id);
    }).toList();
  }

  @override
  Future<void> addComment(String postId, Comment comment) async {
    final dto = CommentDto.fromEntity(comment);
    await firestore
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .add(dto.toJson());
  }

  @override
  Future<void> deleteComment(String postId, String commentId) async {
    await firestore
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .doc(commentId)
        .delete();
  }
}
