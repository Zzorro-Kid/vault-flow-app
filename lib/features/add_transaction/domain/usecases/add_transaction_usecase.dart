import 'package:dartz/dartz.dart';
import 'package:test_app/core/errors/failures.dart';
import 'package:test_app/features/add_transaction/domain/entities/transaction_data.dart';
import 'package:test_app/features/add_transaction/domain/repositories/transaction_repository.dart';

class AddTransactionUseCase {
  final TransactionRepository repository;

  AddTransactionUseCase(this.repository);

  Future<Either<Failure, void>> call(TransactionData transaction) async {
    return await repository.addTransaction(transaction);
  }
}
