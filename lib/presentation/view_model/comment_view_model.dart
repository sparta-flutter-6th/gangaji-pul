import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entity/comment_entity.dart';
import '../../domain/repository/comment_repository.dart';
import '../providers/comment_provider.dart';

/// 댓글 목록을 관리하는 ViewModel을 생성하는 Provider
final commentListProvider =
    StateNotifierProviderFamily<CommentListViewModel, List<Comment>, String>((
      ref,
      postId,
    ) {
      final repository = ref.watch(commentRepositoryProvider);
      return CommentListViewModel(repository, postId);
    });

/// 댓글 목록 상태를 관리하는 ViewModel 클래스
class CommentListViewModel extends StateNotifier<List<Comment>> {
  final CommentRepository repository;
  final String postId;

  CommentListViewModel(this.repository, this.postId) : super([]) {
    _loadComments();
  }

  /// Firestore에서 댓글 목록을 가져와 상태로 설정
  Future<void> _loadComments() async {
    final comments = await repository.fetchComments(postId);
    state = comments;
  }

  // 댓글을 기존 상태에 추가 (아래에 추가됨)
  Future<void> addComment(Comment comment) async {
    await repository.addComment(postId, comment);
    state = [...state, comment];
  }
}
