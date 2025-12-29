import 'package:test_app/features/category/data/models/category_data_model.dart';
import 'package:test_app/features/statistics/data/models/category_breakdown_data_model.dart';
import 'package:test_app/features/statistics/data/models/daily_trend_data_model.dart';
import 'package:test_app/features/statistics/data/models/statistics_data_model.dart';
import 'package:test_app/features/transaction/data/models/transaction_data_model.dart';

class StatisticsCalculator {
  static StatisticsDataModel calculateStatistics(
    List<TransactionDataModel> transactions,
    String period,
  ) {
    double totalIncome = 0.0;
    double totalExpense = 0.0;

    for (final transaction in transactions) {
      if (transaction.type == 'income') {
        totalIncome += transaction.amount;
      } else if (transaction.type == 'expense') {
        totalExpense += transaction.amount;
      }
    }

    final balance = totalIncome - totalExpense;
    final categoryBreakdown = _calculateCategoryBreakdown(transactions);
    final dailyTrends = _calculateDailyTrends(transactions);

    return StatisticsDataModel(
      totalIncome: totalIncome,
      totalExpense: totalExpense,
      balance: balance,
      period: period,
      categoryBreakdown: categoryBreakdown,
      dailyTrends: dailyTrends,
    );
  }

  static List<CategoryBreakdownDataModel> _calculateCategoryBreakdown(
    List<TransactionDataModel> transactions,
  ) {
    final Map<String, _CategoryAccumulator> categoryMap = {};

    for (final transaction in transactions) {
      final category = transaction.category as CategoryDataModel;
      final categoryId = category.id;

      if (categoryMap.containsKey(categoryId)) {
        final existing = categoryMap[categoryId]!;
        categoryMap[categoryId] = _CategoryAccumulator(
          category: category,
          amount: existing.amount + transaction.amount,
          transactionCount: existing.transactionCount + 1,
        );
      } else {
        categoryMap[categoryId] = _CategoryAccumulator(
          category: category,
          amount: transaction.amount,
          transactionCount: 1,
        );
      }
    }

    final totalAmount = categoryMap.values.fold<double>(
      0.0,
      (sum, item) => sum + item.amount,
    );

    return categoryMap.values.map((data) {
      final percentage = totalAmount > 0
          ? (data.amount / totalAmount) * 100
          : 0.0;
      return CategoryBreakdownDataModel(
        category: data.category,
        amount: data.amount,
        percentage: percentage,
        transactionCount: data.transactionCount,
      );
    }).toList()..sort((a, b) => b.amount.compareTo(a.amount));
  }

  static List<DailyTrendDataModel> _calculateDailyTrends(
    List<TransactionDataModel> transactions,
  ) {
    final Map<String, _DailyAccumulator> dailyMap = {};

    for (final transaction in transactions) {
      final dateKey = _formatDateKey(transaction.date);

      if (dailyMap.containsKey(dateKey)) {
        final existing = dailyMap[dateKey]!;
        if (transaction.type == 'income') {
          dailyMap[dateKey] = _DailyAccumulator(
            date: transaction.date,
            income: existing.income + transaction.amount,
            expense: existing.expense,
          );
        } else if (transaction.type == 'expense') {
          dailyMap[dateKey] = _DailyAccumulator(
            date: transaction.date,
            income: existing.income,
            expense: existing.expense + transaction.amount,
          );
        }
      } else {
        dailyMap[dateKey] = _DailyAccumulator(
          date: transaction.date,
          income: transaction.type == 'income' ? transaction.amount : 0.0,
          expense: transaction.type == 'expense' ? transaction.amount : 0.0,
        );
      }
    }

    return dailyMap.values.map((data) {
      final balance = data.income - data.expense;
      return DailyTrendDataModel(
        date: data.date,
        income: data.income,
        expense: data.expense,
        balance: balance,
      );
    }).toList()..sort((a, b) => a.date.compareTo(b.date));
  }

  static String _formatDateKey(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
}

class _CategoryAccumulator {
  final CategoryDataModel category;
  final double amount;
  final int transactionCount;

  _CategoryAccumulator({
    required this.category,
    required this.amount,
    required this.transactionCount,
  });
}

class _DailyAccumulator {
  final DateTime date;
  final double income;
  final double expense;

  _DailyAccumulator({
    required this.date,
    required this.income,
    required this.expense,
  });
}
