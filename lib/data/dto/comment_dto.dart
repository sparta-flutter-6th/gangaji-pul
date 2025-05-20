import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entity/comment_entity.dart';

class CommentDto {
  final String userId;
  final String userName;
  final String text;
  final DateTime timestamp;
  final String? parentId;

  CommentDto({
    required this.userId,
    required this.userName,
    required this.text,
    required this.timestamp,
    this.parentId,
  });

  factory CommentDto.fromJson(Map<String, dynamic> json) {
    return CommentDto(
      userId: json['userId'],
      userName: json['userName'],
      text: json['text'],
      timestamp: (json['timestamp'] as Timestamp).toDate(),
      parentId: json['parentId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'userName': userName,
      'text': text,
      'timestamp': timestamp,
      'parentId': parentId,
    };
  }

  factory CommentDto.fromEntity(Comment comment) {
    return CommentDto(
      userId: comment.userId,
      userName: comment.userName,
      text: comment.text,
      timestamp: comment.timestamp,
      parentId: comment.parentId,
    );
  }

  Comment toEntity(String id) {
    return Comment(
      id: id,
      userId: userId,
      userName: userName,
      text: text,
      timestamp: timestamp,
      parentId: parentId,
    );
  }
}
