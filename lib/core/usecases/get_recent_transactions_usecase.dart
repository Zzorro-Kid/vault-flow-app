import 'package:dartz/dartz.dart';
import 'package:test_app/features/add_transaction/domain/entities/transaction_data.dart';
import 'package:test_app/core/errors/failures.dart';
import 'package:test_app/core/usecases/usecase.dart';
import 'package:test_app/features/home/domain/repositories/home_repository.dart';

class GetRecentTransactionsParams {
  final int limit;

  const GetRecentTransactionsParams({this.limit = 10});
}

class GetRecentTransactionsUseCase
    implements UseCase<List<TransactionData>, GetRecentTransactionsParams> {
  final HomeRepository repository;

  GetRecentTransactionsUseCase(this.repository);

  @override
  Future<Either<Failure, List<TransactionData>>> call(
    GetRecentTransactionsParams params,
  ) async {
    return await repository.getRecentTransactions(limit: params.limit);
  }
}
