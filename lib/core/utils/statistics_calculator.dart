import 'package:test_app/features/category/data/models/category_data_model.dart';
import 'package:test_app/features/statistics/data/models/category_breakdown_data_model.dart';
import 'package:test_app/features/statistics/data/models/daily_trend_data_model.dart';
import 'package:test_app/features/statistics/data/models/statistics_data_model.dart';
import 'package:test_app/features/transaction/data/models/transaction_data_model.dart';
import 'package:test_app/core/utils/min_heap.dart';

class StatisticsCalculator {
  static final Map<String, StatisticsDataModel> _cache = {};

  static StatisticsDataModel calculateStatistics(
    List<TransactionDataModel> transactions,
    String period,
  ) {
    final cacheKey = '${period}_${transactions.length}';

    if (_cache.containsKey(cacheKey)) {
      return _cache[cacheKey]!;
    }

    final result = _calculateStatisticsInternal(transactions, period);
    _cache[cacheKey] = result;
    return result;
  }

  static void clearCache() {
    _cache.clear();
  }

  static StatisticsDataModel _calculateStatisticsInternal(
    List<TransactionDataModel> transactions,
    String period,
  ) {
    final Map<String, _CategoryAccumulator> categoryMap = {};
    final Map<String, _DailyAccumulator> dailyMap = {};
    double totalIncome = 0.0;
    double totalExpense = 0.0;

    for (final transaction in transactions) {
      if (transaction.type == 'income') {
        totalIncome += transaction.amount;
      } else if (transaction.type == 'expense') {
        totalExpense += transaction.amount;
      }

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

    final balance = totalIncome - totalExpense;
    final totalAmount = categoryMap.values.fold<double>(
      0.0,
      (sum, item) => sum + item.amount,
    );

    final categoryBreakdownHeap = MinHeap<CategoryBreakdownDataModel>(
      maxSize: categoryMap.length,
      compare: (a, b) => a.amount.compareTo(b.amount),
    );

    for (final data in categoryMap.values) {
      final percentage = totalAmount > 0
          ? (data.amount / totalAmount) * 100
          : 0.0;
      categoryBreakdownHeap.add(
        CategoryBreakdownDataModel(
          category: data.category,
          amount: data.amount,
          percentage: percentage,
          transactionCount: data.transactionCount,
        ),
      );
    }

    final categoryBreakdown = categoryBreakdownHeap.toList();

    final dailyTrendsHeap = MinHeap<DailyTrendDataModel>(
      maxSize: dailyMap.length,
      compare: (a, b) => b.date.compareTo(a.date),
    );

    for (final data in dailyMap.values) {
      final dailyBalance = data.income - data.expense;
      dailyTrendsHeap.add(
        DailyTrendDataModel(
          date: data.date,
          income: data.income,
          expense: data.expense,
          balance: dailyBalance,
        ),
      );
    }

    final dailyTrends = dailyTrendsHeap.toList();

    return StatisticsDataModel(
      totalIncome: totalIncome,
      totalExpense: totalExpense,
      balance: balance,
      period: period,
      categoryBreakdown: categoryBreakdown,
      dailyTrends: dailyTrends,
    );
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
