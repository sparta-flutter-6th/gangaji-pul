import 'package:firebase_auth/firebase_auth.dart';

abstract interface class AuthService {
  Future<UserCredential?> signInWithGoogle();
  Future<void> signOut();
}
