import 'package:dartz/dartz.dart';
import 'package:test_app/core/errors/failures.dart';
import 'package:test_app/features/settings/domain/repositories/settings_repository.dart';

class ClearAllData {
  final SettingsRepository repository;

  ClearAllData(this.repository);

  Future<Either<Failure, void>> call() async {
    return await repository.clearAllData();
  }
}
