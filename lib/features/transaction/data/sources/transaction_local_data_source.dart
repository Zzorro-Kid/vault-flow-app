import 'package:test_app/features/transaction/data/models/transaction_data_model.dart';
import 'package:test_app/core/data/sources/base_local_data_source.dart';

abstract class TransactionLocalDataSource {
  Future<List<TransactionDataModel>> getAllTransactions();
  Future<void> addTransaction(TransactionDataModel transaction);
  Future<void> updateTransaction(TransactionDataModel transaction);
  Future<void> deleteTransaction(String transactionId);
}

class TransactionLocalDataSourceImpl extends BaseLocalDataSource
    implements TransactionLocalDataSource {
  TransactionLocalDataSourceImpl({
    required super.storageService,
    required super.authService,
    required super.exportService,
    required super.financialService,
  });

  @override
  Future<List<TransactionDataModel>> getAllTransactions() async {
    return executeStorageRead(() async {
      return await super.loadTransactionsFromStorage();
    }, errorMessage: 'Failed to get transactions');
  }

  @override
  Future<void> addTransaction(TransactionDataModel transaction) async {
    return executeStorageWrite(() async {
      final transactions = await super.loadTransactionsFromStorage();
      transactions.add(transaction);
      await saveTransactions(transactions);
    }, errorMessage: 'Failed to add transaction');
  }

  @override
  Future<void> updateTransaction(TransactionDataModel transaction) async {
    return executeStorageWrite(() async {
      final transactions = await super.loadTransactionsFromStorage();
      final index = transactions.indexWhere((t) => t.id == transaction.id);

      if (index != -1) {
        transactions[index] = transaction;
        await saveTransactions(transactions);
      }
    }, errorMessage: 'Failed to update transaction');
  }

  @override
  Future<void> deleteTransaction(String transactionId) async {
    return executeStorageWrite(() async {
      final transactions = await super.loadTransactionsFromStorage();
      transactions.removeWhere((t) => t.id == transactionId);
      await saveTransactions(transactions);
    }, errorMessage: 'Failed to delete transaction');
  }
}
