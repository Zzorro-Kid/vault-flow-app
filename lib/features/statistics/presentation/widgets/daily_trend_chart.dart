import 'package:flutter/material.dart';
import 'package:test_app/core/themes/app_colors.dart';
import 'package:test_app/features/statistics/domain/entities/daily_trend_data.dart';
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
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Daily Trends',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimaryLight,
            ),
          ),
          const SizedBox(height: 16),
          _buildChart(),
          const SizedBox(height: 16),
          _buildLegend(),
        ],
      ),
    );
  }

  Widget _buildChart() {
    if (dailyTrends.isEmpty) return const SizedBox.shrink();

    final maxValue = _getMaxValue();

    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: dailyTrends.length,
        itemBuilder: (context, index) {
          final trend = dailyTrends[index];
          return _buildBar(trend, maxValue, index);
        },
      ),
    );
  }

  Widget _buildBar(DailyTrendData trend, double maxValue, int index) {
    final incomeHeight = maxValue > 0 ? (trend.income / maxValue) * 160 : 0.0;
    final expenseHeight = maxValue > 0 ? (trend.expense / maxValue) * 160 : 0.0;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Income bar
              Container(
                width: 20,
                height: incomeHeight.clamp(0, 160),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.incomeStart, AppColors.incomeEnd],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(width: 4),
              // Expense bar
              Container(
                width: 20,
                height: expenseHeight.clamp(0, 160),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.expensesStart, AppColors.expensesEnd],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            DateFormat('dd').format(trend.date),
            style: const TextStyle(
              fontSize: 11,
              color: AppColors.textSecondaryLight,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegend() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildLegendItem('Income', AppColors.incomeStart),
        const SizedBox(width: 24),
        _buildLegendItem('Expense', AppColors.expensesStart),
      ],
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            color: AppColors.textSecondaryLight,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(40),
      child: const Center(
        child: Column(
          children: [
            Icon(Icons.show_chart, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'No trend data available',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  double _getMaxValue() {
    double maxIncome = 0;
    double maxExpense = 0;

    for (final trend in dailyTrends) {
      if (trend.income > maxIncome) maxIncome = trend.income;
      if (trend.expense > maxExpense) maxExpense = trend.expense;
    }

    return maxIncome > maxExpense ? maxIncome : maxExpense;
  }
}
