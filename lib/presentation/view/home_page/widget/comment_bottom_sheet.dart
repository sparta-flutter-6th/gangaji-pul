import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../../domain/entity/comment.dart';
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
        id: '', // Firestore에서 자동 생성됨
        userId: user.uid,
        userName: user.displayName ?? '익명',
        text: text,
        timestamp: DateTime.now(),
      );
      await ref
          .read(commentListProvider(widget.postId).notifier)
          .addComment(comment);
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final comments = ref.watch(commentListProvider(widget.postId));
    final bottom = MediaQuery.of(context).viewInsets.bottom;

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
            const Text(
              "댓글",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 300,
              child: ListView.separated(
                itemCount: comments.length,
                separatorBuilder: (_, __) => const Divider(),
                itemBuilder: (context, index) {
                  final comment = comments[index];
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      comment.userName,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(comment.text),
                    trailing: Text(
                      DateFormat('HH:mm').format(comment.timestamp),
                      style: const TextStyle(fontSize: 12),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: "댓글을 입력하세요",
                border: OutlineInputBorder(),
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: _submit,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[700],
              ),
              child: const Text("작성하기", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
