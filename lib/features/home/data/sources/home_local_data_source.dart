import 'package:test_app/features/transaction/data/models/transaction_data_model.dart';
import 'package:test_app/core/data/sources/base_local_data_source.dart';
import 'package:test_app/core/services/storage_service.dart';
import 'package:test_app/core/services/financial_service.dart';
import 'package:test_app/features/home/data/models/dashboard_summary_data_model.dart';

abstract class HomeLocalDataSource {
  Future<DashboardSummaryDataModel> getDashboardSummary();
  Future<List<TransactionDataModel>> getRecentTransactions({int limit = 10});
}

class HomeLocalDataSourceImpl extends BaseLocalDataSource
    implements HomeLocalDataSource {
  final StorageService storageService;
  final FinancialService financialService;

  HomeLocalDataSourceImpl({
    required this.storageService,
    required this.financialService,
  });

  @override
  Future<DashboardSummaryDataModel> getDashboardSummary() async {
    return executeStorageRead(() async {
      final transactions = await storageService.loadTransactions(limit: 1000);
      final summary = financialService.calculateFinancialSummary(transactions);

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
      return await storageService.loadTransactions(limit: limit);
    }, errorMessage: 'Failed to get recent transactions');
  }
}
