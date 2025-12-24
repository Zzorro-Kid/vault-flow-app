import 'package:dartz/dartz.dart';
import 'package:test_app/core/errors/failures.dart';
import 'package:test_app/core/usecases/usecase.dart';
import 'package:test_app/features/home/domain/entities/dashboard_summary_data.dart';
import 'package:test_app/features/home/domain/repositories/home_repository.dart';

class GetDashboardSummaryUseCase
    implements UseCase<DashboardSummaryData, NoParams> {
  final HomeRepository repository;

  GetDashboardSummaryUseCase(this.repository);

  @override
  Future<Either<Failure, DashboardSummaryData>> call(NoParams params) async {
    return await repository.getDashboardSummary();
  }
}
