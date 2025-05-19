import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gangaji_pul/data/dto/comment_dto.dart';
import '../../domain/entity/comment.dart';
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

    return snapshot.docs
        .map((doc) => CommentDto.fromJson(doc.data(), doc.id))
        .map(
          (dto) => Comment(
            id: dto.id,
            userId: dto.userId,
            userName: dto.userName,
            text: dto.text,
            timestamp: dto.timestamp,
          ),
        )
        .toList();
  }

  @override
  Future<void> addComment(String postId, Comment comment) async {
    final dto = CommentDto(
      id: comment.id,
      userId: comment.userId,
      userName: comment.userName,
      text: comment.text,
      timestamp: comment.timestamp,
    );

    await firestore
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .add(dto.toJson());
  }
}
