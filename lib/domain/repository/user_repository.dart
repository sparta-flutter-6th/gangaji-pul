import 'package:gangaji_pul/domain/entity/user_model.dart';

abstract interface class UserRepository {
  Future<UserModel?> getCurrentUser();
}
