import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gangaji_pul/data/providers/user_providers.dart';
import 'package:gangaji_pul/domain/entity/user_model.dart';
import 'package:gangaji_pul/presentation/providers/auth_state_provider.dart';

final userStreamProvider = StreamProvider.autoDispose<UserModel?>((ref) {
  final authStateAsync = ref.watch(authStateProvider);

  final uid = authStateAsync.asData?.value?.uid;
  if (uid == null) return Stream.value(null);
  final userDataSource = ref.read(userDataSourceProvider);
  return userDataSource.getUserByUid(uid);
});
