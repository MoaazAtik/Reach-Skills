import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Stream<User?>? get currentUserStream;

  Stream<bool> get isLoggedIn;

  /*
  Todo replace Stream objects above with ValueNotifier,
  OR ReplySubject to replay all previously emitted values to new listeners,
  or BehaviorSubject to always hold the last emitted value.

  Stream doesn't provide the previously emitted values to new listeners.

  Options: ValueNotifier, ReplySubject, BehaviorSubject.
  */

  void subscribeToAuthStateChanges();

  void unsubscribeFromAuthStateChanges();

  Future<void> signOut();

  String? getUserId();

  String? getUserEmail();
}
