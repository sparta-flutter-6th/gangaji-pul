import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entity/comment_entity.dart';
import '../../domain/repository/comment_repository.dart';
import '../providers/comment_provider.dart';

final commentListProvider =
    StateNotifierProviderFamily<CommentListViewModel, List<Comment>, String>((
      ref,
      postId,
    ) {
      final repository = ref.watch(commentRepositoryProvider);
      return CommentListViewModel(repository, postId);
    });

class CommentListViewModel extends StateNotifier<List<Comment>> {
  final CommentRepository repository;
  final String postId;

  CommentListViewModel(this.repository, this.postId) : super([]) {
    _loadComments();
  }

  Future<void> _loadComments() async {
    final comments = await repository.fetchComments(postId);
    state = comments;
  }

  Future<void> addComment(Comment comment) async {
    await repository.addComment(postId, comment);
    // reload to ensure new Firestore doc ID is included
    await _loadComments();
  }

  Future<void> deleteComment(String commentId) async {
    await repository.deleteComment(postId, commentId);
    await _loadComments();
  }
}
