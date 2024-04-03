import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:news_app/core/error/failures.dart';

abstract class AuthenticationRepository {
  Future<Either<Failure, User>> signInWithGoogle();
  Future<void> signOut();
  User currentUsers();
  Stream<User?> get authStateChanges;
}
