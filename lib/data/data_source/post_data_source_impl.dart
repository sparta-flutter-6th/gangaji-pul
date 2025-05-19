import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gangaji_pul/data/data_source/post_data_source.dart';
import 'package:gangaji_pul/data/dto/post_dto.dart';

class PostDataSourceImpl implements PostDataSource {
  final FirebaseFirestore _firebaseFirestore;

  PostDataSourceImpl(this._firebaseFirestore);

  @override
  Future<PostDto> getPost() async {
    final snapshot = await _firebaseFirestore.collection('posts').get();

    if (snapshot.docs.isEmpty) throw Exception("No posts found");

    final randomDoc = (snapshot.docs..shuffle()).first;
    return PostDto.fromFirebase(randomDoc.data(), randomDoc.id);
  }

  @override
  Future<void> createPost() async {}
}
