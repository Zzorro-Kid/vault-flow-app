import 'package:dartz/dartz.dart';
import 'package:test_app/core/errors/failures.dart';
import 'package:test_app/features/settings/domain/repositories/settings_repository.dart';

class GetUseSystemLanguage {
  final SettingsRepository repository;

  GetUseSystemLanguage(this.repository);

  Future<Either<Failure, bool>> call(String userId) {
    return repository.getUseSystemLanguage(userId);
  }
}
