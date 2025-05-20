class Comment {
  final String id; // 댓글 고유 ID
  final String userId; // Firebase 사용자 UID
  final String userName; // 사용자 이름
  final String text; // 댓글 내용
  final DateTime timestamp; // 작성 시간
  final String? parentId; // 답글이면 상위 댓글 ID

  Comment({
    required this.id,
    required this.userId,
    required this.userName,
    required this.text,
    required this.timestamp,
    this.parentId,
  });
}
