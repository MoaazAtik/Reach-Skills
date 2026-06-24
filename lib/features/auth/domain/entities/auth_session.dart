import 'app_user.dart';

class AuthSession {
  final AppUser? user;
  final bool isLoggedIn;
  final String? error;

  const AuthSession({this.user, this.isLoggedIn = false, this.error});

  factory AuthSession.authenticated(AppUser user) {
    return AuthSession(user: user, isLoggedIn: true);
  }

  factory AuthSession.unauthenticated() {
    return const AuthSession(isLoggedIn: false);
  }

  factory AuthSession.withError(String error) {
    return AuthSession(error: error, isLoggedIn: false);
  }
}
