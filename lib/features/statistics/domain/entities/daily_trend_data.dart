import 'package:equatable/equatable.dart';

class DailyTrendData extends Equatable {
  final DateTime date;
  final double income;
  final double expense;
  final double balance;

  const DailyTrendData({
    required this.date,
    required this.income,
    required this.expense,
    required this.balance,
  });

  @override
  List<Object?> get props => [date, income, expense, balance];
}
