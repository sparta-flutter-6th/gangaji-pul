import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gangaji_pul/data/providers/user_data_source_provider.dart';
import 'package:gangaji_pul/data/repository/user_repository_impl.dart';
import 'package:gangaji_pul/domain/repository/user_repository.dart';
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

final userRepositoryProvider = Provider<UserRepository>((ref) {
  return UserRepositoryImpl(ref.read(userDataSourceProvider));
});

final authStateProvider = StreamProvider<User?>((ref) {
  return FirebaseAuth.instance.authStateChanges();
});
