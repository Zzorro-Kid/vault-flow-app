import 'package:flutter/material.dart';
import 'package:test_app/core/constants/app_dimensions.dart';
import 'package:test_app/core/themes/app_colors.dart';
import 'package:test_app/features/statistics/domain/entities/daily_trend_data.dart';
import 'package:test_app/core/utils/chart_calculator.dart';
import 'package:intl/intl.dart';

class DailyTrendChart extends StatelessWidget {
  final List<DailyTrendData> dailyTrends;

  const DailyTrendChart({super.key, required this.dailyTrends});

  @override
  Widget build(BuildContext context) {
    if (dailyTrends.isEmpty) {
      return _buildEmptyState();
    }

    return Container(
      decoration: _buildContainerDecoration(),
      padding: const EdgeInsets.all(AppDimensions.cardPaddingLarge),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitle(),
          const SizedBox(height: AppDimensions.spacingMedium),
          _buildChart(),
          const SizedBox(height: AppDimensions.spacingMedium),
          _buildLegend(),
        ],
      ),
    );
  }

  BoxDecoration _buildContainerDecoration() {
    return BoxDecoration(
      color: AppColors.cardBackground,
      borderRadius: BorderRadius.circular(AppDimensions.radiusXLarge),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          blurRadius: AppDimensions.chartShadowBlurRadius,
          offset: const Offset(0, 2),
        ),
      ],
    );
  }

  Widget _buildTitle() {
    return const Text(
      'Daily Trends',
      style: TextStyle(
        fontSize: AppDimensions.fontSizeXLarge,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimaryLight,
      ),
    );
  }

  Widget _buildChart() {
    if (dailyTrends.isEmpty) return const SizedBox.shrink();

    final maxValue = ChartCalculator.getMaxValue(dailyTrends);

    return SizedBox(
      height: AppDimensions.chartHeight,
      child: _buildChartList(maxValue),
    );
  }

  Widget _buildChartList(double maxValue) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: dailyTrends.length,
      itemBuilder: (context, index) {
        final trend = dailyTrends[index];
        return _buildBar(trend, maxValue, index);
      },
    );
  }

  Widget _buildBar(DailyTrendData trend, double maxValue, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.spacingSmall,
      ),
      child: _buildBarContent(trend, maxValue),
    );
  }

  Widget _buildBarContent(DailyTrendData trend, double maxValue) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        _buildBarPair(trend, maxValue),
        const SizedBox(height: AppDimensions.spacingSmall),
        _buildDateLabel(trend.date),
      ],
    );
  }

  Widget _buildBarPair(DailyTrendData trend, double maxValue) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        _buildIncomeBar(trend.income, maxValue),
        const SizedBox(width: AppDimensions.chartBarSpacing),
        _buildExpenseBar(trend.expense, maxValue),
      ],
    );
  }

  Widget _buildIncomeBar(double income, double maxValue) {
    final height = ChartCalculator.calculateBarHeight(
      income,
      maxValue,
      AppDimensions.chartBarMaxHeight,
    );
    return Container(
      width: AppDimensions.chartBarWidth,
      height: height.clamp(0, AppDimensions.chartBarMaxHeight),
      decoration: _buildIncomeBarDecoration(),
    );
  }

  BoxDecoration _buildIncomeBarDecoration() {
    return BoxDecoration(
      gradient: const LinearGradient(
        colors: [AppColors.incomeStart, AppColors.incomeEnd],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
    );
  }

  Widget _buildExpenseBar(double expense, double maxValue) {
    final height = ChartCalculator.calculateBarHeight(
      expense,
      maxValue,
      AppDimensions.chartBarMaxHeight,
    );
    return Container(
      width: AppDimensions.chartBarWidth,
      height: height.clamp(0, AppDimensions.chartBarMaxHeight),
      decoration: _buildExpenseBarDecoration(),
    );
  }

  BoxDecoration _buildExpenseBarDecoration() {
    return BoxDecoration(
      gradient: const LinearGradient(
        colors: [AppColors.expensesStart, AppColors.expensesEnd],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
    );
  }

  Widget _buildDateLabel(DateTime date) {
    return Text(
      DateFormat('dd').format(date),
      style: const TextStyle(
        fontSize: AppDimensions.fontSizeDateLabel,
        color: AppColors.textSecondaryLight,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildLegend() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildLegendItem('Income', AppColors.incomeStart),
        const SizedBox(width: AppDimensions.legendSpacing),
        _buildLegendItem('Expense', AppColors.expensesStart),
      ],
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      children: [
        _buildLegendColorBox(color),
        const SizedBox(width: AppDimensions.legendItemSpacing),
        _buildLegendLabel(label),
      ],
    );
  }

  Widget _buildLegendColorBox(Color color) {
    return Container(
      width: AppDimensions.legendColorBoxSize,
      height: AppDimensions.legendColorBoxSize,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(AppDimensions.radiusXSmall),
      ),
    );
  }

  Widget _buildLegendLabel(String label) {
    return Text(
      label,
      style: const TextStyle(
        fontSize: AppDimensions.fontSizeLegend,
        color: AppColors.textSecondaryLight,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      decoration: _buildContainerDecoration(),
      padding: const EdgeInsets.all(AppDimensions.emptyStatePadding),
      child: Center(child: _buildEmptyStateContent()),
    );
  }

  Widget _buildEmptyStateContent() {
    return Column(
      children: [
        _buildEmptyStateIcon(),
        const SizedBox(height: AppDimensions.spacingMedium),
        _buildEmptyStateText(),
      ],
    );
  }

  Widget _buildEmptyStateIcon() {
    return const Icon(
      Icons.show_chart,
      size: AppDimensions.emptyStateIconSize,
      color: AppColors.emptyStateIconGrey,
    );
  }

  Widget _buildEmptyStateText() {
    return const Text(
      'No trend data available',
      style: TextStyle(
        fontSize: AppDimensions.fontSizeLarge,
        color: AppColors.emptyStateTextGrey,
      ),
    );
  }
}
