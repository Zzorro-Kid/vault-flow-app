import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/constants/app_dimensions.dart';
import 'package:test_app/core/constants/app_colors.dart';
import 'package:test_app/core/utils/ui_helpers.dart';
import 'package:test_app/core/widgets/bottom_navigation_bar.dart';
import 'package:test_app/core/widgets/custom_app_bar.dart';
import 'package:test_app/core/widgets/loading_indicator.dart';
import 'package:test_app/features/statistics/domain/entities/statistics_data.dart';
import 'package:test_app/features/statistics/presentation/cubit/statistics_cubit.dart';
import 'package:test_app/features/statistics/presentation/widgets/category_breakdown_chart.dart';
import 'package:test_app/features/statistics/presentation/widgets/daily_trend_chart.dart';
import 'package:test_app/features/statistics/presentation/widgets/period_selector.dart';
import 'package:test_app/features/statistics/presentation/widgets/statistics_error_view.dart';
import 'package:test_app/features/statistics/presentation/widgets/statistics_summary_card.dart';
import 'package:test_app/injection_container.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<StatisticsCubit>()..loadStatistics(),
      child: BlocListener<StatisticsCubit, StatisticsState>(
        listener: (context, state) {
          switch (state) {
            case StatisticsError():
              UiHelpers.showErrorSnackBar(context, state.message);
            default:
              break;
          }
        },
        child: Scaffold(
          appBar: _buildAppBar(),
          body: _buildBody(),
          bottomNavigationBar: const AppBottomNavigationBar(currentIndex: 3),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return CustomAppBar(
      height: AppDimensions.appBarHeightOther,
      title: _buildAppBarTitle(),
    );
  }

  Widget _buildAppBarTitle() {
    return Transform.translate(
      offset: const Offset(0, AppDimensions.appBarTitleOffsetY),
      child: _buildAppBarTitleText(),
    );
  }

  Widget _buildAppBarTitleText() {
    return const Text(
      'Statistics',
      style: TextStyle(
        fontSize: AppDimensions.fontSizeXXLarge,
        fontWeight: FontWeight.bold,
        color: AppColors.categoryTitleText,
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
        padding: const EdgeInsets.all(AppDimensions.paddingMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildPeriodSelector(context),
            const SizedBox(height: AppDimensions.spacingMedium),
            StatisticsSummaryCard(statistics: statistics),
            const SizedBox(height: AppDimensions.spacingMedium),
            _buildCategoryBreakdown(statistics),
            const SizedBox(height: AppDimensions.spacingMedium),
            DailyTrendChart(dailyTrends: statistics.dailyTrends),
          ],
        ),
      ),
    );
  }

  Widget _buildPeriodSelector(BuildContext context) {
    return PeriodSelector(
      currentPeriod: context.read<StatisticsCubit>().currentPeriod,
      onPeriodChanged: (period) {
        context.read<StatisticsCubit>().changePeriod(period);
      },
    );
  }

  Widget _buildCategoryBreakdown(StatisticsData statistics) {
    return CategoryBreakdownChart(
      categoryBreakdown: statistics.categoryBreakdown,
    );
  }
}
