import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:test_app/core/constants/app_constants.dart';

class SecurePrefs {
  final FlutterSecureStorage _secureStorage;

  SecurePrefs(this._secureStorage);

  Future<void> setPasswordHash(String hash) async {
    await _secureStorage.write(key: AppConstants.keyPasswordHash, value: hash);
  }

  Future<String?> get passwordHash async {
    return await _secureStorage.read(key: AppConstants.keyPasswordHash);
  }

  Future<void> deletePasswordHash() async {
    await _secureStorage.delete(key: AppConstants.keyPasswordHash);
  }

  Future<void> setEncryptionKey(String key) async {
    await _secureStorage.write(key: AppConstants.keyEncryptionKey, value: key);
  }

  Future<String?> get encryptionKey async {
    return await _secureStorage.read(key: AppConstants.keyEncryptionKey);
  }

  Future<void> deleteEncryptionKey() async {
    await _secureStorage.delete(key: AppConstants.keyEncryptionKey);
  }

  Future<void> setTransactions(String transactionsJson) async {
    await _secureStorage.write(
      key: AppConstants.keyTransactions,
      value: transactionsJson,
    );
  }

  Future<String?> get transactions async {
    return await _secureStorage.read(key: AppConstants.keyTransactions);
  }

  Future<void> deleteTransactions() async {
    await _secureStorage.delete(key: AppConstants.keyTransactions);
  }

  Future<void> setCategories(String categoriesJson) async {
    await _secureStorage.write(
      key: AppConstants.keyCategories,
      value: categoriesJson,
    );
  }

  Future<String?> get categories async {
    return await _secureStorage.read(key: AppConstants.keyCategories);
  }

  Future<void> deleteCategories() async {
    await _secureStorage.delete(key: AppConstants.keyCategories);
  }

  Future<void> setUserSettings(String userId, String settingsJson) async {
    await _secureStorage.write(
      key: '${AppConstants.keyUserSettings}_$userId',
      value: settingsJson,
    );
  }

  Future<String?> getUserSettings(String userId) async {
    return await _secureStorage.read(
      key: '${AppConstants.keyUserSettings}_$userId',
    );
  }

  Future<void> deleteUserSettings(String userId) async {
    await _secureStorage.delete(key: '${AppConstants.keyUserSettings}_$userId');
  }

  Future<void> clearAll() async {
    await _secureStorage.deleteAll();
  }

  Future<void> clearPasswordHashesForMigration() async {
    await _secureStorage.delete(key: AppConstants.keyPasswordHash);
  }
}
