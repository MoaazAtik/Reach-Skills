import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../domain/auth_repository.dart';

class AuthViewModel extends ChangeNotifier {
  AuthViewModel({required AuthRepository authRepository})
    : _authRepository = authRepository {
    init();
  }

  final AuthRepository _authRepository;

  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

  // Example: Listen to current user stream.
  User? _currentUser;
  User? get currentUser => _currentUser;
  String? authError;
  StreamSubscription<User?>? _currentUserSubscription;

  StreamSubscription<bool>? _isLoggedInSubscription;

  void init() {
    startAuthStateSubscription();
  }

  void startAuthStateSubscription() {
    _authRepository.subscribeToAuthStateChanges();

    /*
    // Example: Listen to current user stream.

    if (_authRepository.currentUserStream != null) { // ie, stream initialized
      _currentUserSubscription = _authRepository.currentUserStream!.listen(
        (user) {
          _currentUser = user;
          authError = null;
          notifyListeners();
        },
        onError: (object, stackTrace) {
          authError = object.toString();
          notifyListeners();
        },
      );
    }
    */

    _isLoggedInSubscription = _authRepository.isLoggedIn.listen((isLoggedIn) {
      _isLoggedIn = isLoggedIn;
      notifyListeners();
    });
  }

  void stopAuthStateSubscription() {
    _authRepository.unsubscribeFromAuthStateChanges();
    // Example: Listen to current user stream.
    _currentUserSubscription?.cancel();
    _isLoggedInSubscription?.cancel();
  }

  Future<void> signOut() async {
    await _authRepository.signOut();
  }

  @override
  void dispose() {
    stopAuthStateSubscription();
    super.dispose();
  }
}
