import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gangaji_pul/data/providers/user_data_source_provider.dart';
import 'package:gangaji_pul/domain/entity/user_model.dart';
import 'package:gangaji_pul/presentation/providers/auth_state_provider.dart';

final userStreamProvider = StreamProvider<UserModel?>((ref) {
  final authStateAsync = ref.watch(authStateProvider);

  final uid = authStateAsync.asData?.value?.uid;
  if (uid == null) return Stream.value(null);
  final userDataSource = ref.read(userDataSourceProvider);
  return userDataSource.getUserByUid(uid);
});

Future<void> createUserDocIfNotExists(User user) async {
  final docRef = FirebaseFirestore.instance.collection('users').doc(user.uid);
  final doc = await docRef.get();

  if (!doc.exists) {
    await docRef.set({
      'uid': user.uid,
      'name': user.displayName ?? '',
      'email': user.email ?? '',
      'bio': '',
      'postCount': 0,
      'likeCount': 0,
      'nickname': '',
    });
  }
}
