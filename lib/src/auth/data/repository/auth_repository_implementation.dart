import 'package:dartz/dartz.dart';
import 'package:movie_app/core/error/exceptions.dart';
import 'package:movie_app/core/error/failure.dart';
import 'package:movie_app/core/utils/typedef.dart';
import 'package:movie_app/src/auth/domain/entities/auth_user.dart';
import 'package:movie_app/src/auth/domain/repositories/auth_repository.dart';

import '../datasources/auth_remote_data_source.dart';

class AuthRepositoryImplementation implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepositoryImplementation({required this.authRemoteDataSource});

  // Todo: check if dartz is used correctly in here or not
  @override
  ResultsStream<AuthUser, AuthUser> get authUser {
    return authRemoteDataSource.user.map((authUserModel) {
      if (authUserModel == null) {
        return Left(AuthUser.empty());
      }
      return Right(authUserModel.toEntity());
    });
  }

  @override
  ResultFuture<AuthUser> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final authModel = await authRemoteDataSource.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return Right(authModel.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultVoid signOut() async {
    try {
      await authRemoteDataSource.signOut();
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<AuthUser> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final authModel = await authRemoteDataSource.signUpWithEmailAndPassword(
        name: name,
        email: email,
        password: password,
      );
      return Right(authModel.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }
}
