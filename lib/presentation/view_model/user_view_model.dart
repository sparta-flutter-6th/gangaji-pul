import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gangaji_pul/domain/entity/user_model.dart';
import 'package:gangaji_pul/data/repository/user_repository_impl.dart';

final userViewModelProvider = NotifierProvider<UserViewModel, UserModel?>(() {
  return UserViewModel();
});

class UserViewModel extends Notifier<UserModel?> {
  late StreamSubscription<User?> _authSubscription;
  final UserRepositoryImpl userRepositoryImpl = UserRepositoryImpl();

  @override
  UserModel? build() {
    _authSubscription = FirebaseAuth.instance.authStateChanges().listen(
      _handleAuthChange,
    );

    ref.onDispose(() {
      _authSubscription.cancel();
    });

    return null;
  }

  Future<void> _handleAuthChange(User? user) async {
    if (user == null) {
      state = null;
      return;
    }

    final exists = await userRepositoryImpl.userExists(user.uid);
    if (!exists) {
      await userRepositoryImpl.saveUser(
        user.uid,
        user.email ?? '',
        user.displayName ?? '',
      );
    }

    final userModel = await userRepositoryImpl.getUser(user.uid);
    state = userModel;
  }

  Future<void> refreshUser() async {
    if (state == null) return;
    final refreshedUser = await userRepositoryImpl.getUser(state!.uid);
    state = refreshedUser;
  }
}
