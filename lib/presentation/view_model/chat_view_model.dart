import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gangaji_pul/data/providers/chat_repository_provider.dart';
import 'package:gangaji_pul/data/providers/user_providers.dart';
import 'package:gangaji_pul/domain/entity/chat_entity.dart';
import 'package:gangaji_pul/domain/entity/user_model.dart';
import 'package:gangaji_pul/domain/repository/user_repository.dart';
import 'package:gangaji_pul/presentation/view_model/user_view_model.dart';

import '../../domain/repository/chat_repository.dart';

class ChatViewModel extends StreamNotifier<List<Chat>> {
  late final ChatRepository _chatRepository;
  late final UserRepository _userRepository;
  final Map<String, UserModel> userCache = {};

  @override
  Stream<List<Chat>> build() {
    _chatRepository = ref.watch(chatRepositoryProvider);
    _userRepository = ref.watch(userRepositoryProvider);

    return _chatRepository.fetchChats().asyncMap((chats) async {
      await _cacheUsers(chats);
      return chats;
    });
  }

  Future<void> sendChat(String message) async {
    final uid = ref.read(userStreamProvider).asData!.value!.uid;
    final userRef = _userRepository.getUserReference(uid);
    final chat = Chat(message: message, createdAt: DateTime.now(), user: userRef);
    await _chatRepository.sendChat(chat);
  }

  Future<void> _cacheUsers(List<Chat> chats) async {
    final userIds = chats.map((c) => c.user.id).toSet();
    for (final id in userIds) {
      if (!userCache.containsKey(id)) {
        final user = await _userRepository.getUser(id);
        userCache[id] = user;
      }
    }
  }
}
