import 'package:dartz/dartz.dart';
import 'package:test_app/core/errors/failures.dart';
import 'package:test_app/features/settings/domain/repositories/settings_repository.dart';

class GetAppLanguage {
  final SettingsRepository repository;

  GetAppLanguage(this.repository);

  Future<Either<Failure, String>> call(String userId) {
    return repository.getAppLanguage(userId);
  }
}
