class UserModel {
  final String uid;
  String name;
  String nickname;
  String profileImageUrl;
  String email;

  UserModel({
    required this.uid,
    required this.name,
    this.nickname = '',
    this.profileImageUrl = '',
    required this.email,
  });
}
