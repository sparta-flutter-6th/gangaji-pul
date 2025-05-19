import 'package:cloud_firestore/cloud_firestore.dart';

class CommentDto {
  final String id; //댓글의 고유 ID
  final String userId; //댓글 작성자의 Firebase UID
  final String userName; //작성자 이름
  final String text; //댓글 내용
  final DateTime timestamp; //댓글 작성 시간

  CommentDto({
    required this.id,
    required this.userId,
    required this.userName,
    required this.text,
    required this.timestamp,
  });

  /// Firestore에서 가져온 JSON 데이터를 CommentDto 객체로 변환하는 팩토리 생성자
  factory CommentDto.fromJson(Map<String, dynamic> json, String id) {
    return CommentDto(
      id: id,
      userId: json['userId'],
      userName: json['userName'],
      text: json['text'],
      timestamp: (json['timestamp'] as Timestamp).toDate(),
    );
  }

  /// CommentDto를 Firestore에 저장할 수 있도록 Map형태로 변환
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'userName': userName,
      'text': text,
      'timestamp': timestamp,
    };
  }
}
