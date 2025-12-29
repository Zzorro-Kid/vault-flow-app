import 'package:test_app/features/statistics/domain/entities/daily_trend_data.dart';

class DailyTrendDataModel extends DailyTrendData {
  const DailyTrendDataModel({
    required super.date,
    required super.income,
    required super.expense,
    required super.balance,
  });

  factory DailyTrendDataModel.fromJson(Map<String, dynamic> json) {
    return DailyTrendDataModel(
      date: DateTime.parse(json['date'] as String),
      income: (json['income'] as num).toDouble(),
      expense: (json['expense'] as num).toDouble(),
      balance: (json['balance'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date.toIso8601String(),
      'income': income,
      'expense': expense,
      'balance': balance,
    };
  }

  factory DailyTrendDataModel.fromEntity(DailyTrendData entity) {
    return DailyTrendDataModel(
      date: entity.date,
      income: entity.income,
      expense: entity.expense,
      balance: entity.balance,
    );
  }
}
