import 'package:equatable/equatable.dart';
import 'package:test_app/features/statistics/domain/entities/category_breakdown_data.dart';
import 'package:test_app/features/statistics/domain/entities/daily_trend_data.dart';

class StatisticsData extends Equatable {
  final double totalIncome;
  final double totalExpense;
  final double balance;
  final String period;
  final List<CategoryBreakdownData> categoryBreakdown;
  final List<DailyTrendData> dailyTrends;

  const StatisticsData({
    required this.totalIncome,
    required this.totalExpense,
    required this.balance,
    required this.period,
    required this.categoryBreakdown,
    required this.dailyTrends,
  });

  @override
  List<Object?> get props => [
    totalIncome,
    totalExpense,
    balance,
    period,
    categoryBreakdown,
    dailyTrends,
  ];
}
