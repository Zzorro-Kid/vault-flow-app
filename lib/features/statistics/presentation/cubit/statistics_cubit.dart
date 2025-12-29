import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:test_app/features/statistics/domain/entities/statistics_data.dart';
import 'package:test_app/features/statistics/domain/usecases/get_statistics_usecase.dart';

part 'statistics_state.dart';

class StatisticsCubit extends Cubit<StatisticsState> {
  final GetStatisticsUseCase getStatisticsUseCase;

  StatisticsCubit({required this.getStatisticsUseCase})
    : super(const StatisticsInitial());

  String _currentPeriod = 'month';

  String get currentPeriod => _currentPeriod;

  Future<void> loadStatistics({String? period}) async {
    if (period != null) {
      _currentPeriod = period;
    }

    emit(const StatisticsLoading());

    final result = await getStatisticsUseCase(_currentPeriod);

    result.fold(
      (failure) => emit(StatisticsError(failure.message)),
      (statistics) => emit(StatisticsLoaded(statistics: statistics)),
    );
  }

  Future<void> changePeriod(String period) async {
    await loadStatistics(period: period);
  }

  Future<void> refreshStatistics() async {
    await loadStatistics();
  }
}
