import 'package:dartz/dartz.dart';
import 'package:test_app/core/errors/failures.dart';
import 'package:test_app/features/settings/domain/entities/user_settings_data.dart';
import 'package:test_app/features/settings/domain/repositories/settings_repository.dart';

class GetUserSettings {
  final SettingsRepository repository;

  GetUserSettings(this.repository);

  Future<Either<Failure, UserSettingsData>> call(String userId) async {
    return await repository.getUserSettings(userId);
  }
}
