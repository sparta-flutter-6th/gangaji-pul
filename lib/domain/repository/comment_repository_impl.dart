import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gangaji_pul/data/dto/comment_dto.dart';
import '../entity/comment_entity.dart';
import '../../domain/repository/comment_repository.dart';

/// Firestore에 접근하여 댓글을 불러오거나 저장
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
    // Firestore 문서들을 DTO로 변환 → Entity로 변환 후 리스트로 반환
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
    // posts/{postId}/comments 경로에 Firestore 문서 추가
    await firestore
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .add(dto.toJson());
  }
}
