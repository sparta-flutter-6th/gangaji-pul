import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gangaji_pul/data/data_source/like_data_source.dart';

class PostLikeDataSourceImpl implements PostLikeDataSource {
  final FirebaseFirestore _firebaseFirestore;

  PostLikeDataSourceImpl(this._firebaseFirestore);

  @override
  Future<bool> isPostLikedByUser(String postId, String userId) async {
    final doc =
        await _firebaseFirestore
            .collection('posts')
            .doc(postId)
            .collection('likes')
            .doc(userId)
            .get();
    return doc.exists;
  }

  @override
  Future<void> likePost(String postId, String userId) async {
    await _firebaseFirestore
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userId)
        .set({'likedAt': FieldValue.serverTimestamp()});
  }

  @override
  Future<void> unlikePost(String postId, String userId) async {
    await _firebaseFirestore
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userId)
        .delete();
  }
}
