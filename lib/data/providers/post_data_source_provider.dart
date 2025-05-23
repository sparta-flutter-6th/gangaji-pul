import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gangaji_pul/data/data_source/post_data_source.dart';
import 'package:gangaji_pul/data/data_source/post_data_source_impl.dart';

final postDataSourceProvider = Provider<PostDataSource>((ref) {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  return PostDataSourceImpl(firebaseFirestore);
});
