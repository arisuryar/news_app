import 'package:firebase_auth/firebase_auth.dart';

import '../repositories/authentication_repository.dart';

class AuthStatusUserUseCase {
  final AuthenticationRepository _repository;

  AuthStatusUserUseCase(this._repository);

  Stream<User?> call() {
    return _repository.authStateChanges;
  }
}
