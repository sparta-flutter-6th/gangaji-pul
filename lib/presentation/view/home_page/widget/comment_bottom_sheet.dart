import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gangaji_pul/const/color_const.dart';
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
  Comment? replyingTo;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final comments = ref.watch(commentListProvider(widget.postId));
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    final currentUser = FirebaseAuth.instance.currentUser;

    final parentComments = comments.where((c) => c.parentId == null).toList();
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
          color: backgroundColor,
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
              height: MediaQuery.of(context).size.height * 0.65,
              child: ListView.builder(
                itemCount: parentComments.length,
                itemBuilder: (context, index) {
                  final parent = parentComments[index];
                  final isReplyTarget = replyingTo?.id == parent.id;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildCommentTile(
                        parent,
                        currentUser,
                        isReplyTarget,
                        isReply: false,
                      ),
                      if (repliesMap[parent.id] != null)
                        ...repliesMap[parent.id]!.map(
                          (reply) => Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(
                                  Icons.subdirectory_arrow_right,
                                  size: 16,
                                  color: Colors.grey,
                                ),
                                const SizedBox(width: 4),
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
                      const Divider(),
                    ],
                  );
                },
              ),
            ),

            const SizedBox(height: 8),

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
              maxLines: 3,
              decoration: InputDecoration(
                hintText: "댓글을 입력하세요",
                border: const OutlineInputBorder(),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.send, color: accentGreenColor),
                  onPressed: _submit,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 댓글 렌더링 위젯
  Widget _buildCommentTile(
    Comment comment,
    User? currentUser,
    bool isReplyTarget, {
    required bool isReply,
  }) {
    final commentColor = isReply ? const Color(0xFFF3E8DA) : backgroundColor;

    return Container(
      decoration: BoxDecoration(
        color: isReplyTarget ? const Color(0xFFE6EEDD) : commentColor,
        borderRadius: BorderRadius.circular(8),
      ),
      margin: const EdgeInsets.symmetric(vertical: 2),
      padding: const EdgeInsets.fromLTRB(12, 6, 8, 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 유저명, 본문, 아이콘 한 줄 정렬
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      comment.userName,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: isReply ? 13 : 14,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      comment.text,
                      style: TextStyle(fontSize: isReply ? 12 : 13),
                    ),
                  ],
                ),
              ),
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
                        const PopupMenuItem(value: 'delete', child: Text('삭제')),
                    ],
                icon: const Icon(Icons.more_vert, size: 16),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            DateFormat('HH:mm').format(comment.timestamp),
            style: const TextStyle(fontSize: 11, color: Colors.grey),
          ),
        ],
      ),
    );
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
        parentId: replyingTo?.id,
      );

      await ref
          .read(commentListProvider(widget.postId).notifier)
          .addComment(comment);
      _controller.clear();
      setState(() => replyingTo = null);
    }
  }

  // 댓글 삭제
  void _deleteComment(String commentId) async {
    await ref
        .read(commentListProvider(widget.postId).notifier)
        .deleteComment(commentId);
  }
}
