import '../auth_repository.dart';
import '../entities/app_user.dart';
import '../entities/auth_session.dart';

class GetAuthSessionUseCase {
  final AuthRepository _authRepository;

  GetAuthSessionUseCase(this._authRepository);

  Stream<AuthSession> execute() {
    return _authRepository.authStateChanges.map((user) {
      if (user == null) {
        return AuthSession.unauthenticated();
      }

      final appUser = AppUser(
        uid: user.uid,
        email: user.email,
        displayName: user.displayName,
        photoURL: user.photoURL,
      );

      return AuthSession.authenticated(appUser);
    });
  }
}
