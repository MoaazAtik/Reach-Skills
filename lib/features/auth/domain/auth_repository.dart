import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Stream<User?> get authStateChanges;

  Future<void> signOut();

  String? getUserId();

  String? getUserEmail();

  Future<void> updateUserName(String name);
}
