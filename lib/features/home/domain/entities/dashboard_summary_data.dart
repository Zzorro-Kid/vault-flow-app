import 'package:equatable/equatable.dart';

class DashboardSummaryData extends Equatable {
  final double totalBalance;
  final double totalIncome;
  final double totalExpenses;

  const DashboardSummaryData({
    required this.totalBalance,
    required this.totalIncome,
    required this.totalExpenses,
  });

  @override
  List<Object?> get props => [totalBalance, totalIncome, totalExpenses];
}
