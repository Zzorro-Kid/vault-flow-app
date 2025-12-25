import 'package:test_app/core/data/models/transaction_data_model.dart';
import 'package:test_app/core/data/sources/base_local_data_source.dart';
import 'package:test_app/core/secure_prefs.dart';
import 'package:test_app/features/home/data/models/dashboard_summary_data_model.dart';

abstract class HomeLocalDataSource {
  Future<DashboardSummaryDataModel> getDashboardSummary();
  Future<List<TransactionDataModel>> getRecentTransactions({int limit = 10});
}

class HomeLocalDataSourceImpl extends BaseLocalDataSource
    implements HomeLocalDataSource {
  @override
  final SecurePrefs securePrefs;

  HomeLocalDataSourceImpl({required this.securePrefs});

  @override
  Future<DashboardSummaryDataModel> getDashboardSummary() async {
    return executeStorageRead(() async {
      final transactions = await getAllTransactions();
      final summary = calculateFinancialSummary(transactions);

      return DashboardSummaryDataModel(
        totalBalance: summary.totalBalance,
        totalIncome: summary.totalIncome,
        totalExpenses: summary.totalExpenses,
      );
    }, errorMessage: 'Failed to get dashboard summary');
  }

  @override
  Future<List<TransactionDataModel>> getRecentTransactions({
    int limit = 10,
  }) async {
    return executeStorageRead(() async {
      final transactions = await getAllTransactions();

      transactions.sort((a, b) => b.date.compareTo(a.date));

      return transactions.take(limit).toList();
    }, errorMessage: 'Failed to get recent transactions');
  }
}
