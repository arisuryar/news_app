import 'package:firebase_auth/firebase_auth.dart';
import 'package:news_app/features/authentication/domain/repositories/authentication_repository.dart';

class CurrentUserUseCase {
  final AuthenticationRepository _repository;

  CurrentUserUseCase(this._repository);

  User call() => _repository.currentUsers();
}
