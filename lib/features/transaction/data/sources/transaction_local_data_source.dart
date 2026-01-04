import 'package:test_app/features/transaction/data/models/transaction_data_model.dart';
import 'package:test_app/core/data/sources/base_local_data_source.dart';
import 'package:test_app/core/services/storage_service.dart';

abstract class TransactionLocalDataSource {
  Future<List<TransactionDataModel>> getTransactions({
    int offset = 0,
    int limit = 50,
    DateTime? startDate,
    DateTime? endDate,
    String? categoryId,
    String? type,
  });
  Future<void> addTransaction(TransactionDataModel transaction);
  Future<void> updateTransaction(TransactionDataModel transaction);
  Future<void> deleteTransaction(String transactionId);
}

class TransactionLocalDataSourceImpl extends BaseLocalDataSource
    implements TransactionLocalDataSource {
  final StorageService storageService;

  TransactionLocalDataSourceImpl({required this.storageService});

  @override
  Future<List<TransactionDataModel>> getTransactions({
    int offset = 0,
    int limit = 50,
    DateTime? startDate,
    DateTime? endDate,
    String? categoryId,
    String? type,
  }) async {
    return executeStorageRead(
      () => storageService.loadTransactions(
        offset: offset,
        limit: limit,
        startDate: startDate,
        endDate: endDate,
        categoryId: categoryId,
        type: type,
      ),
      errorMessage: 'Failed to get transactions',
    );
  }

  @override
  Future<void> addTransaction(TransactionDataModel transaction) async {
    return executeStorageWrite(() async {
      final transactions = await storageService.loadTransactions();
      transactions.add(transaction);
      await storageService.saveTransactions(transactions);
    }, errorMessage: 'Failed to add transaction');
  }

  @override
  Future<void> updateTransaction(TransactionDataModel transaction) async {
    return executeStorageWrite(() async {
      final transactions = await storageService.loadTransactions();
      final index = transactions.indexWhere((t) => t.id == transaction.id);

      if (index != -1) {
        transactions[index] = transaction;
        await storageService.saveTransactions(transactions);
      }
    }, errorMessage: 'Failed to update transaction');
  }

  @override
  Future<void> deleteTransaction(String transactionId) async {
    return executeStorageWrite(() async {
      final transactions = await storageService.loadTransactions();
      transactions.removeWhere((t) => t.id == transactionId);
      await storageService.saveTransactions(transactions);
    }, errorMessage: 'Failed to delete transaction');
  }
}
