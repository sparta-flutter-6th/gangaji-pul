import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../../domain/entity/comment_entity.dart';
import '../../../view_model/comment_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CommentBottomSheet extends ConsumerStatefulWidget {
  final String postId;

  const CommentBottomSheet({super.key, required this.postId});

  @override
  ConsumerState<CommentBottomSheet> createState() => _CommentBottomSheetState();
}

class _CommentBottomSheetState extends ConsumerState<CommentBottomSheet> {
  final TextEditingController _controller = TextEditingController();
  String? replyingToId; // 답글 대상 댓글 ID

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      final comment = Comment(
        id: '',
        userId: user.uid,
        userName: user.displayName ?? '익명',
        text: text,
        timestamp: DateTime.now(),
        parentId: replyingToId,
      );
      await ref
          .read(commentListProvider(widget.postId).notifier)
          .addComment(comment);
      _controller.clear();
      setState(() => replyingToId = null); // 답글 완료 후 초기화
    }
  }

  void _deleteComment(String commentId) async {
    await ref
        .read(commentListProvider(widget.postId).notifier)
        .deleteComment(commentId);
  }

  @override
  Widget build(BuildContext context) {
    final comments = ref.watch(commentListProvider(widget.postId));
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    final currentUser = FirebaseAuth.instance.currentUser;

    // 댓글을 parentId 기준으로 분류
    final parentComments = comments.where((c) => c.parentId == null).toList();
    final Map<String, List<Comment>> repliesMap = {};
    for (var comment in comments) {
      if (comment.parentId != null) {
        repliesMap.putIfAbsent(comment.parentId!, () => []).add(comment);
      }
    }

    return Padding(
      padding: EdgeInsets.only(bottom: bottom),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Color(0xFFF4F1E9),
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "댓글 (${comments.length})",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            // 댓글 목록
            SizedBox(
              height: 450,
              child: ListView.builder(
                itemCount: parentComments.length,
                itemBuilder: (context, index) {
                  final parent = parentComments[index];
                  final isReplyTarget = replyingToId == parent.id;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildCommentTile(parent, currentUser, isReplyTarget),
                      if (repliesMap.containsKey(parent.id))
                        ...repliesMap[parent.id!]!.map(
                          (reply) => Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: _buildCommentTile(reply, currentUser, false),
                          ),
                        ),
                    ],
                  );
                },
              ),
            ),

            const SizedBox(height: 12),
            if (replyingToId != null)
              Row(
                children: [
                  const Icon(Icons.reply, size: 16),
                  const SizedBox(width: 4),
                  const Text('답글 작성 중...', style: TextStyle(fontSize: 12)),
                  const Spacer(),
                  TextButton(
                    onPressed: () => setState(() => replyingToId = null),
                    child: const Text("취소"),
                  ),
                ],
              ),
            TextField(
              controller: _controller,
              minLines: 1,
              maxLines: 4,
              decoration: const InputDecoration(
                hintText: "댓글을 입력하세요",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: _submit,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF688F4E),
              ),
              child: const Text("작성하기", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCommentTile(
    Comment comment,
    User? currentUser,
    bool isReplyTarget,
  ) {
    return Container(
      color: isReplyTarget ? const Color(0xFFE6EEDD) : null,
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(
          comment.userName,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(comment.text),
            const SizedBox(height: 4),
            Row(
              children: [
                Text(
                  DateFormat('HH:mm').format(comment.timestamp),
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const Spacer(),
                PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == 'reply') {
                      setState(() => replyingToId = comment.id);
                    } else if (value == 'delete') {
                      _deleteComment(comment.id);
                    }
                  },
                  itemBuilder:
                      (_) => [
                        const PopupMenuItem(value: 'reply', child: Text('답글')),
                        if (currentUser != null &&
                            currentUser.uid == comment.userId)
                          const PopupMenuItem(
                            value: 'delete',
                            child: Text('삭제'),
                          ),
                      ],
                  icon: const Icon(Icons.more_vert, size: 16),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
