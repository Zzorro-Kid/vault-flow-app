class CacheException implements Exception {
  final String message;
  CacheException(this.message);
}

class ValidationException implements Exception {
  final String message;
  ValidationException(this.message);
}

class AuthenticationException implements Exception {
  final String message;
  AuthenticationException(this.message);
}

class EncryptionException implements Exception {
  final String message;
  EncryptionException(this.message);
}

class StorageException implements Exception {
  final String message;
  StorageException(this.message);
}

class BiometricException implements Exception {
  final String message;
  BiometricException(this.message);
}

class ExportException implements Exception {
  final String message;
  ExportException(this.message);
}

class ImportException implements Exception {
  final String message;
  ImportException(this.message);
}
