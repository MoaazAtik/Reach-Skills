import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../data/auth_repository_impl.dart';
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
  String? _authError;

  String? get authError => _authError;

  void init() {
    startAuthStateSubscription();
  }

  void startAuthStateSubscription() {
    _authRepository.subscribeToAuthStateChanges();

    // Initialize fields
    /*
     Needed because these local fields might not be initialized when they
     start listening to the repo after the repo updates its fields.
    */
    _isLoggedIn = _authRepository.isLoggedIn.value;
    _currentUser = _authRepository.currentUserNotifier.value;
    _authError = (_authRepository as AuthRepositoryImpl).authError.value;
    notifyListeners();

    // Listen to changes
    _authRepository.currentUserNotifier.addListener(
      _listenerCurrentUserNotifier,
    );
    _authRepository.authError.addListener(_listenerAuthError);
    _authRepository.isLoggedIn.addListener(_listenerIsLoggedIn);
  }

  void stopSubscriptions() {
    _authRepository.unsubscribeFromAuthStateChanges();
    _authRepository.currentUserNotifier.removeListener(
      _listenerCurrentUserNotifier,
    );
    (_authRepository as AuthRepositoryImpl).authError.removeListener(
      _listenerAuthError,
    );
    _authRepository.isLoggedIn.removeListener(_listenerIsLoggedIn);
  }

  void _listenerCurrentUserNotifier() {
    _currentUser = _authRepository.currentUserNotifier.value;
    _authError = null;
    notifyListeners();
  }

  void _listenerAuthError() {
    _authError = (_authRepository as AuthRepositoryImpl).authError.value;
    notifyListeners();
  }

  void _listenerIsLoggedIn() {
    _isLoggedIn = _authRepository.isLoggedIn.value;
    notifyListeners();
  }

  Future<void> signOut() async {
    await _authRepository.signOut();
  }

  @override
  void dispose() {
    stopSubscriptions();
    super.dispose();
  }
}
