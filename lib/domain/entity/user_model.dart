class UserModel {
  final String uid;
  String name;
  String nickname;
  String profileImageUrl;
  String email;
  String bio;
  int likeCount;
  int postCount;
  int chatCount;

  UserModel({
    required this.uid,
    required this.name,
    required this.nickname,
    required this.profileImageUrl,
    required this.email,
    required this.bio,
    required this.likeCount,
    required this.postCount,
    required this.chatCount,
  });

  UserModel copyWith({
    String? uid,
    String? name,
    String? nickname,
    String? email,
    String? profileImageUrl,
    String? bio,
    int? likeCount,
    int? postCount,
    int? chatCount,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      nickname: nickname ?? this.nickname,
      email: email ?? this.email,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      bio: bio ?? this.bio,
      likeCount: likeCount ?? this.likeCount,
      postCount: postCount ?? this.postCount,
      chatCount: chatCount ?? this.chatCount,
    );
  }

  UserModel.fromJson(Map<String, dynamic> map)
    : this(
        uid: map['uid'] ?? '',
        name: map['name'] ?? '',
        nickname: map['nickname'] ?? '',
        profileImageUrl: map['profileImageUrl'] ?? '',
        email: map['email'] ?? '',
        bio: map['bio'] ?? '',
        likeCount: map['likeCount'] ?? 0,
        postCount: map['postCount'] ?? 0,
        chatCount: map['chatCount'] ?? 0,
      );
}
