import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gangaji_pul/data/data_source/chat_data_source.dart';
import 'package:gangaji_pul/data/dto/chat_dto.dart';

class ChatDataSourceImple implements ChatDataSource {
  final FirebaseFirestore _firestore;

  ChatDataSourceImple(this._firestore);
  @override
  Stream<List<ChatDto>> fetchChats() {
    final now = DateTime.now();
    final todayStart = DateTime(now.year, now.month, now.day);

    final query = _firestore
        .collection('chats')
        .where('createdAt', isGreaterThanOrEqualTo: Timestamp.fromDate(todayStart))
        .orderBy('createdAt', descending: true);

    return query.snapshots().map((snapshot) => snapshot.docs.map((doc) => ChatDto.fromFirestore(doc)).toList());
  }

  @override
  Future<void> sendChat(ChatDto chat) async {
    final chatRef = _firestore.collection('chats').doc();
    await chatRef.set(chat.toMap());
  }
}
