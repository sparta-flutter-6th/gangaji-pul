import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:gangaji_pul/service/auth_service.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthServiceImpl implements AuthService {
  AuthServiceImpl({
    required GoogleSignIn googleSignIn,
    required FirebaseAuth firebaseAuth,
  }) : _googleSignIn = googleSignIn,
       _firebaseAuth = firebaseAuth;
  final GoogleSignIn _googleSignIn;
  final FirebaseAuth _firebaseAuth;
  @override
  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();

      if (googleSignInAccount == null) {
        return null;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleSignInAccount.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await _firebaseAuth.signInWithCredential(
        credential,
      );
      return userCredential;
    } catch (e) {
      log('구글 로그인 실패: $e');
      return null;
    }
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
