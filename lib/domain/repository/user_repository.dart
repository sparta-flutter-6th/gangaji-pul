import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gangaji_pul/domain/entity/user_model.dart';

abstract interface class UserRepository {
  Stream<UserModel?> getUserByUid(String uid);
  Future<void> createUserDocIfNotExists(User user);
  Stream<List<UserModel>?> getTopUsersByPostCount();
  Stream<List<UserModel>?> getTopUsersByLikeCount();
  Future<UserModel> getUser(String uid);
  DocumentReference getUserReference(String uid);
}
