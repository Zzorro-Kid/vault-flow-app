import 'package:dartz/dartz.dart';
import 'package:test_app/core/errors/exceptions.dart';
import 'package:test_app/core/errors/failures.dart';

abstract class BaseRepository {
  Future<Either<Failure, T>> executeRepositoryCall<T>(
    Future<T> Function() call,
  ) async {
    try {
      final result = await call();
      return Right(result);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } on ValidationException catch (e) {
      return Left(ValidationFailure(e.message));
    } on AuthenticationException catch (e) {
      return Left(AuthenticationFailure(e.message));
    } on EncryptionException catch (e) {
      return Left(EncryptionFailure(e.message));
    } on StorageException catch (e) {
      return Left(StorageFailure(e.message));
    } on ExportException catch (e) {
      return Left(ExportFailure(e.message));
    } on ImportException catch (e) {
      return Left(ImportFailure(e.message));
    } catch (e) {
      return Left(CacheFailure('Unexpected error: $e'));
    }
  }
}
