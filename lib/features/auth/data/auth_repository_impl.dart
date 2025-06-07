import 'package:firebase_auth/firebase_auth.dart';

import '../domain/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  @override
  Stream<User?> getAuthStateChanges() {
    return FirebaseAuth.instance.authStateChanges();
  }
}
