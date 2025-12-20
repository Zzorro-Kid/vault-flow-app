import 'package:dartz/dartz.dart';
import 'package:test_app/core/errors/failures.dart';
import 'package:test_app/features/auth/domain/repositories/auth_repository.dart';

class ClearAuthDataUseCase {
  final AuthRepository repository;

  ClearAuthDataUseCase(this.repository);

  Future<Either<Failure, void>> call() async {
    return await repository.clearAuthData();
  }
}
