import 'package:test_app/features/statistics/data/models/category_breakdown_data_model.dart';
import 'package:test_app/features/statistics/data/models/daily_trend_data_model.dart';
import 'package:test_app/features/statistics/domain/entities/statistics_data.dart';

class StatisticsDataModel extends StatisticsData {
  const StatisticsDataModel({
    required super.totalIncome,
    required super.totalExpense,
    required super.balance,
    required super.period,
    required super.categoryBreakdown,
    required super.dailyTrends,
  });

  factory StatisticsDataModel.fromJson(Map<String, dynamic> json) {
    return StatisticsDataModel(
      totalIncome: (json['totalIncome'] as num).toDouble(),
      totalExpense: (json['totalExpense'] as num).toDouble(),
      balance: (json['balance'] as num).toDouble(),
      period: json['period'] as String,
      categoryBreakdown: (json['categoryBreakdown'] as List<dynamic>)
          .map(
            (item) => CategoryBreakdownDataModel.fromJson(
              item as Map<String, dynamic>,
            ),
          )
          .toList(),
      dailyTrends: (json['dailyTrends'] as List<dynamic>)
          .map(
            (item) =>
                DailyTrendDataModel.fromJson(item as Map<String, dynamic>),
          )
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalIncome': totalIncome,
      'totalExpense': totalExpense,
      'balance': balance,
      'period': period,
      'categoryBreakdown': categoryBreakdown
          .map((item) => (item as CategoryBreakdownDataModel).toJson())
          .toList(),
      'dailyTrends': dailyTrends
          .map((item) => (item as DailyTrendDataModel).toJson())
          .toList(),
    };
  }

  factory StatisticsDataModel.fromEntity(StatisticsData entity) {
    return StatisticsDataModel(
      totalIncome: entity.totalIncome,
      totalExpense: entity.totalExpense,
      balance: entity.balance,
      period: entity.period,
      categoryBreakdown: entity.categoryBreakdown
          .map((item) => CategoryBreakdownDataModel.fromEntity(item))
          .toList(),
      dailyTrends: entity.dailyTrends
          .map((item) => DailyTrendDataModel.fromEntity(item))
          .toList(),
    );
  }
}
