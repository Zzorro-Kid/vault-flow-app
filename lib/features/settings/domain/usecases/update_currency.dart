import 'package:dartz/dartz.dart';
import 'package:test_app/core/errors/failures.dart';
import 'package:test_app/features/settings/domain/repositories/settings_repository.dart';

class UpdateCurrency {
  final SettingsRepository repository;

  UpdateCurrency(this.repository);

  Future<Either<Failure, void>> call({
    required String userId,
    required String currency,
  }) async {
    return await repository.updateCurrency(userId, currency);
  }
}
