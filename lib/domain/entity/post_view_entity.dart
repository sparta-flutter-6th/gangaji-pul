// home 화면에서 보여주기위한 데이터
// post 작성 페이지에서는 다른 entity 사용.
class PostviewEntity {
  final String postId;
  final String userId;
  final DateTime createdAt;
  final String content;
  final List<String> tags;

  PostviewEntity({required this.userId, required this.postId, required this.content, required this.tags, required this.createdAt});
}
