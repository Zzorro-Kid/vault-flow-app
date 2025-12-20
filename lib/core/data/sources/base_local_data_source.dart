import 'package:test_app/core/errors/exceptions.dart';

abstract class BaseLocalDataSource {
  Future<T> executeDataSourceCall<T>(
    Future<T> Function() call, {
    String? errorMessage,
  }) async {
    try {
      return await call();
    } catch (e) {
      final message = errorMessage ?? 'Operation failed';
      throw CacheException('$message: $e');
    }
  }

  Future<void> executeStorageWrite(
    Future<void> Function() call, {
    String? errorMessage,
  }) async {
    try {
      await call();
    } catch (e) {
      final message = errorMessage ?? 'Storage write failed';
      throw StorageException('$message: $e');
    }
  }

  Future<T> executeStorageRead<T>(
    Future<T> Function() call, {
    String? errorMessage,
  }) async {
    try {
      return await call();
    } catch (e) {
      final message = errorMessage ?? 'Storage read failed';
      throw CacheException('$message: $e');
    }
  }

  Future<T> executeAuthOperation<T>(
    Future<T> Function() call, {
    String? errorMessage,
  }) async {
    try {
      return await call();
    } catch (e) {
      final message = errorMessage ?? 'Authentication operation failed';
      throw AuthenticationException('$message: $e');
    }
  }

  Future<T> executeEncryptionOperation<T>(
    Future<T> Function() call, {
    String? errorMessage,
  }) async {
    try {
      return await call();
    } catch (e) {
      final message = errorMessage ?? 'Encryption operation failed';
      throw EncryptionException('$message: $e');
    }
  }
}
