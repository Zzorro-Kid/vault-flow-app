import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:test_app/core/errors/exceptions.dart';

class AuthService {
  const AuthService();

  String hashPassword(String password) {
    final bytes = utf8.encode(password);
    final hash = sha256.convert(bytes);
    return hash.toString();
  }

  Future<bool> verifyPasswordHash(String password, String storedHash) async {
    try {
      final bytes = utf8.encode(password);
      final hash = sha256.convert(bytes);
      return hash.toString() == storedHash;
    } catch (e) {
      return false;
    }
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
