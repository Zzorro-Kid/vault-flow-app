import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:test_app/features/transaction/domain/entities/transaction_data.dart';
import 'package:test_app/core/usecases/get_recent_transactions_usecase.dart';
import 'package:test_app/core/usecases/usecase.dart';
import 'package:test_app/features/home/domain/entities/dashboard_summary_data.dart';
import 'package:test_app/features/home/domain/usecases/get_dashboard_summary_usecase.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetDashboardSummaryUseCase getDashboardSummaryUseCase;
  final GetRecentTransactionsUseCase getRecentTransactionsUseCase;

  HomeCubit({
    required this.getDashboardSummaryUseCase,
    required this.getRecentTransactionsUseCase,
  }) : super(const HomeInitial());

  Future<void> loadHomeData() async {
    emit(const HomeLoading());

    final summaryResult = await getDashboardSummaryUseCase(NoParams());
    final transactionsResult = await getRecentTransactionsUseCase(
      const GetRecentTransactionsParams(limit: 10),
    );

    summaryResult.fold((failure) => emit(HomeError(failure.message)), (
      summary,
    ) {
      transactionsResult.fold(
        (failure) => emit(HomeError(failure.message)),
        (transactions) => emit(
          HomeLoaded(summary: summary, recentTransactions: transactions),
        ),
      );
    });
  }

  Future<void> refreshHomeData() async {
    await loadHomeData();
  }
}
