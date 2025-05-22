import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gangaji_pul/data/data_source/rank_data_source.dart';
import 'package:gangaji_pul/domain/entity/user_model.dart';

class RankDataSourceImpl implements RankDataSource {
  final FirebaseFirestore _firebaseFirestore;

  RankDataSourceImpl(this._firebaseFirestore);

  @override
  Stream<List<UserModel>?> getPostRank() {
    return _firebaseFirestore.collection('topUsers').doc('topUsersByPostCount').snapshots().map((doc) {
      final data = doc.data();
      if (data == null || data['users'] == null) return null;
      return List.from(data['users']).map((e) => UserModel.fromJson(e)).toList();
    });
  }

  @override
  Stream<List<UserModel>?> getLikeRank() {
    return _firebaseFirestore.collection('topUsers').doc('topUsersBylikeCount').snapshots().map((doc) {
      final data = doc.data();
      if (data == null || data['users'] == null) return null;
      return List.from(data['users']).map((e) => UserModel.fromJson(e)).toList();
    });
  }

  @override
  Stream<List<UserModel>?> getChatRank() {
    return _firebaseFirestore.collection('topUsers').doc('topUsersByChatCount').snapshots().map((doc) {
      final data = doc.data();
      if (data == null || data['users'] == null) return null;
      return List.from(data['users']).map((e) => UserModel.fromJson(e)).toList();
    });
  }
}
