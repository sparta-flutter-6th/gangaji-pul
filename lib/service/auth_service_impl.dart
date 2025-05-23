import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:gangaji_pul/domain/repository/user_repository.dart';
import 'package:gangaji_pul/service/auth_service.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthServiceImpl implements AuthService {
  AuthServiceImpl({
    required GoogleSignIn googleSignIn,
    required FirebaseAuth firebaseAuth,
    required UserRepository userRepository,
  }) : _googleSignIn = googleSignIn,
       _firebaseAuth = firebaseAuth,
       _userRepository = userRepository;

  final GoogleSignIn _googleSignIn;
  final FirebaseAuth _firebaseAuth;
  final UserRepository _userRepository;

  @override
  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();

      if (googleSignInAccount == null) {
        return null;
      }

      final googleAuth = await googleSignInAccount.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await _firebaseAuth.signInWithCredential(
        credential,
      );
      final user = userCredential.user;

      if (user != null) {
        await _userRepository.createUserDocIfNotExists(user);
      }

      return userCredential;
    } catch (e) {
      log('구글 로그인 실패: $e');
      return null;
    }
  }

  @override
  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _firebaseAuth.signOut();
  }
}
