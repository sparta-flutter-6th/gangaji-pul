import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entity/user_model.dart';

class UserRemoteDataSource {
  final FirebaseFirestore firestore;

  UserRemoteDataSource(this.firestore);

  Future<UserModel?> getUserByUid(String uid) async {
    final doc = await firestore.collection('users').doc(uid).get();
    if (!doc.exists) return null;

    final data = doc.data()!;
    return UserModel(
      uid: uid,
      name: data['name'],
      email: data['email'],
      nickname: data['nickname'] ?? '',
      profileImageUrl: data['profileImageUrl'] ?? '',
    );
  }
}
