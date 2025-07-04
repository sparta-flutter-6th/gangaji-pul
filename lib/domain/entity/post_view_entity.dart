// home 화면에서 보여주기위한 데이터
// post 작성 페이지에서는 다른 entity 사용.
class PostViewEntity {
  final String postId;
  final String userName;
  final DateTime createdAt;
  final String content;
  final List<String> tags;
  final String imageUrl;

  PostViewEntity({
    required this.userName,
    required this.imageUrl,
    required this.postId,
    required this.content,
    required this.tags,
    required this.createdAt,
  });
}
