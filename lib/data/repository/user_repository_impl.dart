import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gangaji_pul/domain/entity/user_model.dart';
import 'package:gangaji_pul/domain/repository/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final userCollection = FirebaseFirestore.instance.collection('users');

  @override
  Future<void> saveUser(String uid, String email, String name) async {
    userCollection.doc(uid).set({
      'uid': uid,
      'email': email,
      'name': name,
    }, SetOptions(merge: true));
  }

  @override
  Future<UserModel> getUser(String uid) async {
    final userDoc = await userCollection.doc(uid).get();
    final userData = userDoc.data();
    return UserModel.fromJson(userData!);
  }
}
