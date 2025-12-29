import 'package:dartz/dartz.dart';
import 'package:test_app/core/errors/failures.dart';
import 'package:test_app/features/statistics/domain/entities/statistics_data.dart';
import 'package:test_app/features/statistics/domain/repositories/statistics_repository.dart';

class GetStatisticsUseCase {
  final StatisticsRepository repository;

  GetStatisticsUseCase(this.repository);

  Future<Either<Failure, StatisticsData>> call(String period) async {
    return await repository.getStatistics(period);
  }
}
