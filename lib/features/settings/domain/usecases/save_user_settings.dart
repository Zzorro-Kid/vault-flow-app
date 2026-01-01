import 'package:dartz/dartz.dart';
import 'package:test_app/core/errors/failures.dart';
import 'package:test_app/features/settings/domain/entities/user_settings_data.dart';
import 'package:test_app/features/settings/domain/repositories/settings_repository.dart';

class SaveUserSettings {
  final SettingsRepository repository;

  SaveUserSettings(this.repository);

  Future<Either<Failure, void>> call(UserSettingsData settings) async {
    return await repository.saveUserSettings(settings);
  }
}
