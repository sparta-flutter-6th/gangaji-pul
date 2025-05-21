import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gangaji_pul/data/data_source/user_data_source.dart';
import 'package:gangaji_pul/domain/entity/user_model.dart';
import 'package:gangaji_pul/domain/repository/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserDataSource dataSource;

  UserRepositoryImpl(this.dataSource);

  @override
  Stream<UserModel?> getUserByUid(String uid) {
    return dataSource.getUserByUid(uid);
  }

  @override
  Future<void> createUserDocIfNotExists(User user) async {
    final docRef = FirebaseFirestore.instance.collection('users').doc(user.uid);
    final doc = await docRef.get();

    if (!doc.exists) {
      await docRef.set({
        'uid': user.uid,
        'name': user.displayName ?? '',
        'email': user.email ?? '',
        'bio': '',
        'postCount': 0,
        'likeCount': 0,
        'nickname': '',
        'profileImageUrl': '',
      });
    }
  }

  @override
  Stream<List<UserModel>?> getTopUsersByLikeCount() {
    return dataSource.getTopUsersByLikeCount();
  }

  @override
  Stream<List<UserModel>?> getTopUsersByPostCount() {
    return dataSource.getTopUsersByPostCount();
  }
}
