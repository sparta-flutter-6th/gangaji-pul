import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CommentBottomSheet extends StatefulWidget {
  const CommentBottomSheet({super.key});

  @override
  State<CommentBottomSheet> createState() => _CommentBottomSheetState();
}

class _CommentBottomSheetState extends State<CommentBottomSheet> {
  final TextEditingController _controller = TextEditingController();

  // 초기 댓글
  final List<Map<String, dynamic>> _comments = [
    {
      'user': '익명1',
      'text': '강아지 귀여워요',
      'timestamp': DateTime.now().subtract(const Duration(hours: 1)),
    },
    {
      'user': '익명2',
      'text': '그쪽도요',
      'timestamp': DateTime.now().subtract(const Duration(minutes: 30)),
    },
  ];

  //더미 유저
  void _submit() {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        _comments.add({
          'user': '익명',
          'text': text,
          'timestamp': DateTime.now(),
        });
      });
      _controller.clear();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              height: 450, //댓글창 높이
              child: ListView.separated(
                itemCount: _comments.length,
                separatorBuilder: (_, __) => const Divider(), //가로구분선
                itemBuilder: (context, index) {
                  final comment = _comments[index];
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      comment['user'],
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(comment['text']),
                    trailing: Text(
                      DateFormat('HH:mm').format(comment['timestamp']),
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
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
              maxLines: 1,
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
