import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

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

  final StreamController<bool> _isLoggedInController =
      StreamController<bool>.broadcast();
  Stream<bool> _isLoggedIn = Stream.value(false).asBroadcastStream();

  @override
  Stream<bool> get isLoggedIn => _isLoggedIn;

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
      _isLoggedIn = _isLoggedInController.stream;

      _authStateSubscription = _auth.authStateChanges().listen(
        (user) {
          _currentUserController.sink.add(user);
          _isLoggedInController.sink.add(user != null);
          // _isLoggedIn = Stream.value(user != null).asBroadcastStream();
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

  // @override
  // void subscribeToAuthStateChanges() {
  //   _authStateSubscriptionCount++;
  //
  //   if (_authStateSubscriptionCount <= 1) {
  //     _currentUser = _authStateController.stream;
  //     _isLoggedIn = _authStateController.stream.map((user) => user != null);
  //
  //     _authStateSubscription = _auth.authStateChanges().listen(
  //       (user) {
  //         _authStateController.sink.add(user);
  //         // _isLoggedIn = Stream.value(user != null);
  //       },
  //       onError: ((error, stackTrace) {
  //         _authStateController.addError(error);
  //       }),
  //     );
  //
  //     _authStateController.onCancel = () {
  //       _authStateSubscription?.cancel();
  //     };
  //   }
  // }

  @override
  void unsubscribeFromAuthStateChanges() {
    _authStateSubscriptionCount--;
    if (_authStateSubscriptionCount < 1) {
      _currentUserController.close();
      _isLoggedInController.close();
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
