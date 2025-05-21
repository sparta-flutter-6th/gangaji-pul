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

  UserModel copyWith({
    String? uid,
    String? name,
    String? nickname,
    String? email,
    String? profileImageUrl,
    String? bio,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      nickname: nickname ?? this.nickname,
      email: email ?? this.email,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      bio: bio ?? this.bio,
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
      );
      
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'nickname': nickname,
      'profile_image_url': profileImageUrl,
      'email': email,
      'bio': bio,
    };
  }
}
