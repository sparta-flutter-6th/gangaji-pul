import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gangaji_pul/data/repository/user_repository_impl.dart';
import 'package:gangaji_pul/domain/repository/user_repository.dart';
import 'package:gangaji_pul/service/auth_service.dart';
import 'package:gangaji_pul/service/auth_service_impl.dart';
import 'package:google_sign_in/google_sign_in.dart';

final userServiceProvider = Provider<AuthService>((ref) {
  return AuthServiceImpl(
    googleSignIn: GoogleSignIn(),
    firebaseAuth: FirebaseAuth.instance,
  );
});

final userRepositoryProvider = Provider<UserRepository>((ref) {
  return UserRepositoryImpl();
});
