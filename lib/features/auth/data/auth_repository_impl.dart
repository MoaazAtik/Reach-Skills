import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../../../core/constants/strings.dart';
import '../domain/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final _auth = FirebaseAuth.instance;

  int _authStateSubscriptionCount = 0;
  StreamSubscription<User?>? _authStateSubscription;
  final ValueNotifier<User?> _currentUserNotifier = ValueNotifier(null);

  @override
  ValueNotifier<User?> get currentUserNotifier => _currentUserNotifier;

  final ValueNotifier<bool> _isLoggedIn = ValueNotifier(false);

  @override
  ValueNotifier<bool> get isLoggedIn => _isLoggedIn;

  final ValueNotifier<String?> _authError = ValueNotifier(null);

  ValueNotifier<String?> get authError => _authError;

  @override
  void subscribeToAuthStateChanges() {
    _authStateSubscriptionCount++;

    if (_authStateSubscriptionCount <= 1) {
      _authStateSubscription = _auth.userChanges().listen(
        (User? user) {
          if (_currentUserNotifier.value == user) return;

          _currentUserNotifier.value = user;
          _isLoggedIn.value = user != null;
          _authError.value = null;
        },
        onError: ((error, stackTrace) {
          _authError.value = error.toString();
        }),
      );
    }
  }

  @override
  void unsubscribeFromAuthStateChanges() {
    _authStateSubscriptionCount--;
    if (_authStateSubscriptionCount < 1) {
      _currentUserNotifier.dispose();
      _isLoggedIn.dispose();
      _authError.dispose();
      _authStateSubscription?.cancel();
    }
  }

  // Todo replace these `FirebaseAuth.instance`s with `_auth`
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
