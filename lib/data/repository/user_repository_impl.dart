import 'package:firebase_auth/firebase_auth.dart';
import 'package:gangaji_pul/domain/entity/user_model.dart';
import 'package:gangaji_pul/domain/repository/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  UserRepositoryImpl({required FirebaseAuth firebaseAuth})
    : _firebaseAuth = firebaseAuth;

  final FirebaseAuth _firebaseAuth;

  @override
  Future<UserModel?> getCurrentUser() async {
    final user = _firebaseAuth.currentUser;
    if (user == null) return null;

    return UserModel(
      uid: user.uid,
      name: user.displayName ?? '',
      email: user.email ?? '',
    );
  }
}
