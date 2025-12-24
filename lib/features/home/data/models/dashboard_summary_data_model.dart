import 'package:test_app/features/home/domain/entities/dashboard_summary_data.dart';

class DashboardSummaryDataModel extends DashboardSummaryData {
  const DashboardSummaryDataModel({
    required super.totalBalance,
    required super.totalIncome,
    required super.totalExpenses,
  });

  factory DashboardSummaryDataModel.fromJson(Map<String, dynamic> json) {
    return DashboardSummaryDataModel(
      totalBalance: (json['totalBalance'] as num).toDouble(),
      totalIncome: (json['totalIncome'] as num).toDouble(),
      totalExpenses: (json['totalExpenses'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalBalance': totalBalance,
      'totalIncome': totalIncome,
      'totalExpenses': totalExpenses,
    };
  }

  DashboardSummaryDataModel copyWith({
    double? totalBalance,
    double? totalIncome,
    double? totalExpenses,
  }) {
    return DashboardSummaryDataModel(
      totalBalance: totalBalance ?? this.totalBalance,
      totalIncome: totalIncome ?? this.totalIncome,
      totalExpenses: totalExpenses ?? this.totalExpenses,
    );
  }

  factory DashboardSummaryDataModel.initial() {
    return const DashboardSummaryDataModel(
      totalBalance: 0.0,
      totalIncome: 0.0,
      totalExpenses: 0.0,
    );
  }
}
