import 'package:dartz/dartz.dart';
import 'package:test_app/core/data/repositories/base_repository.dart';
import 'package:test_app/features/add_transaction/data/models/transaction_data.dart';
import 'package:test_app/core/errors/failures.dart';
import 'package:test_app/features/home/data/sources/home_local_data_source.dart';
import 'package:test_app/features/home/domain/entities/dashboard_summary_data.dart';
import 'package:test_app/features/home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl extends BaseRepository implements HomeRepository {
  final HomeLocalDataSource localDataSource;

  HomeRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, DashboardSummaryData>> getDashboardSummary() async {
    return executeRepositoryCall(() => localDataSource.getDashboardSummary());
  }

  @override
  Future<Either<Failure, List<TransactionData>>> getRecentTransactions({
    int limit = 10,
  }) async {
    return executeRepositoryCall(
      () => localDataSource.getRecentTransactions(limit: limit),
    );
  }
}
