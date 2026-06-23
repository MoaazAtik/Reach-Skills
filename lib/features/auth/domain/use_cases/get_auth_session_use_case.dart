import '../auth_repository.dart';
import '../entities/auth_session.dart';

class GetAuthSessionUseCase {
  final AuthRepository _authRepository;

  GetAuthSessionUseCase(this._authRepository);

  Stream<AuthSession> execute() {
    return _authRepository.authStateChanges.map((user) {
      return AuthSession.fromUser(user);
    });
  }
}
