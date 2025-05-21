import 'package:gangaji_pul/data/data_source/chat_data_source.dart';
import 'package:gangaji_pul/data/dto/chat_dto.dart';
import 'package:gangaji_pul/domain/entity/chat_entity.dart';
import '../../domain/repository/chat_repository.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatDataSource _dataSource;

  ChatRepositoryImpl(this._dataSource);
  @override
  Stream<List<Chat>> fetchChats() {
    return _dataSource.fetchChats().map(
      (dtoList) =>
          dtoList.map((dto) {
            return Chat(message: dto.message, user: dto.user, createdAt: dto.createdAt);
          }).toList(),
    );
  }

  @override
  Future<void> sendChat(Chat chat) async {
    await _dataSource.sendChat(ChatDto(message: chat.message, createdAt: chat.createdAt, user: chat.user));
  }
}
