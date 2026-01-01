import 'package:dartz/dartz.dart';
import 'package:test_app/core/errors/failures.dart';
import 'package:test_app/features/settings/domain/repositories/settings_repository.dart';

class ChangePassword {
  final SettingsRepository repository;

  ChangePassword(this.repository);

  Future<Either<Failure, void>> call({
    required String userId,
    required String oldPassword,
    required String newPassword,
  }) async {
    return await repository.changePassword(userId, oldPassword, newPassword);
  }
}