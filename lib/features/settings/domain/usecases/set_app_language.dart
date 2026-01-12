import 'package:dartz/dartz.dart';
import 'package:test_app/core/errors/failures.dart';
import 'package:test_app/features/settings/domain/repositories/settings_repository.dart';

class SetAppLanguage {
  final SettingsRepository repository;

  SetAppLanguage(this.repository);

  Future<Either<Failure, void>> call(String userId, String languageCode) {
    return repository.setAppLanguage(userId, languageCode);
  }
}
