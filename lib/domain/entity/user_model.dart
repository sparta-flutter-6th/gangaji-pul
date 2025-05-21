class UserModel {
  final String uid;
  String name;
  String nickname;
  String profileImageUrl;
  String email;
  String bio;
  int likeCount;
  int postCount;

  UserModel({
    required this.uid,
    required this.name,
    required this.nickname,
    required this.profileImageUrl,
    required this.email,
    required this.bio,
    required this.likeCount,
    required this.postCount,
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
    );
  }

  UserModel.fromJson(Map<String, dynamic> map)
    : this(
        uid: map['uid'] ?? '',
        name: map['name'] ?? '',
        nickname: map['nickname'] ?? '',
        profileImageUrl: map['profile_image_url'] ?? '',
        email: map['email'] ?? '',
        bio: map['bio'] ?? '',
        likeCount: map['likeCount'] ?? 0,
        postCount: map['postCount'] ?? 0,
      );
}
