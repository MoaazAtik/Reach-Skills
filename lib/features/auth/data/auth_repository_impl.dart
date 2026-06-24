import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

import '../../../core/constants/strings.dart';
import '../domain/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final _auth = FirebaseAuth.instance;

  @override
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  @override
  Future<void> signOut() {
    return _auth.signOut();
  }

  @override
  String? getUserId() {
    return _auth.currentUser?.uid;
  }

  @override
  String? getUserEmail() {
    return _auth.currentUser?.email;
  }

  /// Update user name in Firebase Auth user profile aka,
  /// `FirebaseAuth.instance`, not the profile repository which is
  /// a Firestore collection aka, `FirebaseFirestore.instance`.
  @override
  Future<void> updateUserName(String name) async {
    final User? currentAuthUser = _auth.currentUser;
    if (currentAuthUser == null) {
      print(
        '${Str.excMessageNullFirebaseAuthCurrentUser}'
        ' ${Str.excMessageUpdateUserName} - $this',
      );
      return;
    }

    if (currentAuthUser.displayName == name) return;

    await _auth.currentUser!.updateDisplayName(name);
  }
}
