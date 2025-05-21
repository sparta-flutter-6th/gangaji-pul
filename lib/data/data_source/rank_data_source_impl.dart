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
  Stream<List<Map<UserModel, int>>> getChatRank() {
    return _firebaseFirestore.collection('chats').snapshots().asyncMap((chatSnapshot) async {
      final Map<String, int> userCounts = {};
      for (final doc in chatSnapshot.docs) {
        final userRef = doc.data()['user'] as DocumentReference?;
        if (userRef == null) continue;

        final uid = userRef.id;
        userCounts[uid] = (userCounts[uid] ?? 0) + 1;
      }

      final sortedEntries = userCounts.entries.toList()..sort((a, b) => b.value.compareTo(a.value));

      final topEntries = sortedEntries.take(3);

      List<Map<UserModel, int>> topUsers = [];

      for (final entry in topEntries) {
        final userDoc = await _firebaseFirestore.collection('users').doc(entry.key).get();
        if (userDoc.exists) {
          final data = userDoc.data()!;
          topUsers.add({UserModel.fromJson(data): entry.value});
        }
      }

      return topUsers;
    });
  }
}
