import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gangaji_pul/data/providers/post_data_source_provider.dart';
import 'package:gangaji_pul/data/repository/post_repository_impl.dart';
import 'package:gangaji_pul/domain/repository/post_repository.dart';

final postRepositoryProvider = Provider<PostRepository>((ref) {
  final dataSource = ref.read(postDataSourceProvider);
  final firestore = FirebaseFirestore.instance;
  return PostRepositoryImpl(dataSource, firestore);
});
