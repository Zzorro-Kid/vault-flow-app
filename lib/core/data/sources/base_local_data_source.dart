import 'dart:convert';
import 'package:test_app/core/data/models/financial_summary_data_model.dart';
import 'package:test_app/core/data/models/transaction_data_model.dart';
import 'package:test_app/core/errors/exceptions.dart';
import 'package:test_app/core/secure_prefs.dart';

abstract class BaseLocalDataSource {
  SecurePrefs? get securePrefs => null;
  Future<T> executeDataSourceCall<T>(
    Future<T> Function() call, {
    String? errorMessage,
  }) async {
    try {
      return await call();
    } catch (e) {
      final message = errorMessage ?? 'Operation failed';
      throw CacheException('$message: $e');
    }
  }

  Future<void> executeStorageWrite(
    Future<void> Function() call, {
    String? errorMessage,
  }) async {
    try {
      await call();
    } catch (e) {
      final message = errorMessage ?? 'Storage write failed';
      throw StorageException('$message: $e');
    }
  }

  Future<T> executeStorageRead<T>(
    Future<T> Function() call, {
    String? errorMessage,
  }) async {
    try {
      return await call();
    } catch (e) {
      final message = errorMessage ?? 'Storage read failed';
      throw CacheException('$message: $e');
    }
  }

  Future<T> executeAuthOperation<T>(
    Future<T> Function() call, {
    String? errorMessage,
  }) async {
    try {
      return await call();
    } catch (e) {
      final message = errorMessage ?? 'Authentication operation failed';
      throw AuthenticationException('$message: $e');
    }
  }

  Future<T> executeEncryptionOperation<T>(
    Future<T> Function() call, {
    String? errorMessage,
  }) async {
    try {
      return await call();
    } catch (e) {
      final message = errorMessage ?? 'Encryption operation failed';
      throw EncryptionException('$message: $e');
    }
  }

  Future<List<TransactionDataModel>> getAllTransactions() async {
    if (securePrefs == null) {
      throw Exception('SecurePrefs is not initialized');
    }

    final transactionsJson = await securePrefs!.transactions;

    if (transactionsJson == null || transactionsJson.isEmpty) {
      return [];
    }

    final List<dynamic> jsonList =
        json.decode(transactionsJson) as List<dynamic>;

    return jsonList
        .map(
          (json) => TransactionDataModel.fromJson(json as Map<String, dynamic>),
        )
        .toList();
  }

  FinancialSummaryModel calculateFinancialSummary(
    List<TransactionDataModel> transactions,
  ) {
    double totalBalance = 0.0;
    double totalIncome = 0.0;
    double totalExpenses = 0.0;

    for (final transaction in transactions) {
      if (transaction.type == 'income') {
        totalIncome += transaction.amount;
        totalBalance += transaction.amount;
      } else if (transaction.type == 'expense') {
        totalExpenses += transaction.amount;
        totalBalance -= transaction.amount;
      }
    }

    return FinancialSummaryModel(
      totalBalance: totalBalance,
      totalIncome: totalIncome,
      totalExpenses: totalExpenses,
    );
  }
}
