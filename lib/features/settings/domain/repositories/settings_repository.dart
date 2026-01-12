import 'package:dartz/dartz.dart';
import 'package:test_app/core/errors/failures.dart';
import 'package:test_app/features/settings/domain/entities/user_settings_data.dart';
import 'package:test_app/features/settings/domain/entities/app_info_data.dart';

abstract class SettingsRepository {
  Future<Either<Failure, UserSettingsData>> getUserSettings(String userId);
  Future<Either<Failure, void>> saveUserSettings(UserSettingsData settings);
  Future<Either<Failure, void>> updateCurrency(String userId, String currency);
  Future<Either<Failure, void>> updateReportFrequency(
    String userId,
    String frequency,
  );
  Future<Either<Failure, String>> getAppLanguage(String userId);
  Future<Either<Failure, void>> setAppLanguage(
    String userId,
    String languageCode,
  );
  Future<Either<Failure, bool>> getUseSystemLanguage(String userId);
  Future<Either<Failure, void>> setUseSystemLanguage(
    String userId,
    bool useSystem,
  );
  Future<Either<Failure, void>> changePassword(
    String userId,
    String oldPassword,
    String newPassword,
  );
  Future<Either<Failure, String>> exportDataToCSV(String userId);
  Future<Either<Failure, String>> exportDataToPDF(String userId);
  Future<Either<Failure, void>> clearOldData(
    String userId,
    DateTime beforeDate,
  );
  Future<Either<Failure, void>> clearAllData();
  Future<Either<Failure, AppInfoData>> getAppInfo();
  Future<Either<Failure, void>> logout();
  Future<Either<Failure, void>> migrateToSHA256();
}
