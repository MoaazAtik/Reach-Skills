import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

abstract class AuthRepository {
  Stream<User?>? get currentUserStream;

  ValueNotifier<bool> get isLoggedIn;

  void subscribeToAuthStateChanges();

  void unsubscribeFromAuthStateChanges();

  Future<void> signOut();

  String? getUserId();

  String? getUserEmail();
}
