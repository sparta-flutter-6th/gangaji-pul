import 'package:gangaji_pul/data/dto/post_dto.dart';

class Post {
  final String postId;
  final String content;
  final List<String> tags;
  final String imageUrl;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String userId;
  final String userName;
  final String userProfileImage;
  final int likeCount;
  final int commentCount;

  const Post({
    required this.postId,
    required this.content,
    required this.tags,
    required this.imageUrl,
    required this.createdAt,
    required this.updatedAt,
    required this.userId,
    required this.userName,
    required this.userProfileImage,
    required this.likeCount,
    required this.commentCount,
  });

  Post copyWith({
    String? postId,
    String? content,
    List<String>? tags,
    String? imageUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? userId,
    String? userName,
    String? userProfileImage,
    int? likeCount,
    int? commentCount,
  }) {
    return Post(
      postId: postId ?? this.postId,
      content: content ?? this.content,
      tags: tags ?? this.tags,
      imageUrl: imageUrl ?? this.imageUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      userProfileImage: userProfileImage ?? this.userProfileImage,
      likeCount: likeCount ?? this.likeCount,
      commentCount: commentCount ?? this.commentCount,
    );
  }

  PostDto toDto() {
    return PostDto(
      postId: postId,
      content: content,
      tags: tags,
      imageUrl: imageUrl,
      createdAt: createdAt,
      updatedAt: updatedAt,
      userId: userId,
      userName: userName,
      userProfileImage: userProfileImage,
      likeCount: likeCount,
      commentCount: commentCount,
    );
  }
}
