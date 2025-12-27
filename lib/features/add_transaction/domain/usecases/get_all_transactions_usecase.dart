import 'package:dartz/dartz.dart';
import 'package:test_app/core/errors/failures.dart';
import 'package:test_app/core/usecases/usecase.dart';
import 'package:test_app/features/add_transaction/domain/entities/transaction_data.dart';
import 'package:test_app/features/add_transaction/domain/repositories/transaction_repository.dart';

class GetAllTransactionsUseCase {
  final TransactionRepository repository;

  GetAllTransactionsUseCase(this.repository);

  Future<Either<Failure, List<TransactionData>>> call(NoParams params) async {
    return await repository.getAllTransactions();
  }
}
