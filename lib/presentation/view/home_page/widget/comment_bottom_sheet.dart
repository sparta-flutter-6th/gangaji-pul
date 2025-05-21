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
  Comment? replyingTo; // 현재 답글 대상 댓글

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // 댓글 등록
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
        parentId: replyingTo?.id, // 답글이면 parentId 포함
      );

      await ref
          .read(commentListProvider(widget.postId).notifier)
          .addComment(comment);
      _controller.clear();
      setState(() => replyingTo = null); // 답글 초기화
    }
  }

  // 댓글 삭제
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

    // 댓글과 답글 분리
    final parentComments = comments.where((c) => c.parentId == null).toList();
    // 답글을 parentId 기준으로 묶기
    final repliesMap = <String, List<Comment>>{};
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
            // 총 댓글 수
            Text(
              "댓글 (${comments.length})",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            // 댓글과 답글 목록
            SizedBox(
              height: 450, // 댓글 영역 높이
              child: ListView.builder(
                itemCount: parentComments.length,
                itemBuilder: (context, index) {
                  final parent = parentComments[index];
                  final isReplyTarget = replyingTo?.id == parent.id;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 일반 댓글
                      _buildCommentTile(
                        parent,
                        currentUser,
                        isReplyTarget,
                        isReply: false,
                      ),
                      // 해당 댓글의 답글 리스트
                      if (repliesMap[parent.id] != null)
                        ...repliesMap[parent.id]!.map(
                          (reply) => Padding(
                            padding: const EdgeInsets.only(left: 24),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "ㄴ ",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey,
                                  ),
                                ),
                                Expanded(
                                  child: _buildCommentTile(
                                    reply,
                                    currentUser,
                                    false,
                                    isReply: true,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      const Divider(), // 댓글 구분선
                    ],
                  );
                },
              ),
            ),

            const SizedBox(height: 8),

            // 답글 작성 중 표시
            if (replyingTo != null)
              Row(
                children: [
                  const Icon(Icons.reply, size: 16),
                  const SizedBox(width: 4),
                  Text(
                    '${replyingTo!.userName}님에게 답글 작성 중...',
                    style: const TextStyle(fontSize: 12),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () => setState(() => replyingTo = null),
                    child: const Text("취소"),
                  ),
                ],
              ),

            // 댓글 입력창
            TextField(
              controller: _controller,
              minLines: 1,
              maxLines: 5,
              decoration: const InputDecoration(
                hintText: "댓글을 입력하세요",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),

            // 작성 버튼
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

  /// 댓글 구성
  Widget _buildCommentTile(
    Comment comment,
    User? currentUser,
    bool isReplyTarget, {
    required bool isReply,
  }) {
    final backgroundColor =
        isReply
            ? const Color(0xFFF4F1E9) // 답글 배경색
            : const Color(0xFFF0F0F0); // 댓글 배경색

    return Container(
      decoration: BoxDecoration(
        color: isReplyTarget ? const Color(0xFFE6EEDD) : backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      margin: const EdgeInsets.symmetric(vertical: 2),
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: ListTile(
        dense: true,
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
                // 작성 시간
                Text(
                  DateFormat('HH:mm').format(comment.timestamp),
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const Spacer(),

                // 메뉴: 댓글은 답글+삭제, 답글은 삭제만
                Row(
                  children: [
                    if (!isReply)
                      IconButton(
                        onPressed: () => setState(() => replyingTo = comment),
                        icon: const Icon(Icons.reply, size: 16),
                      ),
                    PopupMenuButton<String>(
                      onSelected: (value) {
                        if (value == 'delete') {
                          _deleteComment(comment.id);
                        }
                      },
                      itemBuilder:
                          (_) => [
                            if (currentUser?.uid == comment.userId)
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
          ],
        ),
      ),
    );
  }
}
