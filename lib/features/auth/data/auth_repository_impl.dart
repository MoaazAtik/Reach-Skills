import 'package:firebase_auth/firebase_auth.dart';

import '../domain/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  @override
  Stream<User?> getAuthStateChanges() {
    return FirebaseAuth.instance.authStateChanges();
  }

  @override
  Future<void> signOut() {
    return FirebaseAuth.instance.signOut();
  }

  @override
  String? getUserId() {
    return FirebaseAuth.instance.currentUser?.uid;
  }

  @override
  String? getUserEmail() {
    return FirebaseAuth.instance.currentUser?.email;
  }
}
