import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/utils/ui_helpers.dart';
import 'package:test_app/core/widgets/custom_app_bar.dart';
import 'package:test_app/core/widgets/loading_indicator.dart';
import 'package:test_app/features/statistics/domain/entities/statistics_data.dart';
import 'package:test_app/features/statistics/presentation/cubit/statistics_cubit.dart';
import 'package:test_app/features/statistics/presentation/widgets/category_breakdown_chart.dart';
import 'package:test_app/features/statistics/presentation/widgets/daily_trend_chart.dart';
import 'package:test_app/features/statistics/presentation/widgets/period_selector.dart';
import 'package:test_app/features/statistics/presentation/widgets/statistics_error_view.dart';
import 'package:test_app/features/statistics/presentation/widgets/statistics_summary_card.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<StatisticsCubit, StatisticsState>(
      listener: (context, state) {
        switch (state) {
          case StatisticsError():
            UiHelpers.showErrorSnackBar(context, state.message);
          default:
            break;
        }
      },
      child: Scaffold(appBar: _buildAppBar(), body: _buildBody()),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return const CustomAppBar(
      title: Text(
        'Statistics',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<StatisticsCubit, StatisticsState>(
      builder: (context, state) {
        return switch (state) {
          StatisticsLoading() => const LoadingIndicator(),
          StatisticsLoaded() => _buildLoadedView(context, state.statistics),
          StatisticsError() => StatisticsErrorView(
            message: state.message,
            onRetry: () => context.read<StatisticsCubit>().loadStatistics(),
          ),
          _ => const SizedBox.shrink(),
        };
      },
    );
  }

  Widget _buildLoadedView(BuildContext context, StatisticsData statistics) {
    return RefreshIndicator(
      onRefresh: () => context.read<StatisticsCubit>().refreshStatistics(),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            PeriodSelector(
              currentPeriod: context.read<StatisticsCubit>().currentPeriod,
              onPeriodChanged: (period) {
                context.read<StatisticsCubit>().changePeriod(period);
              },
            ),
            const SizedBox(height: 16),
            StatisticsSummaryCard(statistics: statistics),
            const SizedBox(height: 16),
            CategoryBreakdownChart(
              categoryBreakdown: statistics.categoryBreakdown,
            ),
            const SizedBox(height: 16),
            DailyTrendChart(dailyTrends: statistics.dailyTrends),
          ],
        ),
      ),
    );
  }
}
