import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object> get props => [message];
}

class CacheFailure extends Failure {
  const CacheFailure(super.message);
}

class ValidationFailure extends Failure {
  const ValidationFailure(super.message);
}

class AuthenticationFailure extends Failure {
  const AuthenticationFailure(super.message);
}

class EncryptionFailure extends Failure {
  const EncryptionFailure(super.message);
}

class StorageFailure extends Failure {
  const StorageFailure(super.message);
}

class BiometricFailure extends Failure {
  const BiometricFailure(super.message);
}

class ExportFailure extends Failure {
  const ExportFailure(super.message);
}

class ImportFailure extends Failure {
  const ImportFailure(super.message);
}