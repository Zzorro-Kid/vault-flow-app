import 'package:test_app/core/data/sources/base_local_data_source.dart';
import 'package:test_app/core/enums/period_type.dart';
import 'package:test_app/core/services/storage_service.dart';
import 'package:test_app/core/services/financial_service.dart';
import 'package:test_app/features/transaction/data/models/transaction_data_model.dart';

abstract class StatisticsLocalDataSource {
  Future<List<TransactionDataModel>> getTransactionsByPeriod(String period);
}

class StatisticsLocalDataSourceImpl extends BaseLocalDataSource
    implements StatisticsLocalDataSource {
  final StorageService storageService;
  final FinancialService financialService;

  StatisticsLocalDataSourceImpl({
    required this.storageService,
    required this.financialService,
  });

  @override
  Future<List<TransactionDataModel>> getTransactionsByPeriod(
    String period,
  ) async {
    return executeStorageRead(() async {
      final transactions = await storageService.loadTransactions();
      final periodType = PeriodType.fromString(period);
      return financialService.filterTransactionsByPeriod(
        transactions,
        periodType,
      );
    }, errorMessage: 'Failed to get transactions for period');
  }
}
