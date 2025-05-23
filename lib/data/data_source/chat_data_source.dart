import 'package:gangaji_pul/data/dto/chat_dto.dart';

abstract interface class ChatDataSource {
  Stream<List<ChatDto>> fetchChats();
  Future<void> sendChat(ChatDto chatDto);
}
