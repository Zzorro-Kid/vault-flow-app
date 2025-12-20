import 'package:dartz/dartz.dart';
import 'package:test_app/core/errors/failures.dart';
import 'package:test_app/features/auth/domain/repositories/auth_repository.dart';

class SetBiometricUseCase {
  final AuthRepository repository;

  SetBiometricUseCase(this.repository);

  Future<Either<Failure, void>> call(bool enabled) async {
    return await repository.setBiometricEnabled(enabled);
  }
}
