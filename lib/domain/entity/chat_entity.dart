import 'package:cloud_firestore/cloud_firestore.dart';

class Chat {
  final String message;
  final DateTime createdAt;
  final DocumentReference user;

  Chat({required this.message, required this.createdAt, required this.user});

  factory Chat.fromMap(Map<String, dynamic> map) {
    return Chat(message: map['message'] as String, createdAt: (map['createdAt'] as Timestamp).toDate(), user: map['user'] as DocumentReference);
  }

  factory Chat.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Chat.fromMap(data);
  }

  Map<String, dynamic> toMap() {
    return {'message': message, 'createdAt': Timestamp.fromDate(createdAt), 'user': user};
  }
}
