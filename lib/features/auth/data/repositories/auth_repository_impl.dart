import 'package:dartz/dartz.dart';
import 'package:test_app/core/data/repositories/base_repository.dart';
import 'package:test_app/core/errors/failures.dart';
import 'package:test_app/features/auth/data/sources/auth_local_data_source.dart';
import 'package:test_app/features/auth/domain/entities/auth_state_data.dart';
import 'package:test_app/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl extends BaseRepository implements AuthRepository {
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, AuthStateData>> getAuthState() async {
    return executeRepositoryCall(() => localDataSource.getAuthState());
  }

  @override
  Future<Either<Failure, void>> setPassword(String password) async {
    return executeRepositoryCall(() => localDataSource.setPassword(password));
  }

  @override
  Future<Either<Failure, bool>> verifyPassword(String password) async {
    return executeRepositoryCall(
      () => localDataSource.verifyPassword(password),
    );
  }

  @override
  Future<Either<Failure, void>> setBiometricEnabled(bool enabled) async {
    return executeRepositoryCall(
      () => localDataSource.setBiometricEnabled(enabled),
    );
  }

  @override
  Future<Either<Failure, void>> completeFirstLaunch() async {
    return executeRepositoryCall(() => localDataSource.completeFirstLaunch());
  }

  @override
  Future<Either<Failure, void>> clearAuthData() async {
    return executeRepositoryCall(() => localDataSource.clearAuthData());
  }
}
