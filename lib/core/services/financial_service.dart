import 'package:test_app/features/transaction/data/models/transaction_data_model.dart';
import 'package:test_app/features/transaction/data/models/financial_summary_data_model.dart';
import 'package:test_app/core/enums/period_type.dart';
import 'package:test_app/core/enums/transaction_type.dart';

class FinancialService {
  final DateTime Function()? getCurrentTime;

  const FinancialService({this.getCurrentTime});

  DateTime get _now => getCurrentTime?.call() ?? DateTime.now();

  FinancialSummaryDataModel calculateFinancialSummary(
    List<TransactionDataModel> transactions,
  ) {
    double totalBalance = 0.0;
    double totalIncome = 0.0;
    double totalExpenses = 0.0;

    for (final transaction in transactions) {
      if (transaction.type == TransactionType.income.value) {
        totalIncome += transaction.amount;
        totalBalance += transaction.amount;
      } else if (transaction.type == TransactionType.expense.value) {
        totalExpenses += transaction.amount;
        totalBalance -= transaction.amount;
      }
    }

    return FinancialSummaryDataModel(
      totalBalance: totalBalance,
      totalIncome: totalIncome,
      totalExpenses: totalExpenses,
    );
  }

  List<TransactionDataModel> filterTransactionsByPeriod(
    List<TransactionDataModel> transactions,
    PeriodType period,
  ) {
    final startDate = _calculateStartDate(period);

    return transactions
        .where(
          (t) =>
              t.date.isAfter(startDate) || t.date.isAtSameMomentAs(startDate),
        )
        .toList();
  }

  DateTime calculateStartDate(PeriodType period) {
    switch (period) {
      case PeriodType.day:
        return DateTime(_now.year, _now.month, _now.day);
      case PeriodType.week:
        final daysToSubtract = _now.weekday - 1;
        final weekStart = _now.subtract(Duration(days: daysToSubtract));
        return DateTime(weekStart.year, weekStart.month, weekStart.day);
      case PeriodType.month:
        return DateTime(_now.year, _now.month, 1);
      case PeriodType.year:
        return DateTime(_now.year, 1, 1);
    }
  }

  DateTime _calculateStartDate(PeriodType period) {
    return calculateStartDate(period);
  }
}
