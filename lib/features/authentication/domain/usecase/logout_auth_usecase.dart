import '../repositories/authentication_repository.dart';

class LogoutAuthUseCase {
  final AuthenticationRepository _repository;

  LogoutAuthUseCase(this._repository);

  Future<void> call() {
    return _repository.signOut();
  }
}
