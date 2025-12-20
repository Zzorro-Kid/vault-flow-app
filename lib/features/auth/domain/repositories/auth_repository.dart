import 'package:dartz/dartz.dart';
import 'package:test_app/core/errors/failures.dart';
import 'package:test_app/features/auth/domain/entities/auth_state_data.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthStateData>> getAuthState();
  Future<Either<Failure, void>> setPassword(String password);
  Future<Either<Failure, bool>> verifyPassword(String password);
  Future<Either<Failure, void>> setBiometricEnabled(bool enabled);
  Future<Either<Failure, void>> completeFirstLaunch();
  Future<Either<Failure, void>> clearAuthData();
}
