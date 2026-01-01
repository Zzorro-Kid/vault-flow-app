import 'package:dartz/dartz.dart';
import 'package:test_app/core/errors/failures.dart';
import 'package:test_app/features/settings/domain/repositories/settings_repository.dart';

class ExportDataToPDF {
  final SettingsRepository repository;

  ExportDataToPDF(this.repository);

  Future<Either<Failure, String>> call(String userId) async {
    return await repository.exportDataToPDF(userId);
  }
}
