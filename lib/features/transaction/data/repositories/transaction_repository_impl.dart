import 'package:dartz/dartz.dart';
import 'package:test_app/core/data/repositories/base_repository.dart';
import 'package:test_app/core/errors/failures.dart';
import 'package:test_app/features/transaction/data/models/transaction_data_model.dart';
import 'package:test_app/features/transaction/data/sources/transaction_local_data_source.dart';
import 'package:test_app/features/transaction/domain/entities/transaction_data.dart';
import 'package:test_app/features/transaction/domain/repositories/transaction_repository.dart';

class TransactionRepositoryImpl extends BaseRepository
    implements TransactionRepository {
  final TransactionLocalDataSource localDataSource;

  TransactionRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, List<TransactionData>>> getAllTransactions() async {
    return executeRepositoryCall(() => localDataSource.getTransactions());
  }

  @override
  Future<Either<Failure, void>> addTransaction(
    TransactionData transaction,
  ) async {
    return executeRepositoryCall(
      () => localDataSource.addTransaction(
        TransactionDataModel.fromEntity(transaction),
      ),
    );
  }

  @override
  Future<Either<Failure, void>> updateTransaction(
    TransactionData transaction,
  ) async {
    return executeRepositoryCall(
      () => localDataSource.updateTransaction(
        TransactionDataModel.fromEntity(transaction),
      ),
    );
  }

  @override
  Future<Either<Failure, void>> deleteTransaction(String transactionId) async {
    return executeRepositoryCall(
      () => localDataSource.deleteTransaction(transactionId),
    );
  }
}
