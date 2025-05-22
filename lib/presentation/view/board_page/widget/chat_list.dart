import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gangaji_pul/domain/entity/chat_entity.dart';
import 'package:gangaji_pul/presentation/providers/chat_view_model_provider.dart';
import 'package:timeago/timeago.dart' as timeago;

class ChatList extends ConsumerStatefulWidget {
  const ChatList({super.key});

  @override
  ConsumerState<ChatList> createState() => _ChatListState();
}

class _ChatListState extends ConsumerState<ChatList> {
  final ScrollController _scrollController = ScrollController();

  List<Chat> _previousChats = [];
  @override
  void initState() {
    super.initState();
    timeago.setLocaleMessages('ko', timeago.KoMessages());
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(_scrollController.position.minScrollExtent, duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final chatsAsync = ref.watch(chatViewModelProvider);

    return chatsAsync.when(
      data: (chats) {
        if (chats.length != _previousChats.length) {
          _scrollToBottom();
          _previousChats = chats;
        }

        return Expanded(
          child: ListView.builder(
            controller: _scrollController,
            reverse: true,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: chats.length,
            itemBuilder: (context, index) {
              final chat = chats[index];
              return _chatCard(chat);
            },
          ),
        );
      },
      loading: () => Expanded(child: const Center(child: CircularProgressIndicator())),
      error: (e, _) => Center(child: Text('에러 발생: $e')),
    );
  }

  Widget _chatCard(Chat chat) {
    final userCache = ref.read(chatViewModelProvider.notifier).userCache;

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 30,
                  height: 30,
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  child:
                      _isProfileImageUrlValid(userCache[chat.user.id]?.profileImageUrl)
                          ? Image.network(userCache[chat.user.id]!.profileImageUrl, fit: BoxFit.cover)
                          : const Icon(Icons.person),
                ),
                const SizedBox(width: 8),
                Text(userCache[chat.user.id]?.name ?? '익명', style: const TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 8),
            Text(chat.message),
            const SizedBox(height: 4),
            Text(timeago.format(chat.createdAt, locale: 'ko'), style: TextStyle(color: Colors.grey.shade500, fontSize: 12)),
          ],
        ),
      ),
    );
  }

  bool _isProfileImageUrlValid(String? imageUrl) {
    return imageUrl != null && imageUrl.isNotEmpty;
  }
}
