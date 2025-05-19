class UserModel {
  final String uid;
  String name;
  String nickname;
  String profileImageUrl;
  String email;
  String bio;

  UserModel({
    required this.uid,
    required this.name,
    required this.nickname,
    required this.profileImageUrl,
    required this.email,
    required this.bio,
  });

  UserModel.fromJson(Map<String, dynamic> map)
    : this(
        uid: map['uid'] ?? '',
        name: map['name'] ?? '',
        nickname: map['nickname'] ?? '',
        profileImageUrl: map['profile_image_url'] ?? '',
        email: map['email'] ?? '',
        bio: map['bio'] ?? '',
      );
}
