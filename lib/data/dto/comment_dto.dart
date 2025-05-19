import 'package:cloud_firestore/cloud_firestore.dart';

class CommentDto {
  final String id;
  final String userId;
  final String userName;
  final String text;
  final DateTime timestamp;

  CommentDto({
    required this.id,
    required this.userId,
    required this.userName,
    required this.text,
    required this.timestamp,
  });

  factory CommentDto.fromJson(Map<String, dynamic> json, String id) {
    return CommentDto(
      id: id,
      userId: json['userId'],
      userName: json['userName'],
      text: json['text'],
      timestamp: (json['timestamp'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'userName': userName,
      'text': text,
      'timestamp': timestamp,
    };
  }
}
