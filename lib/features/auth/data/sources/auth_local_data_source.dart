import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:test_app/core/data/sources/base_local_data_source.dart';
import 'package:test_app/core/secure_prefs.dart';
import 'package:test_app/core/shared_prefs.dart';
import 'package:test_app/features/auth/data/models/auth_state_data_model.dart';

abstract class AuthLocalDataSource {
  Future<AuthStateDataModel> getAuthState();
  Future<void> setPassword(String password);
  Future<bool> verifyPassword(String password);
  Future<bool> hasPassword();
  Future<void> completeFirstLaunch();
  Future<void> clearAuthData();
}

class AuthLocalDataSourceImpl extends BaseLocalDataSource
    implements AuthLocalDataSource {
  final SharedPrefs sharedPrefs;
  final SecurePrefs securePrefs;

  AuthLocalDataSourceImpl({
    required this.sharedPrefs,
    required this.securePrefs,
  });

  @override
  Future<AuthStateDataModel> getAuthState() async {
    return executeStorageRead(
      () async => AuthStateDataModel(
        isFirstLaunch: sharedPrefs.isFirstLaunch,
        hasPassword: sharedPrefs.hasPassword,
      ),
      errorMessage: 'Failed to get auth state',
    );
  }

  @override
  Future<void> setPassword(String password) async {
    return executeStorageWrite(() async {
      final bytes = utf8.encode(password);
      final hash = sha256.convert(bytes);
      final passwordHash = hash.toString();

      await securePrefs.setPasswordHash(passwordHash);
      await sharedPrefs.setHasPassword(true);
    }, errorMessage: 'Failed to set password');
  }

  @override
  Future<bool> verifyPassword(String password) async {
    return executeAuthOperation(() async {
      final storedHash = await securePrefs.passwordHash;

      if (storedHash == null) {
        return false;
      }

      final bytes = utf8.encode(password);
      final hash = sha256.convert(bytes);
      final inputHash = hash.toString();

      return inputHash == storedHash;
    }, errorMessage: 'Failed to verify password');
  }

  @override
  Future<bool> hasPassword() async {
    return executeStorageRead(
      () async => sharedPrefs.hasPassword,
      errorMessage: 'Failed to check password existence',
    );
  }

  @override
  Future<void> completeFirstLaunch() async {
    return executeStorageWrite(
      () => sharedPrefs.setIsFirstLaunch(false),
      errorMessage: 'Failed to complete first launch',
    );
  }

  @override
  Future<void> clearAuthData() async {
    return executeStorageWrite(() async {
      await securePrefs.deletePasswordHash();
      await securePrefs.deleteEncryptionKey();
      await securePrefs.deleteTransactions();
      await securePrefs.deleteCategories();
      await sharedPrefs.setHasPassword(false);
      await sharedPrefs.setIsFirstLaunch(true);
    }, errorMessage: 'Failed to clear auth data');
  }
}
