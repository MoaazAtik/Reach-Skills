import 'dart:async';

import 'package:flutter/foundation.dart';

import '../domain/entities/app_user.dart';
import '../domain/entities/auth_session.dart';
import '../domain/use_cases/get_auth_session_use_case.dart';
import '../domain/use_cases/sign_out_use_case.dart';

class AuthViewModel extends ChangeNotifier {
  AuthViewModel({
    required GetAuthSessionUseCase getAuthSessionUseCase,
    required SignOutUseCase signOutUseCase,
  }) : _getAuthSessionUseCase = getAuthSessionUseCase,
       _signOutUseCase = signOutUseCase {
    init();
  }

  final GetAuthSessionUseCase _getAuthSessionUseCase;
  final SignOutUseCase _signOutUseCase;

  StreamSubscription<AuthSession>? _authSessionSubscription;

  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

  AppUser? _currentUser;

  AppUser? get currentUser => _currentUser;
  String? _authError;

  String? get authError => _authError;

  void init() {
    startAuthStateSubscription();
  }

  void startAuthStateSubscription() {
    // Listen to changes
    _authSessionSubscription = _getAuthSessionUseCase.execute().listen((
      session,
    ) {
      _currentUser = session.user;
      _isLoggedIn = session.isLoggedIn;
      _authError = session.error;
      notifyListeners();
    });
  }

  void stopSubscriptions() {
    _authSessionSubscription?.cancel();
  }

  Future<void> signOut() async {
    await _signOutUseCase.execute();
  }

  @override
  void dispose() {
    stopSubscriptions();
    super.dispose();
  }
}
