import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gangaji_pul/presentation/providers/chat_view_model_provider.dart';

class ChatInput extends ConsumerStatefulWidget {
  const ChatInput({super.key});

  @override
  ConsumerState<ChatInput> createState() => _ChatInputState();
}

class _ChatInputState extends ConsumerState<ChatInput> {
  final TextEditingController _controller = TextEditingController();

  Future<void> _onSendPressed() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    await ref.read(chatViewModelProvider.notifier).sendChat(text);
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser;

    if (uid == null) {
      return SizedBox();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: "대화를 시작해보세요",
                fillColor: Colors.white,
                filled: true,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
              ),
              onSubmitted: (_) => _onSendPressed(),
            ),
          ),
          const SizedBox(width: 8),
          IconButton(onPressed: _onSendPressed, icon: const Icon(Icons.send), color: Theme.of(context).primaryColor),
        ],
      ),
    );
  }
}
