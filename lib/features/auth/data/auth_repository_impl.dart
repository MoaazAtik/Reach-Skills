import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../domain/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final _auth = FirebaseAuth.instance;

  int _authStateSubscriptionCount = 0;
  StreamSubscription<User?>? _authStateSubscription;
  final StreamController<User?> _currentUserController =
      StreamController<User?>.broadcast();
  Stream<User?>? _currentUserStream;

  @override
  Stream<User?>? get currentUserStream => _currentUserStream;

  final ValueNotifier<bool> _isLoggedIn = ValueNotifier(false);

  @override
  ValueNotifier<bool> get isLoggedIn => _isLoggedIn;

  // {
  //   // if (_authUserState != null) {
  //   //   return _authUserState?.map((user) => user != null);
  //   // } else {
  //   //   return Stream.value(false);
  //   // }
  //
  //   // if (_auth.currentUser != null) {
  //   //   return Stream.value(true);
  //   // } else {
  //   //   return Stream.value(false);
  //   // }
  // }

  @override
  void subscribeToAuthStateChanges() {
    _authStateSubscriptionCount++;

    if (_authStateSubscriptionCount <= 1) {
      _currentUserStream = _currentUserController.stream;
      // _isLoggedIn = _isLoggedInController.stream;

      _authStateSubscription = _auth.authStateChanges().listen(
        (user) {
          _currentUserController.sink.add(user);
          _isLoggedIn.value = user != null;
        },
        onError: ((error, stackTrace) {
          _currentUserController.addError(error);
        }),
      );

      _currentUserController.onCancel = () {
        _authStateSubscription?.cancel();
      };
    }
  }

  @override
  void unsubscribeFromAuthStateChanges() {
    _authStateSubscriptionCount--;
    if (_authStateSubscriptionCount < 1) {
      _currentUserController.close();

      _isLoggedIn.dispose();
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
