import 'package:dartz/dartz.dart';
import 'package:test_app/core/errors/failures.dart';
import 'package:test_app/features/settings/domain/entities/app_info_data.dart';
import 'package:test_app/features/settings/domain/repositories/settings_repository.dart';

class GetAppInfo {
  final SettingsRepository repository;

  GetAppInfo(this.repository);

  Future<Either<Failure, AppInfoData>> call() async {
    return await repository.getAppInfo();
  }
}