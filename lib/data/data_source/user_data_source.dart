import '../../domain/entity/user_model.dart';

abstract interface class UserDataSource {
  Stream<UserModel?> getUserByUid(String uid);
  Stream<List<UserModel>?> getTopUsersByPostCount();
  Stream<List<UserModel>?> getTopUsersByLikeCount();
}
