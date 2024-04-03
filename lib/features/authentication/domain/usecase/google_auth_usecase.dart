import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../core/error/failures.dart';
import '../repositories/authentication_repository.dart';

class GoogleAuthUseCase {
  final AuthenticationRepository repository;

  GoogleAuthUseCase(this.repository);

  Future<Either<Failure, User>> call() {
    return repository.signInWithGoogle();
  }
}
