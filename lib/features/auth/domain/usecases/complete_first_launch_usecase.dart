import 'package:dartz/dartz.dart';
import 'package:test_app/core/errors/failures.dart';
import 'package:test_app/features/auth/domain/repositories/auth_repository.dart';

class CompleteFirstLaunchUseCase {
  final AuthRepository repository;

  CompleteFirstLaunchUseCase(this.repository);

  Future<Either<Failure, void>> call() async {
    return await repository.completeFirstLaunch();
  }
}
