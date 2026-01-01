import 'package:dartz/dartz.dart';
import 'package:test_app/core/errors/failures.dart';
import 'package:test_app/features/settings/domain/repositories/settings_repository.dart';

class ClearOldData {
  final SettingsRepository repository;

  ClearOldData(this.repository);

  Future<Either<Failure, void>> call({
    required String userId,
    required DateTime beforeDate,
  }) async {
    return await repository.clearOldData(userId, beforeDate);
  }
}
