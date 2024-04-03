// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:news_app/core/error/failures.dart';
import 'package:news_app/features/authentication/domain/repositories/authentication_repository.dart';

import '../remote_data_source/auth_remote_data_source.dart';

class AuthencticationRepositoryImpl implements AuthenticationRepository {
  final AuthRemoteDataSource _authRemoteDataSource;
  final FirebaseAuth _auth;

  AuthencticationRepositoryImpl(
    this._authRemoteDataSource,
    this._auth,
  );
  @override
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  @override
  Future<Either<Failure, User>> signInWithGoogle() async {
    try {
      final result = await _authRemoteDataSource.signInWithGoogle();
      return Right(result);
    } catch (e) {
      return const Left(ServerFailure('Terjadi kesalaha'));
    }
  }

  @override
  Future<void> signOut() async {
    return _authRemoteDataSource.signOut();
  }

  @override
  User currentUsers() {
    return _auth.currentUser!;
  }
}
