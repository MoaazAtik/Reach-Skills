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

  StreamSubscription<User?>? _authStateSubscription;
  bool _loggedIn = false;

  bool get loggedIn => _loggedIn;
  String? errorAuthMessage;

  void init() {
    startAuthStateSubscription();
  }

  void startAuthStateSubscription() {
    _authStateSubscription = _authRepository.getAuthStateChanges().listen(
      (user) {
        if (user != null) {
          _loggedIn = true;
        } else {
          _loggedIn = false;
        }
        errorAuthMessage = null;
        notifyListeners();
      },
      onError: (object, stackTrace) {
        errorAuthMessage = object.toString();
        print('Error: $object');
        print('Stack trace: $stackTrace');
        // _loggedIn = false;
        // notifyListeners();
      },
      onDone: () {
        print('Auth state subscription done');
        // notifyListeners();
      },
    );
  }

  // Future<void> signOut() async {
  //   await _authRepository.signOut();
  // }

  @override
  void dispose() {
    _authStateSubscription?.cancel();
    super.dispose();
  }
}
