class Comment {
  final String id;
  final String userId;
  final String userName;
  final String text;
  final DateTime timestamp;
  final String? parentId; // <- 답글일 경우 원본 댓글의 ID

  Comment({
    required this.id,
    required this.userId,
    required this.userName,
    required this.text,
    required this.timestamp,
    this.parentId,
  });
}
