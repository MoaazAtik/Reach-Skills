import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

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
      _authStateSubscription = _auth.authStateChanges().listen(
        (user) {
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
