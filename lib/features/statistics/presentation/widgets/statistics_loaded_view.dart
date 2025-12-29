import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/features/statistics/domain/entities/statistics_data.dart';
import 'package:test_app/features/statistics/presentation/cubit/statistics_cubit.dart';
import 'package:test_app/features/statistics/presentation/widgets/period_selector.dart';
import 'package:test_app/features/statistics/presentation/widgets/statistics_summary_card.dart';
import 'package:test_app/features/statistics/presentation/widgets/category_breakdown_chart.dart';
import 'package:test_app/features/statistics/presentation/widgets/daily_trend_chart.dart';

class StatisticsLoadedView extends StatelessWidget {
  final StatisticsData statistics;

  const StatisticsLoadedView({super.key, required this.statistics});

  @override
  Widget build(BuildContext context) {
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
