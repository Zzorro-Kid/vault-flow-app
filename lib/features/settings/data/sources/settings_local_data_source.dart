import 'package:test_app/core/data/sources/base_local_data_source.dart';
import 'package:test_app/core/secure_prefs.dart';
import 'package:test_app/core/services/storage_service.dart';
import 'package:test_app/core/services/auth_service.dart';
import 'package:test_app/core/services/export_service.dart';
import 'package:test_app/features/settings/data/models/user_settings_data_model.dart';

abstract class SettingsLocalDataSource {
  Future<UserSettingsDataModel> getUserSettings(String userId);
  Future<void> saveUserSettings(UserSettingsDataModel settings);
  Future<void> updateCurrency(String userId, String currency);
  Future<void> updateReportFrequency(String userId, String frequency);
  Future<void> changePassword(String oldPassword, String newPassword);
  Future<String> exportDataToCSV(String userId);
  Future<String> exportDataToPDF(String userId);
  Future<void> clearOldData(String userId, DateTime beforeDate);
  Future<void> clearAllData();
}

class SettingsLocalDataSourceImpl extends BaseLocalDataSource
    implements SettingsLocalDataSource {
  final SecurePrefs securePrefs;
  final StorageService storageService;
  final AuthService authService;
  final ExportService exportService;

  static const String _defaultCurrency = 'USD';
  static const String _defaultReportFrequency = 'monthly';

  SettingsLocalDataSourceImpl({
    required this.securePrefs,
    required this.storageService,
    required this.authService,
    required this.exportService,
  });

  @override
  Future<UserSettingsDataModel> getUserSettings(String userId) async {
    return executeStorageRead(() async {
      final settings = await storageService.loadModel<UserSettingsDataModel>(
        userId: userId,
        getter: securePrefs.getUserSettings,
        fromJson: UserSettingsDataModel.fromJson,
      );

      return settings ??
          UserSettingsDataModel(
            userId: userId,
            currency: _defaultCurrency,
            reportFrequency: _defaultReportFrequency,
          );
    }, errorMessage: 'Failed to get user settings');
  }

  @override
  Future<void> saveUserSettings(UserSettingsDataModel settings) async {
    return executeStorageWrite(() async {
      await storageService.saveModel<UserSettingsDataModel>(
        userId: settings.userId,
        model: settings,
        setter: securePrefs.setUserSettings,
        toJson: (model) => model.toJson(),
      );
    }, errorMessage: 'Failed to save user settings');
  }

  @override
  Future<void> updateCurrency(String userId, String currency) async {
    return executeStorageWrite(() async {
      await storageService.updateModelField<UserSettingsDataModel>(
        userId: userId,
        getter: getUserSettings,
        saver: saveUserSettings,
        updater: (model) => model.copyWith(currency: currency),
      );
    }, errorMessage: 'Failed to update currency');
  }

  @override
  Future<void> updateReportFrequency(String userId, String frequency) async {
    return executeStorageWrite(() async {
      await storageService.updateModelField<UserSettingsDataModel>(
        userId: userId,
        getter: getUserSettings,
        saver: saveUserSettings,
        updater: (model) => model.copyWith(reportFrequency: frequency),
      );
    }, errorMessage: 'Failed to update report frequency');
  }

  @override
  Future<void> changePassword(String oldPassword, String newPassword) async {
    return executeStorageWrite(
      () => authService.changePasswordWithVerification(
        oldPassword: oldPassword,
        newPassword: newPassword,
        getStoredHash: () => securePrefs.passwordHash,
        setNewHash: securePrefs.setPasswordHash,
      ),
      errorMessage: 'Failed to change password',
    );
  }

  @override
  Future<String> exportDataToCSV(String userId) async {
    return executeStorageRead(() async {
      final transactions = await storageService.loadTransactions();
      return await exportService.exportTransactionsToCSV(
        transactions: transactions,
        filePrefix: 'transactions',
      );
    }, errorMessage: 'Failed to export data to CSV');
  }

  @override
  Future<String> exportDataToPDF(String userId) async {
    return executeStorageRead(() async {
      final transactions = await storageService.loadTransactions();
      return await exportService.exportTransactionsToPDF(
        transactions: transactions,
        filePrefix: 'transactions',
      );
    }, errorMessage: 'Failed to export data to PDF');
  }

  @override
  Future<void> clearOldData(String userId, DateTime beforeDate) async {
    return executeStorageWrite(() async {
      final transactions = await storageService.loadTransactions();
      final filteredTransactions = transactions
          .where((t) => t.date.isAfter(beforeDate))
          .toList();
      await storageService.saveTransactions(filteredTransactions);
    }, errorMessage: 'Failed to clear old data');
  }

  @override
  Future<void> clearAllData() async {
    return executeStorageWrite(
      () => storageService.clearAll(),
      errorMessage: 'Failed to clear all data',
    );
  }
}
