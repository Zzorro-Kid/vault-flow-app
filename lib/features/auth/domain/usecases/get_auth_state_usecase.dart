import 'package:dartz/dartz.dart';
import 'package:test_app/core/domain/usecases/usecase.dart';
import 'package:test_app/core/errors/failures.dart';
import 'package:test_app/features/auth/domain/entities/auth_state_data.dart';
import 'package:test_app/features/auth/domain/repositories/auth_repository.dart';

class GetAuthStateUseCase implements UseCase<AuthStateData, NoParams> {
  final AuthRepository repository;

  GetAuthStateUseCase(this.repository);

  @override
  Future<Either<Failure, AuthStateData>> call(NoParams params) async {
    return await repository.getAuthState();
  }
}
