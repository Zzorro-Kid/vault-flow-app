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

  Future<void> clearAll() async {
    await _secureStorage.deleteAll();
  }
}
