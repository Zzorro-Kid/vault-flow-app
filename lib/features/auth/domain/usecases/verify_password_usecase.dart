import 'package:dartz/dartz.dart';
import 'package:test_app/core/usecases/usecase.dart';
import 'package:test_app/core/errors/failures.dart';
import 'package:test_app/features/auth/domain/repositories/auth_repository.dart';

class VerifyPasswordUseCase implements UseCase<bool, String> {
  final AuthRepository repository;

  VerifyPasswordUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> call(String password) async {
    return await repository.verifyPassword(password);
  }
}
