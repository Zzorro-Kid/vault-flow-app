import 'package:test_app/core/data/sources/base_local_data_source.dart';
import 'package:test_app/core/secure_prefs.dart';
import 'package:test_app/features/transaction/data/models/transaction_data_model.dart';

abstract class StatisticsLocalDataSource {
  Future<List<TransactionDataModel>> getTransactionsByPeriod(String period);
}

class StatisticsLocalDataSourceImpl extends BaseLocalDataSource
    implements StatisticsLocalDataSource {
  @override
  final SecurePrefs securePrefs;

  StatisticsLocalDataSourceImpl({required this.securePrefs});

  @override
  Future<List<TransactionDataModel>> getTransactionsByPeriod(
    String period,
  ) async {
    return executeStorageRead(() async {
      final transactions = await loadTransactionsFromStorage();
      return filterTransactionsByPeriod(transactions, period);
    }, errorMessage: 'Failed to get transactions for period');
  }
}
