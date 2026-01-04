import 'package:dartz/dartz.dart';
import 'package:test_app/core/errors/failures.dart';
import 'package:test_app/core/data/repositories/base_repository.dart';
import 'package:test_app/features/settings/domain/entities/user_settings_data.dart';
import 'package:test_app/features/settings/domain/entities/app_info_data.dart';
import 'package:test_app/features/settings/domain/repositories/settings_repository.dart';
import 'package:test_app/features/settings/data/sources/settings_local_data_source.dart';
import 'package:test_app/features/settings/data/models/app_info_data_model.dart';
import 'package:test_app/core/constants/app_constants.dart';
import 'package:test_app/features/auth/data/sources/auth_local_data_source.dart';

class SettingsRepositoryImpl extends BaseRepository
    implements SettingsRepository {
  final SettingsLocalDataSource localDataSource;
  final AuthLocalDataSource authLocalDataSource;

  SettingsRepositoryImpl({
    required this.localDataSource,
    required this.authLocalDataSource,
  });

  @override
  Future<Either<Failure, UserSettingsData>> getUserSettings(
    String userId,
  ) async {
    return executeRepositoryCall(() => localDataSource.getUserSettings(userId));
  }

  @override
  Future<Either<Failure, void>> saveUserSettings(
    UserSettingsData settings,
  ) async {
    return executeRepositoryCall(
      () => localDataSource.saveUserSettings(settings as dynamic),
    );
  }

  @override
  Future<Either<Failure, void>> updateCurrency(
    String userId,
    String currency,
  ) async {
    return executeRepositoryCall(
      () => localDataSource.updateCurrency(userId, currency),
    );
  }

  @override
  Future<Either<Failure, void>> updateReportFrequency(
    String userId,
    String frequency,
  ) async {
    return executeRepositoryCall(
      () => localDataSource.updateReportFrequency(userId, frequency),
    );
  }

  @override
  Future<Either<Failure, void>> changePassword(
    String userId,
    String oldPassword,
    String newPassword,
  ) async {
    return executeRepositoryCall(
      () => localDataSource.changePassword(oldPassword, newPassword),
    );
  }

  @override
  Future<Either<Failure, String>> exportDataToCSV(String userId) async {
    return executeRepositoryCall(() => localDataSource.exportDataToCSV(userId));
  }

  @override
  Future<Either<Failure, String>> exportDataToPDF(String userId) async {
    return executeRepositoryCall(() => localDataSource.exportDataToPDF(userId));
  }

  @override
  Future<Either<Failure, void>> clearOldData(
    String userId,
    DateTime beforeDate,
  ) async {
    return executeRepositoryCall(
      () => localDataSource.clearOldData(userId, beforeDate),
    );
  }

  @override
  Future<Either<Failure, void>> clearAllData() async {
    return executeRepositoryCall(() => localDataSource.clearAllData());
  }

  @override
  Future<Either<Failure, AppInfoData>> getAppInfo() async {
    return executeRepositoryCall(() async {
      return AppInfoDataModel(
        version: AppConstants.appVersion,
        buildNumber: '1',
        appName: AppConstants.appName,
      );
    });
  }

  @override
  Future<Either<Failure, void>> logout() async {
    return executeRepositoryCall(() => authLocalDataSource.clearAuthData());
  }

  @override
  Future<Either<Failure, void>> migrateToSHA256() async {
    return executeRepositoryCall(
      () => authLocalDataSource.clearPasswordHashesForMigration(),
    );
  }
}
