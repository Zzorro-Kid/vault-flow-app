import 'package:test_app/features/statistics/domain/entities/daily_trend_data.dart';

class ChartCalculator {
  static double getMaxValue(List<DailyTrendData> dailyTrends) {
    if (dailyTrends.isEmpty) return 0;

    double maxIncome = 0;
    double maxExpense = 0;

    for (final trend in dailyTrends) {
      if (trend.income > maxIncome) maxIncome = trend.income;
      if (trend.expense > maxExpense) maxExpense = trend.expense;
    }

    return maxIncome > maxExpense ? maxIncome : maxExpense;
  }

  static double calculateBarHeight(double value, double maxValue, double maxHeight) {
    if (maxValue <= 0) return 0.0;
    return (value / maxValue) * maxHeight;
  }
}
