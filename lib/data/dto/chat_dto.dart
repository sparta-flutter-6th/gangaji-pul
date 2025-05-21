import 'package:cloud_firestore/cloud_firestore.dart';

class ChatDto {
  final String message;
  final DateTime createdAt;
  final DocumentReference user;

  ChatDto({required this.message, required this.createdAt, required this.user});

  factory ChatDto.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ChatDto(message: data['message'], createdAt: (data['createdAt'] as Timestamp).toDate(), user: data['user'] as DocumentReference);
  }

  Map<String, dynamic> toMap() {
    return {'message': message, 'createdAt': Timestamp.fromDate(createdAt), 'sender': user};
  }
}
