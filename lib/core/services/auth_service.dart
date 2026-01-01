import 'dart:convert';
import 'package:bcrypt/bcrypt.dart';
import 'package:crypto/crypto.dart';
import 'package:test_app/core/errors/exceptions.dart';

class AuthService {
  static const int _saltRounds = 12;

  const AuthService();

  String hashPassword(String password) {
    return BCrypt.hashpw(password, BCrypt.gensalt(logRounds: _saltRounds));
  }

  Future<bool> verifyPasswordHash(String password, String storedHash) async {
    try {
      if (storedHash.startsWith(r'$2')) {
        return BCrypt.checkpw(password, storedHash);
      }

      return _verifyLegacySHA256(password, storedHash);
    } catch (e) {
      return false;
    }
  }

  bool _verifyLegacySHA256(String password, String storedHash) {
    final bytes = utf8.encode(password);
    final hash = sha256.convert(bytes);
    return hash.toString() == storedHash;
  }

  bool isLegacyHash(String hash) {
    return !hash.startsWith(r'$2');
  }

  Future<String?> migrateLegacyHash({
    required String password,
    required String currentHash,
  }) async {
    if (isLegacyHash(currentHash)) {
      if (_verifyLegacySHA256(password, currentHash)) {
        return hashPassword(password);
      }
    }
    return null;
  }

  Future<void> changePasswordWithVerification({
    required String oldPassword,
    required String newPassword,
    required Future<String?> Function() getStoredHash,
    required Future<void> Function(String hash) setNewHash,
  }) async {
    final storedHash = await getStoredHash();

    if (storedHash == null) {
      throw AuthenticationException('No password set');
    }

    final isValid = await verifyPasswordHash(oldPassword, storedHash);
    if (!isValid) {
      throw AuthenticationException('Incorrect old password');
    }

    final newPasswordHash = hashPassword(newPassword);
    await setNewHash(newPasswordHash);
  }
}
