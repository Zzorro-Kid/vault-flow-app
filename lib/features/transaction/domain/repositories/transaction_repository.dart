import 'package:dartz/dartz.dart';
import 'package:test_app/core/errors/failures.dart';
import 'package:test_app/features/transaction/domain/entities/transaction_data.dart';

abstract class TransactionRepository {
  Future<Either<Failure, List<TransactionData>>> getAllTransactions();
  Future<Either<Failure, void>> addTransaction(TransactionData transaction);
  Future<Either<Failure, void>> updateTransaction(TransactionData transaction);
  Future<Either<Failure, void>> deleteTransaction(String transactionId);
}
