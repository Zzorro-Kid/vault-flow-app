import 'package:dartz/dartz.dart';
import 'package:test_app/core/errors/failures.dart';
import 'package:test_app/features/statistics/domain/entities/statistics_data.dart';

abstract class StatisticsRepository {
  Future<Either<Failure, StatisticsData>> getStatistics(String period);
}
