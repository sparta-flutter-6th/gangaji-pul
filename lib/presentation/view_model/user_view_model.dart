import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gangaji_pul/domain/entity/user_model.dart';
import 'package:gangaji_pul/data/repository/user_repository_impl.dart';

final userViewModelProvider = NotifierProvider<UserViewModel, UserModel?>(() {
  return UserViewModel();
});

class UserViewModel extends Notifier<UserModel?> {
  late final StreamSubscription<User?> _authSubscription;
  final UserRepositoryImpl userRepositoryImpl = UserRepositoryImpl();

  @override
  UserModel? build() {
    _authSubscription = FirebaseAuth.instance.authStateChanges().listen((
      user,
    ) async {
      if (user == null) {
        state = null;
      } else {
        await userRepositoryImpl.saveUser(
          user.uid,
          user.email ?? '',
          user.displayName ?? '',
        );
        final userModel = await userRepositoryImpl.getUser(user.uid);
        state = userModel;
      }
    });

    // dispose될 때 stream 정리
    ref.onDispose(() {
      _authSubscription.cancel();
    });

    return null;
  }
}
