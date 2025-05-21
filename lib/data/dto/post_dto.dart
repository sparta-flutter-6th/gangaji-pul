import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gangaji_pul/domain/entity/post_entity.dart';

class PostDto {
  final String postId; // 고유 식별자
  final String content; // 글 내용
  final List<String> tags; // 해시태그
  final String imageUrl; // 이미지 URL
  final DateTime createdAt; // 작성 시간
  final DateTime updatedAt; // 수정 시간
  final String userId; // 작성자 UID
  final String userName; // 작성자 이름
  final String userProfileImage; // 작성자 프로필 사진 URL
  final int likeCount; // 좋아요 수
  final int commentCount; // 댓글 수

  PostDto({
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

  /// Firebase에서 받아온 Map 데이터를 PostDto로 변환
  factory PostDto.fromFirebase(Map<String, dynamic> json, String docId) {
    return PostDto(
      postId: docId,
      content: json['content'] as String,
      tags: List<String>.from(json['tags'] ?? []),
      imageUrl: json['imageUrl'] as String,
      createdAt: (json['createdAt'] as Timestamp).toDate(),
      updatedAt: (json['updatedAt'] as Timestamp).toDate(),
      userId: json['userId'] as String,
      userName: json['userName'] as String,
      userProfileImage: json['userProfileImage'] as String,
      likeCount: (json['likeCount'] ?? 0) as int,
      commentCount: (json['commentCount'] ?? 0) as int,
    );
  }

  /// PostDto를 Firebase에 저장할 수 있는 Map 형태로 변환
  Map<String, dynamic> toFirebase() {
    return {
      'content': content,
      'tags': tags,
      'imageUrl': imageUrl,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
      'userId': userId,
      'userName': userName,
      'userProfileImage': userProfileImage,
      'likeCount': likeCount,
      'commentCount': commentCount,
    };
  }

  Post toEntity() {
    return Post(
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
