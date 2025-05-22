import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gangaji_pul/data/data_source/user_data_source.dart';
import 'package:gangaji_pul/domain/entity/user_model.dart';

class UserDataSourceImpl implements UserDataSource {
  UserDataSourceImpl({required firestore}) : _firestore = firestore;
  final FirebaseFirestore _firestore;
  @override
  Stream<UserModel?> getUserByUid(String uid) {
    return _firestore.collection('users').doc(uid).snapshots().map((doc) {
      if (!doc.exists) return null;

      final data = doc.data()!;
      return UserModel(
        uid: uid,
        name: data['name'],
        email: data['email'],
        nickname: data['nickname'] ?? '',
        profileImageUrl: data['profileImageUrl'] ?? '',
        bio: '',
        likeCount: data['likeCount'] ?? 0,
        postCount: data['postCount'] ?? 0,
        chatCount: data['chatCount'] ?? 0,
      );
    });
  }

  @override
  Stream<List<UserModel>?> getTopUsersByLikeCount() {
    return _firestore.collection('topUsers').doc('topUsersByPostCount').snapshots().map((doc) {
      final data = doc.data();
      if (data == null || data['users'] == null) return null;
      return List.from(data['users']).map((e) {
        return UserModel.fromJson(e);
      }).toList();
    });
  }

  @override
  Stream<List<UserModel>?> getTopUsersByPostCount() {
    return _firestore.collection('topUsers').doc('topUsersByPostCount').snapshots().map((doc) {
      final data = doc.data();
      if (data == null || data['users'] == null) return null;
      return List.from(data['users']).map((e) {
        return UserModel.fromJson(e);
      }).toList();
    });
  }
}
