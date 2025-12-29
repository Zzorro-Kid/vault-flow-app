import 'package:dartz/dartz.dart';
import 'package:test_app/core/data/repositories/base_repository.dart';
import 'package:test_app/core/errors/failures.dart';
import 'package:test_app/core/utils/statistics_calculator.dart';
import 'package:test_app/features/statistics/data/sources/statistics_local_data_source.dart';
import 'package:test_app/features/statistics/domain/entities/statistics_data.dart';
import 'package:test_app/features/statistics/domain/repositories/statistics_repository.dart';

class StatisticsRepositoryImpl extends BaseRepository
    implements StatisticsRepository {
  final StatisticsLocalDataSource localDataSource;

  StatisticsRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, StatisticsData>> getStatistics(String period) async {
    return executeRepositoryCall(() async {
      final transactions = await localDataSource.getTransactionsByPeriod(
        period,
      );
      return StatisticsCalculator.calculateStatistics(transactions, period);
    });
  }
}
