import 'package:gangaji_pul/domain/entity/user_model.dart';

abstract interface class UserRepository {
  Future<void> saveUser(String uid, String email, String name);
  Future<UserModel> getUser(String uid);
  Future<bool> userExists(String uid);
}
