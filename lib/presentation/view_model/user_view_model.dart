import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gangaji_pul/domain/entity/user_model.dart';

final userViewModelProvider = NotifierProvider<UserViewModel, UserModel?>(
  () => UserViewModel(),
);

class UserViewModel extends Notifier<UserModel?> {
  late final Stream<User?> _authStateChanges;

  @override
  UserModel? build() {
    _authStateChanges = FirebaseAuth.instance.authStateChanges();
    _authStateChanges.listen((user) {
      if (user == null) {
        state = null;
      } else {
        state = UserModel(
          uid: user.uid,
          name: user.displayName!,
          email: user.email!,
        );
      }
    });

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return null;
    }
    return UserModel(
      uid: user.uid,
      name: user.displayName!,
      email: user.email!,
    );
  }
}
