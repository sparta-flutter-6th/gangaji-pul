import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gangaji_pul/data/providers/user_providers.dart';
import 'package:gangaji_pul/service/auth_service.dart';
import 'package:gangaji_pul/service/auth_service_impl.dart';
import 'package:google_sign_in/google_sign_in.dart';

final authServiceProvider = Provider<AuthService>((ref) {
  final userRepository = ref.read(userRepositoryProvider);
  return AuthServiceImpl(
    googleSignIn: GoogleSignIn(),
    firebaseAuth: FirebaseAuth.instance,
    userRepository: userRepository,
  );
});

final authStateProvider = StreamProvider<User?>((ref) {
  return FirebaseAuth.instance.authStateChanges();
});
