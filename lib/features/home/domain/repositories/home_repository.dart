import 'package:dartz/dartz.dart';
import 'package:test_app/features/add_transaction/domain/entities/transaction_data.dart';
import 'package:test_app/core/errors/failures.dart';
import 'package:test_app/features/home/domain/entities/dashboard_summary_data.dart';

abstract class HomeRepository {
  Future<Either<Failure, DashboardSummaryData>> getDashboardSummary();
  Future<Either<Failure, List<TransactionData>>> getRecentTransactions({
    int limit = 10,
  });
}
