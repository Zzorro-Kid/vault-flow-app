import 'package:dartz/dartz.dart';
import 'package:test_app/core/errors/failures.dart';
import 'package:test_app/features/settings/domain/repositories/settings_repository.dart';

class UpdateReportFrequency {
  final SettingsRepository repository;

  UpdateReportFrequency(this.repository);

  Future<Either<Failure, void>> call({
    required String userId,
    required String frequency,
  }) async {
    return await repository.updateReportFrequency(userId, frequency);
  }
}
