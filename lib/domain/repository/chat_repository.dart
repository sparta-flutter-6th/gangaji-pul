import 'package:gangaji_pul/domain/entity/chat_entity.dart';

abstract class ChatRepository {
  Future<void> sendChat(Chat chat);
  Stream<List<Chat>> fetchChats();
}
