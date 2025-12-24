import 'package:dartz/dartz.dart';
import 'package:test_app/core/usecases/usecase.dart';
import 'package:test_app/core/errors/failures.dart';
import 'package:test_app/features/auth/domain/repositories/auth_repository.dart';

class SetPasswordUseCase implements UseCase<void, String> {
  final AuthRepository repository;

  SetPasswordUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(String password) async {
    return await repository.setPassword(password);
  }
}
