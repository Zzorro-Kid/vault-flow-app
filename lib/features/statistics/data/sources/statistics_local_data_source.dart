import 'package:test_app/core/data/sources/base_local_data_source.dart';
import 'package:test_app/core/enums/period_type.dart';
import 'package:test_app/features/transaction/data/models/transaction_data_model.dart';

abstract class StatisticsLocalDataSource {
  Future<List<TransactionDataModel>> getTransactionsByPeriod(String period);
}

class StatisticsLocalDataSourceImpl extends BaseLocalDataSource
    implements StatisticsLocalDataSource {
  StatisticsLocalDataSourceImpl({
    required super.storageService,
    required super.authService,
    required super.exportService,
    required super.financialService,
  });

  @override
  Future<List<TransactionDataModel>> getTransactionsByPeriod(
    String period,
  ) async {
    return executeStorageRead(() async {
      final transactions = await loadTransactionsFromStorage();
      final periodType = PeriodType.fromString(period);
      return filterTransactionsByPeriod(transactions, periodType);
    }, errorMessage: 'Failed to get transactions for period');
  }
}
