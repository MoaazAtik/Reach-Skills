import 'package:firebase_auth/firebase_auth.dart';

class AuthSession {
  final User? user;
  final bool isLoggedIn;
  final String? error;

  AuthSession({this.user, this.isLoggedIn = false, this.error});

  factory AuthSession.fromUser(User? user) {
    return AuthSession(user: user, isLoggedIn: user != null);
  }

  factory AuthSession.withError(String error) {
    return AuthSession(error: error, isLoggedIn: false);
  }
}
