import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gangaji_pul/data/data_source/user_data_source_impl.dart';
import 'package:gangaji_pul/data/repository/user_repository_impl.dart';
import 'package:gangaji_pul/domain/repository/user_repository.dart';

final userDataSourceProvider = Provider<UserDataSourceImpl>((ref) {
  return UserDataSourceImpl(firestore: FirebaseFirestore.instance);
});

final userRepositoryProvider = Provider<UserRepository>((ref) {
  return UserRepositoryImpl(ref.read(userDataSourceProvider));
});