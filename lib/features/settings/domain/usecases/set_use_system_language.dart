import 'package:dartz/dartz.dart';
import 'package:test_app/core/errors/failures.dart';
import 'package:test_app/features/settings/domain/repositories/settings_repository.dart';

class SetUseSystemLanguage {
  final SettingsRepository repository;

  SetUseSystemLanguage(this.repository);

  Future<Either<Failure, void>> call(String userId, bool useSystem) {
    return repository.setUseSystemLanguage(userId, useSystem);
  }
}
